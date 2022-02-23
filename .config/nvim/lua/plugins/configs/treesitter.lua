local present, ts_config = pcall(require, "nvim-treesitter.configs")

if not present then
    return
end

local default = {
    ensure_installed = {
        "bash",
        "json",
        "lua",
        "python",
        "vim",
        "rust",
    },
    highlight = {
        enable = true,
        use_languagetree = true,
    },
    rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = 1000,
    },
    textobjects = {
        select = {
            enable = true,

            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,

            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner"
            }
        }
    },
    matchup = {
        enable = true,
    }
}

local M = {}
M.setup = function(override_flag)
    if override_flag then
        default = require("core.utils").tbl_override_req("nvim_treesitter", default)
    end
    ts_config.setup(default)
end

return M
