# .dotfiles
All configurations files 

fc-list | grep Nerd


mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Hack.zip
unzip Hack.zip
fc-cache -fv

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

mkdir -p ~/.config/nvim
nano ~/.config/nvim/init.vim


cd ~/.config/nvim
vi init.vim
sudo apt install python3.10-venv
python3 -m venv ~/.virtualenvs/neovim3
source ~/.virtualenvs/neovim3/bin/activate

pip install pynvim
pip install pylint
pip install black

sudo apt install -y gcc g++ clang clangd clang-format gdb python3 python3-pip python3-venv shellcheck shfmt  unzip ripgrep


