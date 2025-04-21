function fbr() {
    git rev-parse HEAD >/dev/null 2>&1 || return

    git branch --color=always --sort=-committerdate --list |
        grep -v HEAD |
        grep -v "^ *remotes/" |
        fzf --height 50% --ansi --no-multi |
        sed "s/.* //"
}

function fzf-git-checkout() {
    git rev-parse HEAD >/dev/null 2>&1 || return

    local branch

    branch=$(fbr)
    if [[ "$branch" = "" ]]; then
        echo "No branch selected."
        return
    fi

    # If branch name starts with 'remotes/' then it is a remote branch. By
    # using --track and a remote branch name, it is the same as:
    # git checkout -b branchName --track origin/branchName
    if [[ "$branch" = 'remotes/'* ]]; then
        git checkout --track $branch
    else
        git checkout $branch
    fi
}

function fzf-git-local-git-branch-prune() {
    # 保護分支清單
    local PROTECTED_BRANCHES=("master" "feature/prototype" "stable/v1.1")

    # 取得目前所在分支
    local current_branch=$(git branch --show-current)

    # 所有要排除的分支（當前 + 保護分支）
    local EXCLUDE_BRANCHES=("$current_branch" "${PROTECTED_BRANCHES[@]}")

    # 取得所有本地分支（去除 * 號）
    local all_branches=($(git branch --format='%(refname:short)'))

    # 過濾排除的分支
    local filtered_branches=()
    for b in "${all_branches[@]}"; do
        local skip=false
        for ex in "${EXCLUDE_BRANCHES[@]}"; do
            if [[ "$b" == "$ex" ]]; then
                skip=true
                break
            fi
        done
        if ! $skip; then
            filtered_branches+=("$b")
        fi
    done

    # fzf 多選
    local selected=$(printf "%s\n" "${filtered_branches[@]}" | fzf --multi --bind "space:toggle" --prompt="選擇要刪除的本地 branch > ")

    # 沒選就退出
    if [[ -z "$selected" ]]; then
        echo "🚫 沒有選擇任何 branch，取消操作。"
        return 0
    fi

    # 列出要刪除的分支
    echo "⚠️ 你即將刪除以下 branch："
    echo "$selected"
    read -q "REPLY?確定要刪除嗎？(y/N) "
    echo ""

    # 執行刪除
    if [[ "$REPLY" =~ ^[Yy]$ ]]; then
        printf "%s\n" "$selected" | xargs -n 1 git branch -D
        echo "✅ 刪除完成"
    else
        echo "❎ 操作已取消"
    fi
}


alias gco='fzf-git-checkout'
alias gbprune='fzf-git-local-git-branch-prune'
