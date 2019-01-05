# lijun's dotfiles

## Installation

### Prerequisites

- git: I am using brew git `v2.20.1`, but I assume older versions should work too.

### Option 1: adopt config in this repo
If you like my config setup and want to use it directly to override existing dotfiles in your system, you can follow the instructions below:

- clone the bare repo

```bash
git clone --bare git@github.com:lijunzh/dotfiles.git ~/.cfg
```

- set temporary alias for bare repo

```bash
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
config config --local status.showUntrackedFiles no
```

- list files need to change

```bash
config checkout
```

- back up the affected files

```bash
[[ $? != 0]] && config checkout 2>&1 | egrep "]s+\." | awk {'print $1'} | xargs -I{} mv {} .config-backup/{}
```

- checkout master branch with my configs

```bash
config checkout
```

Run the following code will backup the old config file in `.config-backup` and install the repo's config file. Notice that all the config files are hidden, so `ls` will not show them. Use `ls -a .config-backup` or `tree -a .config-backup` instead.

```bash
curl https://gist.githubusercontent.com/lijunzh/418cbb20940f45564287411fd4d67afd/raw/589469fe392e205eec0225ba3765de23585a5dbd/install_dotfiles | /bin/bash
```

### Option 2: migrate your config to this setup

