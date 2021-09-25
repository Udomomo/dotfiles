# dotfiles
## Deploy to clean env
- Deploy to `$DOTPATH` (=`$HOME/.dotfiles`) and create symlink to there
  - We can do that every time when update some dotfiles   
  - TODO: Make it runnable with Bourne shell
     
```
curl -LO https://raw.githubusercontent.com/Udomomo/dotfiles/master/bin/install.sh
bash install.sh
```

- Why deploy to `$DOTPATH`, not directory to `$HOME`?
  - we should not symlink directory from `$HOME` to development repo, otherwise some config still under development might be applied accidentally.
  - We can manage configuration files in one place, which needs to be placed other than `$HOME`.

## Development
- Just `git clone` as usual
  - DO NOT touch `$HOME` or `$DOTPATH`. Develop in your repository, and deploy by `install.sh`.
  - TODO: Prepare some test env or CI
