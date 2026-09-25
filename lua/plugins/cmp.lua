return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },
    config = function()
      local cmp = require("cmp")

      -- Define o visual do texto fantasma (ghost text) estilo Copilot
      vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })

      cmp.setup({
        completion = {
          -- menu: mostra o menu / menuone: mostra mesmo se só tiver 1 opção / noselect: não seleciona sozinho
          completeopt = "menu,menuone,noselect",
        },
        
        -- Mapeamento de teclas para o menu de autocompletar
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          
          -- Navegar entre as opções do menu (Control + n / Control + p)
          ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          
          -- Forçar o menu a abrir
          ["<C-Space>"] = cmp.mapping.complete(),
          
          -- Fechar o menu sem selecionar nada
          ["<C-e>"] = cmp.mapping.abort(),
          
          -- Confirmar a seleção com o Enter (<CR>)
          ["<CR>"] = cmp.mapping.confirm({ select = false }), 
        }),

        -- Fontes de onde o autocomplete vai puxar as palavras
        sources = cmp.config.sources({
          { name = "nvim_lsp" }, -- Sugestões inteligentes do Mason/LSP
          { name = "path" },     -- Sugere caminhos de arquivos (ex: ./pasta/arquivo.lua)
        }, {
          { name = "buffer" },   -- Sugere palavras que você já digitou nesse mesmo arquivo
        }),

        experimental = {
          -- Ativa o ghost_text (mostra uma prévia cinza antes de você aceitar)
          ghost_text = {
            hl_group = "CmpGhostText",
          },
        },
      })
    end,
  },
}
