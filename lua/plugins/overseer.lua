return {
  {
    "stevearc/overseer.nvim",
    dependencies = { "stevearc/dressing.nvim" },
    opts = {},
    config = function(_, opts)
      local overseer = require("overseer")
      overseer.setup(opts)

      require("config.overseer")
    end,
  }
}
