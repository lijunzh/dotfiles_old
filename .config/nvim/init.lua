local chad_modules = {
    "settings",
    "theme",
    "mappings",
    "utils",
}

for i = 1, #chad_modules, 1 do
    pcall(require, chad_modules[i])
end
