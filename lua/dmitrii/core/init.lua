require("dmitrii.core.options")
require("dmitrii.core.keymaps")

-- For Python files, explicitly enable spell-check in strings
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'python',
  callback = function()
    vim.cmd('syntax spell toplevel')  -- Override syntax restrictions
  end,
})
