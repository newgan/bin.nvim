local M = {}

local api = vim.api

local config = {
    patterns = { "*" }, -- use to filter by filetype eg. *.dll, *.so
    xxd_cols = 32,
    auto_hex_view = true
}

local function is_binary_file(bufnr)
    local lines_to_check = 50
    local lines = api.nvim_buf_get_lines(bufnr, 0, lines_to_check, false)

    for _, line in ipairs(lines) do
        if line:find('\x00') then
            return true
        end
    end

    return false
end

local function to_hex_view(bufnr)
    local cmd = string.format("silent %%!xxd -c %d", config.xxd_cols)
    api.nvim_command(cmd)

    vim.bo[bufnr].filetype = 'xxd'
    vim.b[bufnr].is_hex_view = true

    api.nvim_command('redraw')
end

local function from_hex_view(bufnr)
    if not vim.b[bufnr].is_hex_view then
        return
    end

    local cmd = string.format("silent %%!xxd -r -c %d", config.xxd_cols)
    api.nvim_command(cmd)

    vim.b[bufnr].is_hex_view = false

    api.nvim_command('redraw')
end

function M.toggle_hex()
    local bufnr = api.nvim_get_current_buf()

    if vim.b[bufnr].is_hex_view then
        from_hex_view(bufnr)
        vim.notify("Switched to binary view", vim.log.levels.INFO)
    else
        to_hex_view(bufnr)
        vim.notify("Switched to hex view", vim.log.levels.INFO)
    end
end

local function setup_autocmds()
    local binary_group = api.nvim_create_augroup('BinaryGroup', { clear = true })

    api.nvim_create_autocmd('BufReadPost', {
        group = binary_group,
        pattern = config.patterns,
        callback = function(ev)
            if (is_binary_file(ev.buf)) then
                vim.keymap.set('n', '<leader>bh', M.toggle_hex, { buffer = ev.buf, silent = true })

                api.nvim_buf_create_user_command(ev.buf, 'BinaryHexToggle', function()
                    M.toggle_hex()
                end, { desc = "Toggle hex view for binary file" })

                if (config.auto_hex_view) then
                    to_hex_view(ev.buf)
                end
            end
        end,
        desc = "Setup binary buffer before reading"
    })
end

function M.setup(opts)
    config = vim.tbl_deep_extend("force", config, opts or {})
    setup_autocmds()
end

return M
