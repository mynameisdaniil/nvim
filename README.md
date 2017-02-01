```bash
sudo apt-add-repository ppa:neovim-ppa/unstable
sudo apt update
sudo apt install nvim
```
or
```bash
sudo sh -c "apt-add-repository ppa:neovim-ppa/unstable && apt update && apt install neovim"
```
then add:
```bash
alias v="nvim"
alias vi="nvim"
alias vimdiff='nvim -d'
export EDITOR=nvim
```
to ~/.bashrc. Then:
```bash
git clone git@github.com:mynameisdaniil/nvim.git
cd nvim
ln -s $PWD ~/.config/nvim
```
Enjoy!
