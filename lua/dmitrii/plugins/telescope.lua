return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")


    local function delete_buf(prompt_bufnr)
      local picker = action_state.get_current_picker(prompt_bufnr)
      local multi_selections = picker:get_multi_selection()

      if next(multi_selections) == nil then
        -- Single selection case
        local selection = action_state.get_selected_entry()
        vim.api.nvim_buf_delete(selection.bufnr, {force = true})
        actions.close(prompt_bufnr)
      else
        -- Multi selection case
        actions.close(prompt_bufnr)
        for _, entry in ipairs(multi_selections) do
          vim.api.nvim_buf_delete(entry.bufnr, {force = true})
        end
      end
    end

    telescope.setup({
      pickers = {
        find_files = {
          hidden = true,
          no_ignore = true,
        },
        live_grep = {
          additional_args = function(opts)
            return {"--hidden", "--no-ignore"}
          end
        },
        grep_string = {
          additional_args = function(opts)
            return {"--hidden", "--no-ignore"}
          end
        },
        buffers = {
          sort_lastused = true,
        }
      },
      defaults = {
        layout_config = {
          horizontal = {
            preview_width = 0.6,
            width = 0.95,
          },
        },
        path_display = { "smart" },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next, -- move to next result
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            ["<C-d>"] = delete_buf,
          },
        },
      },
    })

    telescope.load_extension("fzf")

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
    keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
    keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
    keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
    keymap.set("n", "<leader>fo", ":Telescope lsp_document_symbols<CR>", { desc = "[F]ile [S]tructure" })
    keymap.set("n", "<leader>fb", ":Telescope buffers<CR>", { desc = "Lists open buffers in current neovim instance" })
  end,
}
