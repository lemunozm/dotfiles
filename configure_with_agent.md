I have a dotfiles repo cloned somewhere on this machine. The file you are reading is inside it. Please determine the absolute path of this repo (the directory containing this file), then create the following symlinks using that path.

**Symlinks in `~/.config/` (directories):**
```
~/.config/alacritty    -> <repo>/alacritty
~/.config/atuin        -> <repo>/atuin
~/.config/git          -> <repo>/git
~/.config/karabiner    -> <repo>/karabiner
~/.config/nvim         -> <repo>/nvim
~/.config/nvimpager    -> <repo>/nvimpager
~/.config/tmux         -> <repo>/tmux
~/.config/tmuxinator   -> <repo>/tmuxinator
~/.config/zellij       -> <repo>/zellij
```

**Symlinks in `~/` (dotfiles):**
```
~/.zshrc          -> <repo>/.zshrc
~/.p10k.zsh       -> <repo>/.p10k.zsh
~/.gitconfig      -> <repo>/.gitconfig
~/.aerospace.toml -> <repo>/.aerospace.toml
~/.tmux.conf      -> <repo>/tmux/tmux.conf
```

Before creating each symlink, if the target already exists and is not a symlink, back it up by renaming it with a `.bak` suffix. Then confirm all symlinks were created successfully with `ls -la ~/.config/ | grep <repo_name>` and `ls -la ~/ | grep <repo_name>`.
