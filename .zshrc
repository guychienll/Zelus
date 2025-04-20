# 設定 ZSH CONFIG PATH
export ZSH_CONFIG_PATH="$HOME/.config/Zelus"

# 載入 util.sh
source "$ZSH_CONFIG_PATH/util.sh"

# 依照作業系統安裝依賴套件
if [[ `uname` = "Darwin" ]]; then
  install_and_setup_darwin
else
  DISTRIBUTION_ID=$(cat /etc/*-release | grep '^ID=' | cut -d '=' -f 2 | tr -d '"')
  case $DISTRIBUTION_ID  in
	  amzn)
      install_and_setup_amzn
	    ;;
	  ubuntu)
      install_and_setup_ubuntu
	    ;;
	  *) echo "unknow" ;;
  esac
fi


PLUGINS="$ZSH_CONFIG_PATH/plugins"
THEMES="$ZSH_CONFIG_PATH/themes"
FONTS="$ZSH_CONFIG_PATH/fonts"
ALIASES="$ZSH_CONFIG_PATH/aliases"


# 載入 aliases
for file in $ALIASES/*.sh; do
  source $file
done


# 初始化 zplug
[ ! -d ~/.zplug ] && git clone https://github.com/zplug/zplug ~/.zplug
source $HOME/.zplug/init.zsh

# 載入 plugins
zplug 'zplug/zplug', hook-build:'zplug --self-manage'
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting", from:github
zplug "zsh-users/zsh-history-substring-search", from:github, defer:2
zplug "djui/alias-tips", from:github
zplug "zsh-users/zsh-autosuggestions"
zplug "plugins/docker", from:oh-my-zsh
zplug "plugins/composer", from:oh-my-zsh
zplug "romkatv/powerlevel10k", as:theme, depth:1



# 安裝未安裝的 plugins
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load


# powerlevel10k
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
