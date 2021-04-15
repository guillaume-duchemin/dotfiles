# Dotfiles for new Mac config

Here there are config files and scripts to setup a new Mac :)

`git clone git@github.com:guillaume-duchemin/dotfiles.git` to access `.macos` file  
Don't worry about the path where it's cloned, we clone again this repo in the main script to have consistent paths.

run `source .macos`

#### Don't forget

##### VSCode

Active Sync

##### System

- Install "Dank Mono" font
- Disable startup sound:  
  System Preferences -> Sound -> Sound Effect -> Uncheck "Play sound on startup

##### Iterm2

- Allow Powerline glyphs:  
  Preferences -> Profiles -> Text -> Check "Use built-in Powerline glyphs"
- Disable Audible Bell:  
  Preferences -> Profiles -> Terminal -> Check "Silence bell"

#### Problems solver

- You may need run `brew cleanup` to clean bad symlinks.
- You may need run `exec zsh` to source again your `.zshrc`.
- Don't forget that `.zshrc` `.gitconfig` and `.gitignore_global` are symlinked.
