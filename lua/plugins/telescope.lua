return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- Filtro fzf nativo super rápido (opcional, tenta carregar se compilado)
      { 
        "nvim-telescope/telescope-fzf-native.nvim", 
        build = "make",
        enabled = vim.fn.executable("make") == 1 
      },
    },
    keys = {
      -- Atalhos Principais
      { "<leader>,", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "Mudar Buffer" },
      { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Histórico de Comandos" },
      { "<leader><space>", "<cmd>Telescope find_files<cr>", desc = "Buscar Arquivos" },
      { "<leader>/", "<cmd>Telescope live_grep<cr>", desc = "Buscar Texto no Projeto" },
      
      -- Abas de busca (Find / prefixo 'f')
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Buscar Arquivos" },
      { "<leader>fb", "<cmd>Telescope buffers ignore_current_buffer=true sort_mru=true<cr>", desc = "Listar Buffers" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Arquivos Recentes" },
      { "<leader>fg", "<cmd>Telescope git_files<cr>", desc = "Arquivos do Git" },
      
      -- Ferramentas de busca interna (Search / prefixo 's')
      { '<leader>s"', "<cmd>Telescope registers<cr>", desc = "Registradores (Clipboard)" },
      { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buscar dentro do Arquivo Atual" },
      { "<leader>sc", "<cmd>Telescope commands<cr>", desc = "Comandos do Neovim" },
      { "<leader>sd", "<cmd>Telescope diagnostics<cr>", desc = "Erros/Avisos do LSP" },
      { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Páginas de Ajuda" },
      { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Atalhos de Teclado" },
      { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Opções do Vim" },
      { "<leader>sw", "<cmd>Telescope grep_string<cr>", desc = "Buscar Palavra sob o Cursor" },
      
      -- Git relacionados
      { "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Commits" },
      { "<leader>gs", "<cmd>Telescope git_status<cr>", desc = "Status do Git" },
    },
    opts = function()
      local actions = require("telescope.actions")

      return {
        defaults = {
          prompt_prefix = "  ",
          selection_caret = " ",
          -- Abre os arquivos na janela atual mais apropriada
          get_selection_window = function()
            local wins = vim.api.nvim_list_wins()
            table.insert(wins, 1, vim.api.nvim_get_current_win())
            for _, win in ipairs(wins) do
              local buf = vim.api.nvim_win_get_buf(win)
              if vim.bo[buf].buftype == "" then
                return win
              end
            end
            return 0
          end,
          mappings = {
            i = {
              ["<C-Down>"] = actions.cycle_history_next,
              ["<C-Up>"] = actions.cycle_history_prev,
              ["<C-f>"] = actions.preview_scrolling_down,
              ["<C-b>"] = actions.preview_scrolling_up,
              ["<C-c>"] = actions.close, -- Fecha a busca
            },
            n = {
              ["q"] = actions.close,
            },
          },
        },
        pickers = {
          find_files = {
            hidden = true, -- Mostra arquivos ocultos (ex: .gitignore, .env) por padrão
          },
        },
      }
    end,
  },
}
