# lijun's dotfiles

## Installation

### Prerequisites

Listed below are my setup, but I assume most of the config is generally applicable to recent versions as well.

- git: `git version 2.20.1`
- bash: `GNU bash, version 3.2.57(1)-release (x86_64-apple-darwin18)`
- vim (optional): `VIM - Vi IMproved 8.1 (2018 May 18, compiled Dec 28 2018 20:12:37)`
- screen (optional): `Screen version 4.06.02 (GNU) 23-Oct-17`

A few words about `GNU screen`:
I like `screen`'s availability in most `Linux` systems. However, I also tend to want to keep only one socket while working on a project. Once the session being dropped accidentally, resume all sessions created by `screen` and arrange them in the original layout is tedious (educate me if you know an elegent way). Ever since the `Vim 8.1` released, I start to use the `terminal` or `term` feature it has. Now, if I want to start some work that may need to resume in the future, this is what I do:

```bash
dtach -A /tmp/dtach-vim -r winch vim
```

Once the session being dropped, I can ran the same code to bring it back. So, I made an alias for this command. I use`vim` as my editor and multiplexer. 

Note that this setup is not for everyone. I like it because most of my work is down in `vim` and I only need `bash` occationally to see `htop` or run some script. If your workflow is `bash`-heavy, then `screen`, `tmux`, or event `dtach + dvtm` is better for you. 

Note to note, I know this `dtach + vim` is similar to `dtach + dvtm`, but the latter one is [not working for Mac now](https://github.com/Homebrew/homebrew-core/pull/13394) and it is related to this [issue](ttps://github.com/martanne/dvtm/issues/19).

### Option 1: adopt config in this repo
If you like my config setup and want to use it directly to override existing dotfiles in your system, you can run the script in [GitHub Gist](https://gist.github.com/lijunzh/418cbb20940f45564287411fd4d67afd):

```bash
curl https://gist.githubusercontent.com/lijunzh/418cbb20940f45564287411fd4d67afd/raw/589469fe392e205eec0225ba3765de23585a5dbd/install_dotfiles | /bin/bash
```


Alternatively, you can run the following instructions line by line:

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

The commands above will backup the old config file in `.config-backup` and install the repo's config file. Notice that all the backedup config files are hidden, so `ls` will not show them. Use `ls -a .config-backup` or `tree -a .config-backup` instead.

### Option 2: migrate your config to this setup

If you want to convert your exisiting config file system to this bare-git-repo setup, or you want to build the dotfies from scratch, here are the step-by-step instructions:

- Under `$HOME` directory, initiate a bare git repo:

```bash
git init --bare $HOME/.cfg
```

- Create alias to use instead of regular git

```bash
echo "alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'" >> $HOME/.bashrc
source .bashrc
config config --local status.showUntrackedFiles no
```

- Now, you can manage your dotfiles in your $HOME directory. Below are a few examples

```bash
config status
config add .vimrc
config commit -am "add .vimrc"
config add .bashrc
config commit -am "add .bashrc"
config push
```

- Add `.cfg` to `.gitignore` to avoid recursion clone

```bash
echo ".cfg" >> .gitignore
```

