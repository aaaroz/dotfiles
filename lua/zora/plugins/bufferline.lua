return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  version = "*",
  opts = {
    options = {
      mode = "tabs",
    },
  },
  config = function()
    require("bufferline").setup({})
    vim.keymap.set(
      "n",
      "<tab>",
      ":BufferLineCycleNext<cr>",
      { noremap = true, silent = true, desc = "Jump to next buffer." }
    )
    vim.keymap.set(
      "n",
      "<s-tab>",
      ":BufferLineCyclePrev<cr>",
      { noremap = true, silent = true, desc = "Jump to previous buffer." }
    )
    vim.keymap.set(
      "n",
      "<leader>x",
      ":bdelete!<cr>",
      { noremap = true, silent = true, desc = "Delete current buffer." }
    )
  end,
}
