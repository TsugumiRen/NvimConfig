return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        -- enabled = false,
        opts = {},
        config = function()
            vim.cmd [[syntax enable]]
            require("tokyonight").setup({
                styles = {
                    comments = { italic = false },
                    keywords = { italic = false },
                },
            })
            vim.cmd [[colorscheme tokyonight-moon]]
        end,
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = false,
        priority = 1000,
        opts = {},
        config = function()
            vim.cmd [[syntax enable]]
            require("catppuccin").setup({
                styles = {
                    comments = {},
                    conditionals = {},
                },
            })
        end,
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 500
        end,
        opts = {},
    },
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        opts = {},
        keys = {
            { "s",     mode = { "n", "x", "o" }, function() require('flash').jump() end,              desc = "Flash" },
            { "S",     mode = { "n", "o", "x" }, function() require('flash').treesitter() end,        desc = "Flash Treesitter" },
            { "r",     mode = "o",               function() require('flash').remote() end,            desc = "Remote Flash" },
            { "R",     mode = { "o", "x" },      function() require('flash').treesitter_search() end, desc = "Treesitter Search" },
            { "<c-s>", mode = { "c" },           function() require('flash').toggle() end,            desc = "Toggle Flash Search" },
        },
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        },
        cmd = "Neotree",
        keys = {
            {
                "<leader>fe",
                function()
                    require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
                end,
                desc = "Explorer NeoTree (cwd)",
            },
            { "<leader>e", "<leader>fe", desc = "Explorer NeoTree (cwd)", remap = true },
        },
        deactivate = function()
            vim.cmd([[Neotree close]])
        end,
        init = function()
            if vim.fn.argc() == 1 then
                local stat = vim.loop.fs_stat(vim.fn.argv(0))
                if stat and stat.type == "directory" then
                    require("neo-tree")
                end
            end
        end,
        opts = {
            sources = { "filesystem", "buffers", "git_status", "document_symbols" },
            open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "Outline" },
            filesystem = {
                bind_to_cwd = false,
                follow_current_file = { enabled = true },
                use_libuv_file_watcher = true,
            },
            window = {
                mappings = {
                    ["<space>"] = "none",
                },
            },
            default_component_configs = {
                indent = {
                    with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
                    expander_collapsed = "",
                    expander_expanded = "",
                    expander_highlight = "NeoTreeExpander",
                },
            },
        },
    },
    {
        "nvim-lualine/lualine.nvim",
        opts = {
            options = {
                theme = "auto",
                globalstatus = true,
                disabled_filetypes = { statusline = { "dashboard", "alpha" } },
            },
            sections = {
                lualine_y = {
                    { "progress", separator = " ",                  padding = { left = 1, right = 0 } },
                    { "location", padding = { left = 0, right = 1 } },
                },
                lualine_z = {
                    function()
                        return os.date("%R")
                    end,
                },
            },
        },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        version = false, -- last release is way too old and doesn't work on Windows
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile" },
        cmd = { "TSUpdateSync" },
        ---@type TSConfig
        opts = {
            highlight = { enable = true },
            indent = { enable = true },
            ensure_installed = {
                "bash",
                "c",
                "cpp",
                "html",
                "javascript",
                "json",
                "lua",
                "luadoc",
                "markdown",
                "markdown_inline",
                "python",
                "regex",
                "tsx",
                "typescript",
                "vim",
                "vimdoc",
                "yaml",
            },
        },
    },
    {
        'numToStr/Comment.nvim',
        opts = {},
        lazy = false,
    },
    {
        "echasnovski/mini.pairs",
        event = "VeryLazy",
        opts = {},
    },
    {
        "echasnovski/mini.surround",
        event = "VeryLazy",
        opts = {
            mappings = {
                add = "gsa",            -- Add surrounding in Normal and Visual modes
                delete = "gsd",         -- Delete surrounding
                find = "gsf",           -- Find surrounding (to the right)
                find_left = "gsF",      -- Find surrounding (to the left)
                highlight = "gsh",      -- Highlight surrounding
                replace = "gsr",        -- Replace surrounding
                update_n_lines = "gsn", -- Update `n_lines`
            },
        },
    },
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        event = "VeryLazy",
    },
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        event = "VeryLazy",
        dependencies = { 'nvim-lua/plenary.nvim' },
        keys = function(self, _)
            local tele_builtin = require('telescope.builtin')
            local mappings = {
                { '<leader>ff',  function() tele_builtin.find_files() end,            desc = 'Telescope find files' },
                { '<leader>/',  function() tele_builtin.live_grep() end,             desc = 'Telescope live grep' },
                { '<leader>fb',  function() tele_builtin.buffers() end,               desc = 'Telescope buffers' },
                { '<leader>fr',  function() tele_builtin.lsp_references() end,        desc = 'Telescope references' },
                { '<leader>fws', function() tele_builtin.lsp_workspace_symbols() end, desc = 'Telescope workspace symbols' },
                { '<leader>fs',  function() tele_builtin.lsp_document_symbols() end,  desc = 'Telescope workspace symbols' },
                { '<leader>fh',  function() tele_builtin.help_tags() end,             desc = 'Telescope help tags' },
                { '<leader>fc', function () tele_builtin.commands() end, desc = 'Telescope commands'},
                { '<leader>fr', function () tele_builtin.oldfiles() end, desc = 'Telescope recent files'},
                { '<leader>ft', function () tele_builtin.builtin() end, desc = 'Telescope builtin pickers'},
            }
            return mappings
        end
    },
    {
        'akinsho/toggleterm.nvim',
        version = "*",
        opts = {},
        keys = {
            { '<c-\\>',     '<cmd>ToggleTerm direction=horizontal<cr>', desc = 'toggle default terminal' },
            { '<leader>tf', '<cmd>ToggleTerm direction=float<cr>',      desc = 'toggle float terminal' },
            { '<leader>th', '<cmd>ToggleTerm direction=horizontal<cr>', desc = 'toggle default terminal' }
        }
    },
    {
        'lewis6991/gitsigns.nvim',
        event = { "BufReadPost", "BufNewFile" },
        opts = {}
    },
}
