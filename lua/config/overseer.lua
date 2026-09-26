-- 1. Background Task: Docker Compose Up (Runs silently in background)
require("overseer").register_template({
  name = "Docker: Compose Up",
  builder = function()
    return {
      cmd = { "docker" },
      args = { "compose", "up", "-d" },
      condition = {
        callback = function()
          return vim.fn.filereadable("docker-compose.yml") == 1 
              or vim.fn.filereadable("compose.yaml") == 1
        end,
      },
    }
  end,
})

-- 2. Interactive Task: Run Container with Terminal
require("overseer").register_template({
  name = "Docker: Interactive Shell",
  builder = function()
    return {
      cmd = { "docker" },
      args = { "run", "--rm", "-it", "alpine", "sh" },
      components = {
        "open_output",   
        "unique",        
        "default"        
      },
    }
  end,
})

-- 3. Task para fechar e limpar TODOS os contêineres Docker do sistema
require("overseer").register_template({
  name = "Docker: Stop All Containers",
  builder = function()
    return {
      -- Comando para parar todos os contêineres ativos no Docker rodando uma subshell
      cmd = { "sh" },
      args = { "-c", "docker stop $(docker ps -a -q) 2>/dev/null || echo 'Nenhum container rodando.'" },
      components = {
        "open_output", -- Abre o terminal rápido para você ver a confirmação/lista do que foi parado
        "default"
      },
    }
  end,
})