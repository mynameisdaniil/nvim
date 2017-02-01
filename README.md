```bash
sudo apt-add-repository ppa:neovim-ppa/unstable
sudo apt update
sudo apt install nvim
sudo apt install xclip
```
or
```bash
sudo sh -c "apt-add-repository ppa:neovim-ppa/unstable && apt update && apt install neovim xclip"
```
We need `xclip` in order for system clipboard/default buffer integration to work properly. Then add:
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
