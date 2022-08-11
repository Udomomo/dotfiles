# dotfiles

## installation     
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


## Development
- Just `git clone` as usual
  - TODO: Prepare some test env or CI
