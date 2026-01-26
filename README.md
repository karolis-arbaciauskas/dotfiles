# Dotfiles (chezmoi)

## Fresh macOS setup

### Prerequisites
- macOS with admin access
- 1Password app + account (used for SSH keys and git signing)
- App Store signed in (for `mas` installs)
- GitHub account

### Install + apply (one command)
This installs chezmoi and applies the dotfiles. The run_once scripts will install Homebrew, packages, casks, App Store apps, oh-my-zsh, TPM, and set up the 1Password SSH key.

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply https://github.com/karolis-arbaciauskas/dotfiles.git
```

### After it finishes
1. When prompted, enter your email and whether this is a work computer.
2. Add the printed SSH public key to GitHub.
3. Open a new terminal session.
