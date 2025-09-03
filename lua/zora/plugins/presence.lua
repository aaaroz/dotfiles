return {
  "vyfor/cord.nvim",
  build = ":Cord update",
  opts = function()
    return {
      editor = {
        client = "neovim",
        tooltip = "Im using neovim, btw.",
        icon = nil,
      },
      display = {
        theme = "default",
        flavor = "dark",
      },
      lazy = {
        -- change default idle icon to keyboard
        icon = require("cord.api.icon").get("keyboard"),
        -- or use another theme's idle icon
        icon = require("cord.api.icon").get("idle", "atom"),
        -- or use another theme's idle icon from a different flavor
        icon = require("cord.api.icon").get("idle", "atom", "light"),
      },
      text = {
        default = nil,
        workspace = function(opts)
          return "In " .. opts.workspace
        end,
        viewing = function(opts)
          return "Viewing " .. opts.filename
        end,
        editing = function(opts)
          return "Writing some code"
        end,
        file_browser = function(opts)
          return "Browsing files in " .. opts.name
        end,
        plugin_manager = function(opts)
          return "Managing plugins in " .. opts.name
        end,
        lsp = function(opts)
          return "Configuring LSP in " .. opts.name
        end,
        docs = function(opts)
          return "Reading " .. opts.name
        end,
        vcs = function(opts)
          return "Committing changes in " .. opts.name
        end,
        notes = function(opts)
          return "Taking notes in " .. opts.name
        end,
        debug = function(opts)
          return "Debugging in " .. opts.name
        end,
        test = function(opts)
          return "Testing in " .. opts.name
        end,
        diagnostics = function(opts)
          return "Fixing problems in " .. opts.name
        end,
        games = function(opts)
          return "Playing " .. opts.name
        end,
        terminal = function(opts)
          return "Running commands in " .. opts.name
        end,
        dashboard = "Home",
      },
    }
  end,
}
