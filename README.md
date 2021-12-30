# Personal Configuration
![License](https://img.shields.io/badge/Code%20License-MIT-blue.svg)

### Configure
```bash
mkdir projects/
cd projects/
git clone git@github.com:brunocampos01/home-sweet-home.git
cd home-sweet-home/

mkdir $HOME/.config/terminator/
cp config/terminal/terminator/config    $HOME/.config/terminator/

mkdir $HOME/.oh-my-bash
mkdir $HOME/.oh-my-bash/themes
mkdir $HOME/.oh-my-bash/themes/zork/
cp config/terminal/zork/zork.theme.sh   $HOME/.oh-my-bash/themes/zork/

mkdir $HOME/.jupyter/
cp config/jupyter_notebook_config.py    $HOME/.jupyter/

cp config/.bashrc                       $HOME/
cp config/.bash_eternal_history         $HOME/
cp config/.vimrc                        $HOME/
cp config/.gitconfig                    $HOME/
mkdir  .vscode
cp config/.vscode/*                     $HOME/
```

### Install 
```bash
sudo chmod +x initial_install.sh
./initial_install.sh
```

#### Some Applications that are installed with `install.sh`
- [Terminator](https://terminator-gtk3.readthedocs.io/en/latest/index.html)
- [Oh my bash](https://ohmybash.github.io/)
- [snapd](https://snapcraft.io)
- [Linux System Optimizer & Monitoring](https://oguzhaninan.github.io/Stacer-Web/)
- [Boot pendrive](https://www.balena.io/etcher/)

#### My `rc`
- [.bashrc](config/.bashrc)
- [.vimrc](config/.vimrc)
- [.conkyrc](config/.conkyrc)
- [.matplotlib](config/.matplotlib)
- [.jupyter](config/jupyter_notebook_config)
- [terminator](config/)
- [.vscode](config/)
---

<p  align="left">
<br/>
<a href="mailto:brunocampos01@gmail.com" target="_blank"><img src="https://github.com/brunocampos01/devops/blob/master/images/email.png" alt="Gmail" width="30">
</a>
<a href="https://stackoverflow.com/users/8329698/bruno-campos" target="_blank"><img src="https://github.com/brunocampos01/devops/blob/master/images/stackoverflow.png" alt="GitHub" width="30">
</a>
<a href="https://www.linkedin.com/in/brunocampos01" target="_blank"><img src="https://github.com/brunocampos01/devops/blob/master/images/linkedin.png" alt="LinkedIn" width="30"></a>
<a href="https://github.com/brunocampos01" target="_blank"><img src="https://github.com/brunocampos01/devops/blob/master/images/github.png" alt="GitHub" width="30"></a>
<a href="https://medium.com/@brunocampos01" target="_blank"><img src="https://github.com/brunocampos01/devops/blob/master/images/medium.png" alt="GitHub" width="30">
</a>
<a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-sa/4.0/88x31.png",  align="right" /></a><br/>
</p>
