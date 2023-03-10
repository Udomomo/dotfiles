# dotfiles

![dotfiles](https://github.com/Udomomo/dotfiles/actions/workflows/ci.yaml/badge.svg)

## installation     
If your environment has built-in git command:

```
git clone https://github.com/Udomomo/dotfiles.git
bash dotfiles/bin/install.sh
```

Or if you cannot install git command beforehand:

```
curl -L https://dotfiles.udomomo.dev > install.sh
bash install.sh
```

- `install.sh` does the smallest things to:
  - deploy the change of dotfiles, without installing all packages again
  - install homebrew, so that dotfiles work correctly during the setup for a new laptop

- After that, you can configure things with `make` command. See `Makefile` for available options.

## Development
- Just `git clone` as usual
  - TODO: Prepare some test env or CI
