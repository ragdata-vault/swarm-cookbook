## Install ZSH

```shell
sudo apt update && sudo apt upgrade -y
```

```shell
export USER=ragdata
export USERDIR=/home/"$USER"
```

```shell
mkdir -p "$USERDIR"/.bash_archive
while IFS= read -r file; do filename="${file##*/}"; mv "$file" "$USERDIR"/.bash_archive/"$filename"; done < <(find "$USERDIR" -maxdepth 1 -name ".bash*" -type f)
mv "$USERDIR/.bash*" "$USERDIR/.bash_archive/."
mv "$USERDIR/.profile" "$USERDIR/.bash_archive/."
```

```shell
sudo apt install -y zsh
sudo chsh -s "$(which zsh)" "$USER"
exec zsh
```

```shell
export USER=ragdata
export USERDIR=/home/"$USER"
export REPO="$USERDIR"/projects/ragdata/swarm-cookbook
launchctl setenv ZDOTDIR="$USERDIR"
launchctl setenv ZSHDIR="$USERDIR"/.zsh
```

```shell
wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
bash install.sh
```

```shell
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```













```shell
sudo install -C -m 0755 -D -t /usr/local/bin "$REPO/src/opt/zsh/sheldon"
sheldon init --shell zsh
```

```shell
sheldon add oh-my-zsh --github "ohmyzsh/ohmyzsh"
sheldon add auto-suggestions --github "zsh-users/zsh-autosuggestions"
sheldon add git --github "davidde/git"
sheldon add sudo --github "hcgraf/zsh-sudo"
sheldon add powerlevel10k --github "romkatv/powerlevel10k"
sheldon add syntax-highlighting --github "zsh-users/zsh-syntax-highlighting"
```

## Uninstall ZSH

```shell
export USER=ragdata
export USERDIR=/home/"$USER"
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
sudo chsh -s "$(which bash)" "$USER"
```

Restart terminal session, then:

```shell
sudo apt purge -y zsh && sudo apt autoremove -y
mv "$USERDIR/.bash_archive/*" "$USERDIR"/.
. "$USERDIR"/.bashrc
```
