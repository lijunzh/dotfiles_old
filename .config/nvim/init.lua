local chad_modules = {
	"settings",
	"mappings",
    "colorscheme",
    "utils",
}

for i = 1, #chad_modules, 1 do
	pcall(require, chad_modules[i])
end
