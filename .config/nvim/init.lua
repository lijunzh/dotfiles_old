local chad_modules = {
	"settings",
	"mappings",
	"lang",
	"configs",
}

for i = 1, #chad_modules, 1 do
	pcall(require, chad_modules[i])
end
