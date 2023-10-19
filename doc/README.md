# [Swarm Cookbook v-0.1.0](https://github.com/ragdata/swarm-cookbook)

Copyright © 2023 Darren (Ragdata) Poulton

## Repository Documentation



### Resources

* https://github.com/unixorn/awesome-zsh-plugins


* https://www.netdata.cloud/


* https://agwa.name/projects/git-crypt/
* https://github.com/deluan/zsh-in-docker
* https://github.com/greymd/docker-zsh-completion
* https://github.com/sroze/docker-compose-zsh-plugin
* https://github.com/zplug/zplug
* https://github.com/zplug/installer


#### Portable Jekyll

* https://github.com/madhur/PortableJekyll
* https://github.com/madhur/PortableJekyll/wiki
* https://www.madhur.co.in/blog/2011/09/01/runningjekyllwindows.html
* https://www.madhur.co.in/blog/2013/07/20/buildportablejekyll.html
* https://github.com/juthilo/run-jekyll-on-windows
* https://jekyll-windows.juthilo.com/
* https://github.com/jekyll/jekyll
* https://jekyllrb.com/


#### Moving to ZSH

* https://scriptingosx.com/2019/07/moving-to-zsh-part-4-aliases-and-functions/
* https://wiki.archlinux.org/title/XDG_Base_Directory
* https://thevaluable.dev/zsh-line-editor-configuration-mouseless/
* https://thevaluable.dev/zsh-completion-guide-examples/
* https://thevaluable.dev/zsh-expansion-guide-example/
* https://thevaluable.dev/zsh-install-configure-mouseless/
* https://www.mankier.com/
* https://zsh.sourceforge.io/Guide/
* https://github.com/ohmyzsh/ohmyzsh
* https://zsh.sourceforge.io/Guide/zshguide.html
* https://grml.org/zsh/
* http://www.chodorowski.com/projects/zws/

### SUDO Without Password

```shell
echo "ragdata ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/ragdata
sudo chmod 0700 /etc/sudoers.d/ragdata
```