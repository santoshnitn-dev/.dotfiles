# Neovim and Development Environment Setup

## Install Neovim (Version > 0.9.0)

```sh
sudo apt update
sudo apt install -y neovim
```

## Install Latest Node.js and npm

```sh
curl -fsSL https://deb.nodesource.com/setup_current.x | sudo -E bash -
sudo apt install -y nodejs
```

Verify installation:

```sh
node -v
npm -v
```


## Install and Verify Nerd Fonts

```sh
fc-list | grep Nerd
```

If the font is missing, install it:

```sh
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Hack.zip
unzip Hack.zip
fc-cache -fv
```

## Install Vim-Plug for Neovim

```sh
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```


Verify installation:

```sh
nvim --version | head -n 1
```

## Configure Neovim

```sh
mkdir -p ~/.config/nvim
nano ~/.config/nvim/init.vim
```

Alternatively, use:

```sh
cd ~/.config/nvim
vi init.vim
```

## Set Up Python Virtual Environment for Neovim

```sh
sudo apt install python3.10-venv
python3 -m venv ~/.virtualenvs/neovim3
source ~/.virtualenvs/neovim3/bin/activate
```

### Install Python Packages

```sh
pip install pynvim pylint black
```

## Install Essential Development Tools

```sh
sudo apt install -y gcc g++ clang clangd clang-format gdb \
    python3 python3-pip python3-venv shellcheck shfmt unzip ripgrep
```


