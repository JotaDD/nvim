-- -- Neo-tree is a Neovim plugin to browse the file system
-- -- https://github.com/nvim-neo-tree/neo-tree.nvim
-- return {
--   'nvim-neo-tree/neo-tree.nvim',
--   version = '*',
--   dependencies = {
--     { 'nvim-lua/plenary.nvim', lazy = true },
--     { 'MunifTanjim/nui.nvim', lazy = true },
--   },
--   cmd = 'Neotree',
--   keys = {
--     { '\\', ':Neotree reveal<CR>', desc = 'Neotree reveal' },
--
--     { 'e', ':Neotree focus filesystem left<CR>', desc = 'Neotree Filesystem' },
--     { 'b', ':Neotree focus buffers left<CR>', desc = 'Neotree [B]uffers' },
--     { 'g', ':Neotree focus git-status left<CR>', desc = 'Neotree [G]it status' },
--   },
--   opts = function()
--     local git_available = vim.fn.executable 'git' == 1
--     local sources = {
--       { source = 'filesystem', display_name = ' File' }, -- Nerd Font: nf-fa-folder
--       { source = 'buffers', display_name = ' Bufs' }, -- Nerd Font: nf-fa-file
--       { source = 'diagnostics', display_name = ' Diagnostic' }, -- Nerd Font: nf-fa-question_circle_o
--     }
--     if git_available then
--       table.insert(sources, 3, { source = 'git_status', display_name = ' Git' }) -- Nerd Font: nf-dev-git
--     end
--     local opts = {
--       enable_git_status = git_available,
--       auto_clean_after_session_restore = true,
--       close_if_last_window = true,
--       soures = { 'filesystem', 'buffers', git_available and 'git_status' or nil },
--       source_selector = {
--         winbar = true,
--         content_layout = 'center',
--         sources = sources,
--       },
--       default_component_configs = {
--         indent = {
--           padding = 0,
--           expander_collapsed = '', -- Nerd Font: nf-oct-chevron_right
--           expander_expanded = '', -- Nerd Font: nf-oct-chevron_down
--         },
--         icon = {
--           padding = 1,
--           folder_closed = '', -- nerd font: nf-fa-folder
--           folder_open = '', -- nerd font: nf-fa-folder_open
--           folder_empty = '', -- nerd font: nf-fa-folder
--           default = '', -- nerd font: nf-fa-file
--         },
--         modified = { symbol = '●' }, -- nerd font: nf-fa-circle
--         git_status = {
--           symbols = {
--             added = '', -- nerd font: nf-fa-plus_square
--             deleted = '', -- nerd font: nf-fa-minus_square
--             modified = '', -- nerd font: nf-oct-pencil
--             renamed = '', -- nerd font: nf-oct-arrow_right
--             untracked = '', -- nerd font: nf-fa-question_circle_o
--             ignored = '', -- nerd font: nf-oct-eye
--             unstaged = '', -- nerd font: nf-fa-exclamation_triangle
--             staged = '', -- nerd font: nf-fa-plus_circle
--             conflict = '', -- nerd font: nf-dev-git_merge
--           },
--         },
--       },
--       commands = {
--         system_open = function(state)
--           local node = state.tree:get_node()
--           local path = node:get_id()
--           -- macos: open file in default application in the background.
--           vim.fn.jobstart({ 'xdg-open', '-g', path }, { detach = true })
--         end,
--       },
--       window = {
--         width = 30,
--         mappings = {
--           ['<s-cr>'] = 'system_open',
--           -- ['<space>'] = false,
--           ['[b'] = 'prev_source',
--           [']b'] = 'next_source',
--           -- o = 'system_open',
--           -- y = 'copy_selector',
--           -- h = 'parent_or_close',
--           -- l = 'child_or_open',
--           ['\\'] = 'close_window',
--         },
--         fuzzy_finder_mappings = {
--           ['<c-n>'] = 'move_cursor_down',
--           ['<c-p>'] = 'move_cursor_up',
--         },
--       },
--       filesystem = {
--         follow_current_file = { enabled = true },
--         filtered_items = { hide_gitignored = git_available },
--         hijack_netrw_behavior = 'open_current',
--         use_libuv_file_watcher = vim.fn.has 'win32' ~= 1,
--         --window = {
--         --  mappings = {
--         --    ['\\'] = 'close_window',
--         --  },
--         -- },
--       },
--       event_handlers = {
--         {
--           event = 'neo_tree_buffer_enter',
--           handler = function(_)
--             vim.opt_local.signcolumn = 'auto'
--             vim.opt_local.foldcolumn = '0'
--           end,
--         },
--       },
--     }
--
--     -- if 'telescope.nvim' then
--     --   opts.commands.find_in_dir = function(state)
--     --     local node = state.tree:get_node()
--     --     local path = node.type == 'file' and node:get_parent_id() or node:get_id()
--     --     require('telescope.builtin').find_files { cwd = path }
--     --   end
--     --   opts.window.mappings.f = 'find_in_dir'
--     -- end
--
--     -- if 'toggleterm.nvim' then
--     --  local function toggleterm_in_direction(state, direction)
--     --    local node = state.tree:get_node()
--     --    local path = node.type == 'file' and node:get_parent_id() or node:get_id()
--     --    require('toggleterm.terminal').terminal:new({ dir = path, direction = direction }):toggle()
--     --  end
--     --  local prefix = 't'
--     --  opts.window.mappings[prefix] = { 'show_help', nowait = false, config = { title = 'new terminal', prefix_key = prefix } }
--     -- for suffix, direction in pairs { f = 'float', h = 'horizontal', v = 'vertical' } do
--     --    local command = 'toggleterm_' .. direction
--     --    opts.commands[command] = function(state)
--     --      toggleterm_in_direction(state, direction)
--     --     end
--     --     opts.window.mappings[prefix .. suffix] = command
--     --  end
--     --  end
--
--     return opts
--   end,
-- }
--
--
--
return {
  'nvim-neo-tree/neo-tree.nvim',
  dependencies = {
    { 'nvim-lua/plenary.nvim', lazy = true },
    { 'muniftanjim/nui.nvim', lazy = true },
  },
  cmd = 'neotree',
  keys = {
    {
      '<leader>fe',
      function()
        require('neo-tree.command').execute { toggle = true, dir = project_root }
      end,
      desc = 'explorer neotree (root dir)',
    },
    {
      '<leader>fe',
      function()
        require('neo-tree.command').execute { toggle = true, dir = vim.uv.cwd() }
      end,
      desc = 'explorer neotree (cwd)',
    },
    { '<leader>e', '<leader>fe', desc = 'explorer neotree (root dir)', remap = true },
    { '<leader>e', '<leader>fe', desc = 'explorer neotree (cwd)', remap = true },
    {
      '<leader>ge',
      function()
        require('neo-tree.command').execute { source = 'git_status', toggle = true }
      end,
      desc = 'git explorer',
    },
    {
      '<leader>be',
      function()
        require('neo-tree.command').execute { source = 'buffers', toggle = true }
      end,
      desc = 'buffer explorer',
    },
  },
  init = function()
    vim.api.nvim_create_autocmd('bufenter', {
      group = vim.api.nvim_create_augroup('neotree_start_directory', { clear = true }),
      desc = 'start neo-tree with directory',
      once = true,
      callback = function()
        if package.loaded['neo-tree'] then
          return
        else
          local stats = vim.uv.fs_stat(vim.fn.argv(0))
          if stats and stats.type == 'directory' then
            require 'neo-tree'
          end
        end
      end,
    })
  end,
  opts = function()
    local do_setcd = function(state)
      local p = state.tree:get_node().path
      print(p) -- show in command line
      vim.cmd(string.format('exec(":lcd %s")', p))
    end

    local git_available = vim.fn.executable 'git' == 1
    local sources = {
      { source = 'filesystem', display_name = ' file' }, -- nerd font: nf-fa-folder
      { source = 'buffers', display_name = ' bufs' }, -- nerd font: nf-fa-file
      { source = 'diagnostics', display_name = ' diagnostic' }, -- nerd font: nf-fa-question_circle_o
    }
    if git_available then
      table.insert(sources, 3, { source = 'git_status', display_name = ' git' }) -- nerd font: nf-dev-git
    end

    local opts = {
      sources = { 'filesystem', 'buffers', 'git_status' },
      enable_git_status = git_available,
      auto_clean_after_session_restore = true,
      close_if_last_window = true,
      soures = { 'filesystem', 'buffers', git_available and 'git_status' or nil },
      source_selector = {
        winbar = true,
        content_layout = 'center',
        sources = sources,
      },

      open_files_do_not_replace_types = { 'terminal', 'Trouble', 'trouble', 'qf', 'Outline' },
      filesystem = {
        bind_to_cwd = false,
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
      },
      window = {
        mappings = {
          ['l'] = 'open',
          ['h'] = 'close_node',
          ['<space>'] = 'none',
          ['Y'] = {
            function(state)
              local node = state.tree:get_node()
              local path = node:get_id()
              vim.fn.setreg('+', path, 'c')
            end,
            desc = 'Copy Path to Clipboard',
          },
          ['O'] = {
            function(state)
              require('lazy.util').open(state.tree:get_node().path, { system = true })
            end,
            desc = 'Open with System Application',
          },
          ['P'] = { 'toggle_preview', config = { use_float = false } },
        },
      },
      default_component_configs = {
        indent = {
          with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
          expander_collapsed = '',
          expander_expanded = '',
          expander_highlight = 'NeoTreeExpander',
        },
        icon = {
          padding = 1,
          folder_closed = '', -- nerd font: nf-fa-folder
          folder_open = '', -- nerd font: nf-fa-folder_open
          folder_empty = '', -- nerd font: nf-fa-folder
          default = '', -- nerd font: nf-fa-file
        },

        git_status = {
          symbols = {
            added = '', -- nerd font: nf-fa-plus_square
            deleted = '', -- nerd font: nf-fa-minus_square
            modified = '', -- nerd font: nf-oct-pencil
            renamed = '', -- nerd font: nf-oct-arrow_right
            untracked = '', -- nerd font: nf-fa-question_circle_o
            ignored = '', -- nerd font: nf-oct-eye
            unstaged = '', -- nerd font: nf-fa-exclamation_triangle
            staged = '', -- nerd font: nf-fa-plus_circle
            conflict = '', -- nerd font: nf-dev-git_merge
          },
        },
      },
      commands = {
        find_files = function(state)
          do_setcd(state)
          require('telescope.builtin').find_files()
        end,
      },
    } -- end opts
    opts.commands.find_in_dir = function(state)
      local node = state.tree:get_node()
      local path = node.type == 'file' and node:get_parent_id() or node:get_id()
      require('telescope.builtin').find_files { cwd = path }
    end
    opts.window.mappings.F = 'find_in_dir'
    return opts
  end,
  config = function(_, opts)
    local function on_move(data)
      vim.lsp.on_rename(data.source, data.destination)
    end

    local events = require 'neo-tree.events'
    opts.event_handlers = opts.event_handlers or {}
    vim.list_extend(opts.event_handlers, {
      { event = events.FILE_MOVED, handler = on_move },
      { event = events.FILE_RENAMED, handler = on_move },
    })
    require('neo-tree').setup(opts)
    vim.api.nvim_create_autocmd('TermClose', {
      pattern = '*lazygit',
      callback = function()
        if package.loaded['neo-tree.sources.git_status'] then
          require('neo-tree.sources.git_status').refresh()
        end
      end,
    })
  end,
}
