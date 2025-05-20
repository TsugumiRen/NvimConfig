return {
    {
        'stevearc/conform.nvim',
        event = { "BufWritePre" },
        cmd = { "ConformInfo" },
        keys = {
            { "Q", function() require("conform").format({ async = true, lsp_format = 'fallback' }) end, mode = { "n", "v"}, desc = "Format document or selection", },
        },
    opts = {
            formatters_by_ft = {
                python = { 'isort', 'autopep8' },
                javascript = { 'prettier' }
            },
            -- No format on save
            -- format_on_save = {
            --     timeout_ms = 500,
            -- },
        },
    },
}
