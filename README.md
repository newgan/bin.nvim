# bin.nvim
#### bin is a simple neovim plugin to view binary files in a hex editor format using `xxd`.

<img width="959" height="463" alt="image" src="https://github.com/user-attachments/assets/8c6aaf04-0bc7-4a2a-b0d9-1d4cc449fa05" />

## [lazy.nvim](https://github.com/folke/lazy.nvim)
```lua
return {
    'newgan/bin.nvim',
    opts = {
        patterns = '*',       -- Use to filter the plugin by filetype eg. *.dll, *.so
        xxd_cols = 32,        -- xxd octets per line
        auto_hex_view = true, -- Opening a binary file automatically views the file in hex view

        keymap = { lhs = '<leader>bh', mode = 'n', desc = 'Toggle hex view' }
    },
}

```

### Note: toggling between views will indicate that the file is 'modified' to Neovim, and will prompt you to save unsaved changes on exit.
