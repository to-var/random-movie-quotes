. ~/.oh-my-zsh/themes/random-movie-quotes-data/movies.sh
. ~/.oh-my-zsh/themes/random-movie-quotes-data/quotes.sh

RED="\033[0;31m"
GREEN="\033[0;32m"

local rndm_quote="$((RANDOM % ${#quotes[@]}))"
local host_name="
%{$fg_bold[cyan]%}${quotes[${rndm_quote}]}%{$reset_color%} - ${movies[${rndm_quote}]}
"
local path_string="%{$fg[cyan]%}%~%{$reset_color%}"
local prompt_string="$"
local return_status="%(?:%{$fg_bold[green]%}$prompt_string:%{$fg[red]%}$prompt_string)"

PROMPT='${host_name} $(git_custom_prompt) ${return_status} %{$reset_color%} $(git_remote_status)'
RPROMPT='%U$path_string%u'
ZSH_THEME_GIT_PROMPT_PREFIX="["
ZSH_THEME_GIT_PROMPT_SUFFIX="]%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="$fg[red]✘%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="$fg[green]✔%{$reset_color%}"

git_custom_prompt() {
  local branch=$(current_branch)
  if [ -n "$branch" ]; then
    echo "$ZSH_THEME_GIT_PROMPT_PREFIX$branch$ZSH_THEME_GIT_PROMPT_SUFFIX $(parse_git_dirty)"
  fi
}
