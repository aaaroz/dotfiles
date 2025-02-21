return {
  "NvChad/nvterm",
  config = function()
    require("nvterm").setup()

    -- ini terminal mode
    -- -- toggle floating terminal
    vim.keymap.set("t", "<leader>ti", function()
      require("nvterm.terminal").toggle("float")
    end, {})

    -- toggle terminal horizontal
    vim.keymap.set("t", "<leader>th", function()
      require("nvterm.terminal").toggle("horizontal")
    end, {})

    -- toggle terminal vertical
    vim.keymap.set("t", "<leader>tv", function()
      require("nvterm.terminal").toggle("vertical")
    end, {})

    -- ini normal mode
    -- toggle floating terminal
    vim.keymap.set("n", "<leader>ti", function()
      require("nvterm.terminal").toggle("float")
    end, { desc = "Open floating terminal" })

    -- toggle terminal horizontal
    vim.keymap.set("n", "<leader>th", function()
      require("nvterm.terminal").toggle("horizontal")
    end, { desc = "Open horizontal terminal" })

    -- toggle terminal vertical
    vim.keymap.set("n", "<leader>tv", function()
      require("nvterm.terminal").toggle("vertical")
    end, { desc = "Open vertical terminal" })
  end,
}
