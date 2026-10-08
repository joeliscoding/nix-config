local options = {
  -- indentation
  tabstop = 4,
  shiftwidth = 4,
  softtabstop = 4,
  expandtab = true,
}

for x, y in pairs(options) do
  vim.opt[x] = y
end
