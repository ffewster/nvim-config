if vim.fn.executable 'tree-sitter' == 0 then
  vim.schedule(function() vim.notify('tree-sitter-cli not found! Run: npm install -g tree-sitter-cli', vim.log.levels.WARN) end)
end
