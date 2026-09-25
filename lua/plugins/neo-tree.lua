return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons", -- Responsável pelos ícones de arquivos (js, python, env, etc.)
    },
    lazy = false,
    config = function()
      require("neo-tree").setup({
        -- Configuração global de ícones e símbolos
        default_component_configs = {
          container = {
            enable_character_fade = true,
          },
          indent = {
            indent_size = 2,
            padding = 1, -- Espaçamento entre os níveis
            -- Símbolos das linhas de recuo (guias visuais)
            with_markers = true,
            indent_marker = "│",
            last_indent_marker = "└",
            highlight = "NeoTreeIndentMarker",
            -- Ícones de expandir/recolher pastas (Setas)
            with_expanders = true, -- Altere para true se quiser usar setas
            expander_collapsed = "",
            expander_expanded = "",
            highlight_expander = "NeoTreeExpander",
          },
          icon = {
            folder_closed = "",
            folder_open = "",
            folder_empty = "  ",
            -- O provedor padrão usa o nvim-web-devicons para arquivos
            default = "  ",
            highlight = "NeoTreeFileIcon",
          },
          modified = {
            symbol = "●", -- Ícone para arquivos alterados e não salvos
            highlight = "NeoTreeModified",
          },
          git_status = {
            symbols = {
              -- Ícones de status do Git (modificado, novo, deletado, etc.)
              added     = "✚",
              modified  = "",
              deleted   = "✖",
              renamed   = "  ",
              untracked = "",
              ignored   = "",
              unstaged  = "  ",
              staged    = "",
              conflict  = "",
            },
          },
        },
        filesystem = {
          filtered_items = {
            visible = true,
            hide_dotfiles = false,
            hide_gitignored = false,
          },
        },
      })
    end,
  }
}