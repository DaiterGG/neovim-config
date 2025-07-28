if vim.g.vscode then
  return {}
end
-- Highlight connected via blank lines code blocks
return {
  'lukas-reineke/indent-blankline.nvim',
  main = 'ibl',
  event = 'BufReadPost',
  opts = {

    scope = {
      enabled = true,
      show_exact_scope = true,
      include = {
        node_type = { lua = { 'return_statement', 'table_constructor' } },
      },
    },
  },
}
