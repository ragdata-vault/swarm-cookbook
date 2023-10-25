## Install ZSH

Update & Upgrade:

```shell
sudo apt update && sudo apt upgrade -y
```

Set ENV vars:

```shell
export USERNAME=ragdata
export USERDIR=/home/"$USERNAME"
```

Archive bash profile files:

```shell
mkdir -p "$USERDIR"/.bash_archive
while IFS= read -r file; do filename="${file##*/}"; mv "$file" "$USERDIR"/.bash_archive/"$filename"; done < <(find "$USERDIR" -maxdepth 1 -name ".bash*" -type f)
mv "$USERDIR/.bash*" "$USERDIR/.bash_archive/."
mv "$USERDIR/.profile" "$USERDIR/.bash_archive/."
```

Install ZSH

```shell
sudo apt install -y zsh
sudo chsh -s "$(which zsh)" "$USERNAME"
exec zsh
```

### Install Oh-My-ZSH:

Set ENV vars:

```shell
export USERNAME=ragdata
export USERDIR=/home/"$USERNAME"
export REPO="$USERDIR"/projects/ragdata/swarm-cookbook
export ZDOTDIR="$USERDIR"
export ZSHDIR="$USERDIR"/.zsh
```

Download and install OMZSH:

```shell
wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
bash install.sh
```

### Install Powerlevel10k ZSH Theme:

@TODO Install fonts locally

Download and install theme:

```shell
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
sed -i '/^ZSH_THEME.*/c\ZSH_THEME="powerlevel10k/powerlevel10k"'
```

## Uninstall ZSH

```shell
export USERNAME=ragdata
export USERDIR=/home/"$USERNAME"
```

```shell
mkdir -p "$USERDIR/.zsh_archive"
rm -Rf "$USERDIR/.oh-my-zsh"
rm -Rf export ZSH="$USERDIR"/.local/share/sheldon/repos/github.com/ohmyzsh/ohmyzsh
rm -Rf "$USERDIR/.zsh"
mv "$USERDIR/.zshrc" "$USERDIR/.zsh_archive/.zshrc"
mv "$USERDIR/.p10k.zsh" "$USERDIR/.zsh_archive/.p10k.zsh"
```

```shell
sudo chsh -s "$(which bash)" "$USERNAME"
```

Restart terminal session, then:

```shell
sudo apt purge -y zsh && sudo apt autoremove -y
mv "$USERDIR/.bash_archive/*" "$USERDIR"/.
. "$USERDIR"/.bashrc
```
