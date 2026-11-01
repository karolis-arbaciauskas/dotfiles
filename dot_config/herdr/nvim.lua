-- Chezmoi-managed overlay: the main Neovim config is an external Git repo.
-- smart-splits v3 ships no multiplexer backends. Keep tmux as a fallback.
vim.pack.add {
  'https://github.com/adriankarlen/smart-splits-backend-herdr',
  'https://github.com/smart-splits-nvim/backend-tmux',
}

require('smart-splits').setup {
  mux = {
    backend = { 'smart-splits-backend-herdr', 'smart-splits-backend-tmux' },
  },
}
