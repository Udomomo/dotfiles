# dotfiles

![dotfiles](https://github.com/Udomomo/dotfiles/actions/workflows/ci.yaml/badge.svg)

## installation     
If your environment has built-in git command:

```
git clone https://github.com/Udomomo/dotfiles.git
bash dotfiles/bin/init.sh
```

Or if you cannot install git command beforehand:

```
curl -sL https://dotfiles.udomomo.dev > init.sh
bash init.sh
```

- `init.sh` does the smallest things to:
  - deploy the change of dotfiles, without installing all packages again
  - install homebrew, so that dotfiles work correctly during the setup for a new laptop

- After that, you can configure things with `make` command. See `Makefile` for available options.

### apply by mise (experimental)
Currently following resources are managed by mise:
- symlink
  - `mise bootstrap dotfiles apply`
  - `mise bootstrap dotfiles apply <target path>` to apply only specific files
- envvar
  - `mise env`

mise file is located at `mise/config.toml`.


## environment specific file
This repository also refers following files, so that you can write settings only used in specific environments.

- `~/.zsh.d/<file_name>.zsh`: used in `~/.zshrc`
- `~/.gitconfig_private`: used in `.gitconfig`

## Apply patch
- If you install dotfiles to the environment without git, use another script to get the update.

```
bash bin/apply_patch.sh
```

## Development
- Just `git clone` as usual
- CI pipeline checks `init.sh` without installing package

