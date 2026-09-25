return {
  {
    "catppuccin/nvim",
    lazy = false,    -- 💡 IMPORTANTE: Mudar para false para o tema aplicar ao abrir o nvim
    priority = 1000, -- Garante que o tema carrega antes de qualquer outro plugin
    name = "catppuccin",
    config = function(_, opts)
      local catppuccin = require("catppuccin")
      
      catppuccin.setup(opts)
      
      -- Ativa o tema oficialmente (usando a variante Mocha, que é a mais escura)
      vim.cmd("colorscheme catppuccin-mocha")
    end,
    opts = {
      flavour = "mocha", -- mocha é a variante escura perfeita para customizar
      transparent_background = false, 
      -- 🎨 AQUI ADICIONAMOS A PALETA AVERMELHADA/VINHO
      color_overrides = {
        mocha = {
          base = "#2e070b",     -- Fundo principal (Vinho super escuro)
          mantle = "#2c0b0f",   -- Fundo do Neo-tree e painéis laterais
          crust = "#120a0b",    -- Fundo de statuslines e abas secundárias
          
          surface0 = "#362224", -- Cor da linha atual (CursorLine)
          surface1 = "#4a3033", -- Elementos selecionados em menus
          surface2 = "#5e3e42", -- Bordas e divisores de tela
          
          text = "#f5e0dc",     -- Texto principal (Branco levemente rosado/quente)
          
          -- Substitui os realces principais por tons de vermelho e vermelho-escuro
          red = "#e05f65",      -- Vermelho vivo para erros/alertas importantes
          maroon = "#be5046",   -- Vermelho escuro/tijolo
          peach = "#df8e1d",    -- Detalhes em laranja/quente
          mauve = "#cba6f7",    -- Funções e métodos
          blue = "#e5747a",     -- Substitui o azul por um vermelho pastel nos textos
        },
      },
      
      lsp_styles = {
        underlines = {
          errors = { "undercurl" },
          hints = { "undercurl" },
          warnings = { "undercurl" },
          information = { "undercurl" },
        },
      },
      
      -- Mantive apenas as integrações dos plugins independentes que instalamos juntos
      integrations = {
        cmp = true,
        mason = true,
        neotree = true,
        telescope = true,
        treesitter = true,
      },
    },
  }
}
