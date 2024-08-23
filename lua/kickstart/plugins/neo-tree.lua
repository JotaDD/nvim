-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim
return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    { 'nvim-lua/plenary.nvim', lazy = true },
    { 'MunifTanjim/nui.nvim', lazy = true },
  },
  cmd = 'Neotree',
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'Neotree reveal' },

    { 'e', ':Neotree focus filesystem left<CR>', desc = 'Neotree Filesystem' },
    { 'b', ':Neotree focus buffers left<CR>', desc = 'Neotree [B]uffers' },
    { 'g', ':Neotree focus git-status left<CR>', desc = 'Neotree [G]it status' },
  },
  opts = function()
    local git_available = vim.fn.executable 'git' == 1
    local sources = {
      { source = 'filesystem', display_name = ' File' }, -- Nerd Font: nf-fa-folder
      { source = 'buffers', display_name = ' Bufs' }, -- Nerd Font: nf-fa-file
      { source = 'diagnostics', display_name = ' Diagnostic' }, -- Nerd Font: nf-fa-question_circle_o
    }
    if git_available then
      table.insert(sources, 3, { source = 'git_status', display_name = ' Git' }) -- Nerd Font: nf-dev-git
    end
    local opts = {
      enable_git_status = git_available,
      auto_clean_after_session_restore = true,
      close_if_last_window = true,
      soures = { 'filesystem', 'buffers', git_available and 'git_status' or nil },
      source_selector = {
        winbar = true,
        content_layout = 'center',
        sources = sources,
      },
      default_component_configs = {
        indent = {
          padding = 0,
          expander_collapsed = '', -- Nerd Font: nf-oct-chevron_right
          expander_expanded = '', -- Nerd Font: nf-oct-chevron_down
        },
        icon = {
          padding = 1,
          folder_closed = '', -- Nerd Font: nf-fa-folder
          folder_open = '', -- Nerd Font: nf-fa-folder_open
          folder_empty = '', -- Nerd Font: nf-fa-folder
          default = '', -- Nerd Font: nf-fa-file
        },
        modified = { symbol = '●' }, -- Nerd Font: nf-fa-circle
        git_status = {
          symbols = {
            added = '', -- Nerd Font: nf-fa-plus_square
            deleted = '', -- Nerd Font: nf-fa-minus_square
            modified = '', -- Nerd Font: nf-oct-pencil
            renamed = '', -- Nerd Font: nf-oct-arrow_right
            untracked = '', -- Nerd Font: nf-fa-question_circle_o
            ignored = '', -- Nerd Font: nf-oct-eye
            unstaged = '', -- Nerd Font: nf-fa-exclamation_triangle
            staged = '', -- Nerd Font: nf-fa-plus_circle
            conflict = '', -- Nerd Font: nf-dev-git_merge
          },
        },
      },
      commands = {
        system_open = function(state)
          local node = state.tree:get_node()
          local path = node:get_id()
          -- macOs: open file in default application in the background.
          vim.fn.jobstart({ 'xdg-open', '-g', path }, { detach = true })
        end,
      },
      window = {
        width = 30,
        mappings = {
          ['<S-CR>'] = 'system_open',
          -- ['<Space>'] = false,
          ['[b'] = 'prev_source',
          [']b'] = 'next_source',
          -- O = 'system_open',
          -- Y = 'copy_selector',
          -- h = 'parent_or_close',
          -- l = 'child_or_open',
          ['\\'] = 'close_window',
        },
        fuzzy_finder_mappings = {
          ['<C-n>'] = 'move_cursor_down',
          ['<C-p>'] = 'move_cursor_up',
        },
      },
      filesystem = {
        follow_current_file = { enabled = true },
        filtered_items = { hide_gitignored = git_available },
        hijack_netrw_behavior = 'open_current',
        use_libuv_file_watcher = vim.fn.has 'win32' ~= 1,
        --window = {
        --  mappings = {
        --    ['\\'] = 'close_window',
        --  },
        -- },
      },
      event_handlers = {
        {
          event = 'neo_tree_buffer_enter',
          handler = function(_)
            vim.opt_local.signcolumn = 'auto'
            vim.opt_local.foldcolumn = '0'
          end,
        },
      },
    }

    -- if 'telescope.nvim' then
    --   opts.commands.find_in_dir = function(state)
    --     local node = state.tree:get_node()
    --     local path = node.type == 'file' and node:get_parent_id() or node:get_id()
    --     require('telescope.builtin').find_files { cwd = path }
    --   end
    --   opts.window.mappings.F = 'find_in_dir'
    -- end

    -- if 'toggleterm.nvim' then
    --  local function toggleterm_in_direction(state, direction)
    --    local node = state.tree:get_node()
    --    local path = node.type == 'file' and node:get_parent_id() or node:get_id()
    --    require('toggleterm.terminal').Terminal:new({ dir = path, direction = direction }):toggle()
    --  end
    --  local prefix = 'T'
    --  opts.window.mappings[prefix] = { 'show_help', nowait = false, config = { title = 'New Terminal', prefix_key = prefix } }
    -- for suffix, direction in pairs { f = 'float', h = 'horizontal', v = 'vertical' } do
    --    local command = 'toggleterm_' .. direction
    --    opts.commands[command] = function(state)
    --      toggleterm_in_direction(state, direction)
    --     end
    --     opts.window.mappings[prefix .. suffix] = command
    --  end
    --  end

    return opts
  end,
}
