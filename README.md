# bin.nvim
#### bin is a simple neovim plugin to view binary files in a hex editor format using `xxd`.

## [lazy.nvim](https://github.com/folke/lazy.nvim)
```lua
return {
  'newgan/bin.nvim',
  opts = {
    patterns = '*',       -- Use to filter the plugin by filetype eg. *.dll, *.so
    xxd_cols = 32,        -- xxd octets per line
    auto_hex_view = true  -- Opening a binary file automatically views the file in hex view
  }
}
```

### Note: toggling between views will indicate that the file is 'modified' to Neovim, and will prompt you to save unsaved changes on exit.
