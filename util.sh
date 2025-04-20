
# 安裝及設定 macOS
function install_and_setup_darwin(){
  if  ! type "brew" > /dev/null ; then
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
  dependencies=("vim" "fzf")
  for dependency in ${dependencies[@]}; do
      if ! type $dependency > /dev/null; then
    brew install $dependency
      fi
  done
  export FZF_DEFAULT_COMMAND='fd --type f'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
}

# 安裝及設定 Amazon Linux
function install_and_setup_amzn(){
  dependencies=("vim" "python" "fzf")
  for dependency in ${dependencies[@]}; do
    if ! type $dependency > /dev/null; then
      yum -y install $dependency
    fi
  done
}

# 安裝及設定 Ubuntu
function install_and_setup_ubuntu(){
  dependencies=("vim" "python" "universal-ctags" "python3" "python3-pip" "curl" "silversearcher-ag" "fd-find" "fzf")
  for dependency in ${dependencies[@]}; do
    if ! type $dependency > /dev/null; then
      apt -y install $dependency
    fi
  done
  cd ~ && git clone https://github.com/junegunn/fzf.git && fzf/install
  pip3 install pynvim
  export FZF_DEFAULT_COMMAND='fdfind --type f'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
} 
