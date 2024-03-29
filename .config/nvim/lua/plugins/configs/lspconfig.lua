require("plugins.configs.others").lsp_handlers()
require("core.mappings").lspconfig()

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.documentationFormat = { "markdown", "plaintext" }
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
capabilities.textDocument.completion.completionItem.resolveSupport = {
   properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
   },
}

-- custom lsp configs
local addlsp_confs = require("core.utils").load_config().plugins.options.lspconfig.setup_lspconf

if string.len(addlsp_confs) ~= 0 then
   require(addlsp_confs).setup_lsp(on_attach, capabilities)
end
