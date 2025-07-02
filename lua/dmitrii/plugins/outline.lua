return {
  "hedyhli/outline.nvim",
  lazy = true,
  cmd = { "Outline", "OutlineOpen" },
  keys = { -- Example mapping to toggle outline
    { "<leader>o", "<cmd>Outline<CR>", desc = "Toggle outline" },
  },
  opts = {
    outline_window = {
      width=13,
      auto_jump = true,
      show_numbers = true,
      show_relative_numbers = true,
      wrap = true
    },
    keymaps = {
      goto_location = 'o'
    }
  },
}
