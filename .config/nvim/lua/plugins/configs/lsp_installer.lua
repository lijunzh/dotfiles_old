local present, lsp_installer = pcall(require, "nvim-lsp-installer")

if not present then
	return
end

-- Provide settings first!
lsp_installer.settings({
	ui = {
		icons = {
			server_installed = "✓",
			server_pending = "➜",
			server_uninstalled = "✗"
		}
	}
})

lsp_installer.on_server_ready(function (server) server:setup {} end)
