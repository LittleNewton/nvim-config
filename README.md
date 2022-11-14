# NeoVim 配置

## 1. 介绍

neovim 基础开发配置，这个配置以较小的体积来获得基本的开发环境。

## 2. 安装教程

### 2.1 安装 NeoVim

如果 Debian 或 RHEL 仓库里的 NeoVim 版本小于 0.7，可通过 GitHub 下载安装包并手动加载。

NeoVim [Release](https://github.com/neovim/neovim/releases) 页面。

以 Debian 为例：

``` bash
# 下载 nvim-linux64.deb
sudo apt install ./nvim-linux64.deb
```

### 2.2 下载配置文件

``` bash
git clone https://github.com/LittleNewton/neovim_config.git ~/.config/nvim
```

### 2.3 安装 Python 依赖

``` bash
# 切换到 root 用户，不要用 Anaconda
pip3 install neovim
pip3 install pynvim
```

### 2.4 安装 JavaScript 依赖

``` bash
sudo apt install nodejs npm
```

### 2.5 安装插件

``` bash
# 打开 vim，在命令行模式下输入 PlugInstall 安装插件
:PlugInstall
```

## 参考配置

1. https://gitee.com/karl1864/config_vim
2. https://github.com/theniceboy/nvim
