local present, cmp = pcall(require, "cmp")

if not present then
    return
end

local lspkind = require('lspkind')
local source_mapping = {
    buffer = "[Buffer]",
    nvim_lsp = "[LSP]",
    nvim_lua = "[Lua]",
    cmp_tabnine = "[TN]",
    path = "[Path]",
}

vim.opt.completeopt = "menuone,noselect"

local default = {
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    formatting = {
        format = function(entry, vim_item)
            vim_item.kind = lspkind.presets.default[vim_item.kind]
            
            local menu = source_mapping[entry.source.name]
            if entry.source.name == 'cmp_tabnine' then
                if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
                    menu = entry.completion_item.data.detail .. ' ' .. menu
                end
                vim_item.kind = ''
            end
            vim_item.menu = menu

            return vim_item
        end,
    },
    mapping = {
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        -- ["<Tab>"] = function(fallback)
        --     if cmp.visible() then
        --         cmp.select_next_item()
        --     elseif require("luasnip").expand_or_jumpable() then
        --         vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
        --     else
        --         fallback()
        --     end
        -- end,
        -- ["<S-Tab>"] = function(fallback)
        --     if cmp.visible() then
        --         cmp.select_prev_item()
        --     elseif require("luasnip").jumpable(-1) then
        --         vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
        --     else
        --         fallback()
        --     end
        -- end,
    },
    sources = {
        { name = "cmp_tabnine" },
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "nvim_lua" },
        { name = "path" },
        { name = "buffer" },
        { name = 'cmdline' },
    },
}

local M = {}
M.setup = function(override_flag)
    if override_flag then
        default = require("core.utils").tbl_override_req("nvim_cmp", default)
    end
    cmp.setup(default)
    -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline('/', {
        sources = {
            { name = 'buffer' }
        }
    })
end

return M
