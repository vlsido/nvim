# Nvim config for myself
This is a config myself can download and drop it into config folder for any machine (linux, win, macOS).

## Prerequisites
1. Install [packer](https://github.com/wbthomason/packer.nvim)

2. Install [ripgrep](https://github.com/BurntSushi/ripgrep)

3. Install [trash-cli](https://www.npmjs.com/package/trash) globally by running
```
npm install --global trash-cli
```

### Clangd not installing on ARM64 fix

sudo apt install clangd-16
ln -s /usr/bin/clangd-16 ~/.local/share/nvim/mason/bin/clangd
mkdir ~/.local/share/nvim/mason/packages/clangd
