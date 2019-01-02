# lijun's dotfiles
## Installation
Run the following code will backup the old config file in `.config-backup` and install the repo's config file. Notice that all the config files are hidden, so `ls` will not show them. Use `ls -a .config-backup` or `tree -a .config-backup` instead.

```bash
curl https://gist.githubusercontent.com/lijunzh/418cbb20940f45564287411fd4d67afd/raw/589469fe392e205eec0225ba3765de23585a5dbd/install_dotfiles | /bin/bash
```

The [github gist](https://gist.github.com/lijunzh/418cbb20940f45564287411fd4d67afd) used in this command is quoted below:

```
# Suorce: https://news.ycombinator.com/item?id=11071754

# Uncomment if initiate a new dotfiles bare repo
# git init --bare $HOME/.cfg

# Uncomment if install existing dotfiles repo
git clone --bare git@github.com:lijunzh/dotfiles.git ~/.cfg

# Set temporary config commend, alias should be added in .bashrc
config="/usr/bin/git --git-dir=${HOME}/.cfg/ --work-tree=${HOME}"
${config} config status.showUntrackedFiles no

# Install to $HOME, backup esisting files
mkdir -p .config-backup/.vim/backups
mkdir -p .config-backup/.vim/swaps
mkdir -p .config-backup/.vim/undo

${config} checkout
if [ $? = 0 ]; then
  echo "Checked out config.";
else
    echo "Backing up pre-existing dot files.";
    ${config} checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .config-backup/{}
    ${config} checkout
    echo "Checked out config.";
fi;

```



