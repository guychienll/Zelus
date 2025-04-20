function gco() {
  local branches branch
  branches=$(git branch | grep -v HEAD) &&
  branch=$(echo "$branches" | fzf -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //")
}

function delete_branch() {
  local branches branch
  branches=$(git branch | grep -v HEAD | grep -v "^\*") &&
  branch=$(echo "$branches" | fzf -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git branch -D $(echo "$branch" | sed "s/.* //")
}

alias gco='gco'
alias gdb='delete_branch'