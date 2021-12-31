local M = {}

M.autopairs = function()
   local present1, autopairs = pcall(require, "nvim-autopairs")
   local present2, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")

   if not (present1 or present2) then
      return
   end

   autopairs.setup()

   -- not needed if you disable cmp, the above var related to cmp tooo! override default config for autopairs
   local cmp = require("cmp")
   cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
end

M.comment = function()
   local present, nvim_comment = pcall(require, "nvim_comment")
   if present then
        nvim_comment.setup({
            hook = function()
                require("ts_context_commentstring.internal").update_commentstring()
            end,
        })
   end
end

M.luasnip = function()
    local present, luasnip = pcall(require, "luasnip")
    if not present then
        return
    end

    luasnip.config.set_config {
        history = true,
        updateevents = "TextChanged,TextChangedI",
    }

    require("luasnip/loaders/from_vscode").load()
end

M.lspkind = function()
    local present, lspkind = pcall(require, "lspkind")
    if present then
        lspkind.init({
            -- enables text annotations
            --
            -- default: true
            with_text = true,

            -- default symbol map
            -- can be either 'default' (requires nerd-fonts font) or
            -- 'codicons' for codicon preset (requires vscode-codicons font)
            --
            -- default: 'default'
            preset = 'codicons',
            -- override preset symbols
            --
            -- default: {}
            symbol_map = {
                Text = "",
                Method = "",
                Function = "",
                Constructor = "",
                Field = "ﰠ",
                Variable = "",
                Class = "ﴯ",
                Interface = "",
                Module = "",
                Property = "ﰠ",
                Unit = "塞",
                Value = "",
                Enum = "",
                Keyword = "",
                Snippet = "",
                Color = "",
                File = "",
                Reference = "",
                Folder = "",
                EnumMember = "",
                Constant = "",
                Struct = "פּ",
                Event = "",
                Operator = "",
                TypeParameter = "",
            },
        })
    end
end

M.neoscroll = function()
    pcall(
        function()
            require("neoscroll").setup()
        end
    )
end

M.indentline = function()
    vim.g.indentLine_enabled = 1
    vim.g.indentLine_char = "▏"
end

return M