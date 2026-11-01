# Dotfiles (chezmoi)

## Fresh macOS setup

### Prerequisites
- macOS with admin access
- 1Password app + account (used for SSH keys and git signing)
- App Store signed in (for `mas` installs)
- GitHub account

### Install + apply (one command)
This installs chezmoi and applies the dotfiles. The run_once scripts will install Homebrew, packages, casks, App Store apps, oh-my-zsh, Herdr's navigation plugin, and set up the 1Password SSH key.

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply https://github.com/karolis-arbaciauskas/dotfiles.git
```

### After it finishes
1. When prompted, enter your email and whether this is a work computer.
2. Add the printed SSH public key to GitHub as an authentication key (and as a
   signing key if you want GitHub to verify signed commits).
3. Open a new terminal session.

## Terminal workspace (Herdr)

Ghostty starts or attaches to the named Herdr session `work`. Herdr and `jq`
(the navigation plugin's dependency) are included in the Brew bundle.
The tab bar's right edge shows the current macOS input language, battery, and a
24-hour clock (`🇺🇸 · ⚡ 64% · 14:35`). English uses 🇺🇸 and Lithuanian uses 🇱🇹;
other languages fall back to their language codes. Battery refreshes every 5 seconds;
`⚡` means connected to AC power, including when charging is paused or complete;
`🔋` means running on battery. Machines without a
battery omit the battery entry. Language is queried every second using a Swift helper
compiled once into `~/.cache/herdr` (requires Xcode Command Line Tools).
Status commands and time resolve on the Herdr server; over SSH they reflect
that server's machine, not the local terminal.

| Action | Keys |
| --- | --- |
| Prefix | `Ctrl-s` |
| Split left/right | Prefix, `|` |
| Split top/bottom | Prefix, `-` |
| New tab | Prefix, `c` |
| Close pane | Prefix, `x` |
| Detach | Prefix, `d` |
| Reload configuration | Prefix, `r` |
| Workspace picker | Prefix, `f` |
| Search tabs, workspaces and agents (herdr-bar) | Prefix, `k` / `Cmd-k` in Ghostty / `Ctrl-Alt-k` |
| Rename selected tab in herdr-bar | `Ctrl-r` |
| Next / previous workspace in navigate mode | `j` / `k` |
| Lazygit popup | Prefix, `g` |
| Zoom pane | Prefix, `z` |
| Help | Prefix, `?` |
| Navigate Neovim splits / Herdr panes | `Ctrl-h/j/k/l` |
| Resize Neovim splits / Herdr panes | `Alt-h/j/k/l` |

### Plugins and tmux equivalents

- **smart-splits**: the Herdr plugin and Neovim backend provide navigation in
  both directions. A small managed resize helper passes Alt keys to Neovim
  when appropriate instead of intercepting Neovim's split resizing.
- **Tokyo Night**: configured in Herdr and Ghostty; no theme plugin needed.
- **tmux-fzf**: herdr-bar provides fuzzy search across tabs, workspaces and
  agents, a live preview, and tab renaming with `Ctrl-r`. The built-in workspace
  picker remains available on Prefix, `f`.
- **Automatic task titles**: herdr-bar names unnamed tabs from supported agent
  tasks (including Pi), preserving custom names. Status prefixes are disabled.
  Optional logo fonts are not installed; icons use automatic fallback.
- **tmux-resurrect**: Herdr keeps processes alive while detached and saves
  layouts. After a server/machine restart it can restore layouts and resume
  supported agent sessions, not the original shell processes.
- **Battery / online status**: the old tmux status-line plugins do not run in
  Herdr; they are not migrated here.

The Neovim config is a separate Git-repo external. The chezmoi after-script
links `~/.config/herdr/nvim.lua` into its `after/plugin/` directory without
editing the external's tracked files. Neovim installs the v3 Herdr and tmux
fallback backends through `vim.pack` on startup. Restart Neovim after applying;
use `:checkhealth smart-splits` to inspect the selected backend.

Herdr plugins: `herdr plugin list`, `herdr plugin update`, and
<https://herdr.dev/plugins/>. Plugin installation is automated by chezmoi;
updates are explicit. Old tmux configuration is retained as a fallback, but
fresh installs no longer install tmux or TPM. An already-installed tmux is not
uninstalled, so existing sessions remain untouched.
