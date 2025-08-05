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
curl -L https://raw.githubusercontent.com/Udomomo/dotfiles/refs/heads/master/bin/init.sh > init.sh
bash init.sh
```

- `init.sh` does the smallest things to:
  - deploy the change of dotfiles, without installing all packages again
  - install homebrew, so that dotfiles work correctly during the setup for a new laptop

- After that, you can configure things with `make` command. See `Makefile` for available options.

## Development
- Just `git clone` as usual
- CI pipeline checks `init.sh` without installing package

