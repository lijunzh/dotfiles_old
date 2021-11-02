local M = {}

M.init = function(theme)
    if not theme then
        theme = require("core.utils").load_config().ui.theme
    end

    -- set the global theme
    vim.g.theme = "gruvbox"

    -- set colorscheme
    vim.cmd("colorscheme gruvbox-material")

    -- load highlights
    require("colors.highlights")
end

-- returns a table of colors for givem or current theme
M.get = function(theme)
    if not theme then
        theme = vim.g.theme
    end

    return require("themes." .. theme)
end

return M
