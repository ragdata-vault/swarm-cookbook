## Install ZSH

Update & Upgrade:

```shell
sudo apt update && sudo apt upgrade -y
```

Set ENV vars:

```shell
export USERNAME=ragdata
```

Archive bash profile files:

```shell
mkdir -p "$HOME"/.bash_archive
while IFS= read -r file; do filename="${file##*/}"; mv "$file" "$HOME"/.bash_archive/"$filename"; done < <(find "$HOME" -maxdepth 1 -name ".bash*" -type f)
mv "$HOME/.bash*" "$HOME/.bash_archive/."
mv "$HOME/.profile" "$HOME/.bash_archive/."
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
export REPO="$HOME"/projects/ragdata/swarm-cookbook
export ZDOTDIR="$HOME"
export ZSHDIR="$HOME"/.zsh
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
```

```shell
mkdir -p "$HOME/.zsh_archive"
rm -Rf "$HOME/.oh-my-zsh"
rm -Rf export ZSH="$HOME"/.local/share/sheldon/repos/github.com/ohmyzsh/ohmyzsh
rm -Rf "$HOME/.zsh"
mv "$HOME/.zshrc" "$HOME/.zsh_archive/.zshrc"
mv "$HOME/.p10k.zsh" "$HOME/.zsh_archive/.p10k.zsh"
```

```shell
sudo chsh -s "$(which bash)" "$USERNAME"
```

Restart terminal session, then:

```shell
sudo apt purge -y --autoremove zsh && sudo apt autoremove -y
mv "$HOME/.bash_archive/*" "$HOME"/.
. "$HOME"/.bashrc
```
