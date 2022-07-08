# dotfiles

## installation     
```
curl -L https://dotfiles.udomomo.dev > install.sh
bash install.sh
```
- `install.sh` does the smallest things to:
  - deploy the change of dotfiles, without installing all packages again
  - install homebrew, so that dotfiles work correctly during the setup for a new laptop


## Development
- Just `git clone` as usual
  - DO NOT touch `$HOME` or `$DOTPATH`. Develop in your repository, and deploy by `install.sh`.
  - TODO: Prepare some test env or CI
