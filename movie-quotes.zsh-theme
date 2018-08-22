RED="\033[0;31m"
GREEN="\033[0;32m"

declare -a quotes=(
  "Beetlejuice, Beetlejuice, Beetlejuice!"
  "It’s showtime!"
  "They’re heeeere!"
  "Say ‘hello’ to my little friend!"
  "Hello, my name is Inigo Montoya You killed my father Prepare to die"
  "Heeeeere’s Johnny!"
  "Khaaaaan!"
  "To infinity…and beyond!"
  "I know kung fu"
  "Who are you?” – “Your worst nightmare"
  "You talkin’ to me?"
  "There can be only one"
  "YOU SHALL NOT PASS!"
  "THIS IS SPARTA!"
  "Houston, we have a problem"
  "Shit just got real"
  "It’s clobberin’ time!"
  "HULK SMASH!"
  "Go ahead, make my day"
  "Time to nut up or shut up"
  "Run, Forrest, run!"
  "I’ll be back"
  "I’m too old for this shit"
  "SHOW ME THE MONEY!!!"
  "You can’t handle the truth!"
  "Why so serious?"
  "Cowabunga!"
  "Machete don’t text"
  "You’re gonna need a bigger boat"
  "Luke, I am your father"
  "I see dead people"
  "Great scott!"
  "Schwing!"
  "My precious!"
  "Wax on, wax off. Wax on, wax off"
  "Hakuna Matata!"
  "Live long and prosper"
  "May the Force be with you"
  "Hasta la vista…baby"
)

local host_name="
「 ${quotes[$RANDOM % ${#quotes[@]}]} 」
"
local path_string="%{$fg[cyan]%}%~%{$reset_color%}"
local prompt_string="$"
local return_status="%(?:%{$fg_bold[green]%}$prompt_string:%{$fg[red]%}$prompt_string)"

PROMPT='${host_name} ${return_status} $(git_custom_prompt) %{$reset_color%} $(git_remote_status)'
RPROMPT='%U$path_string%u'
ZSH_THEME_GIT_PROMPT_PREFIX="["
ZSH_THEME_GIT_PROMPT_SUFFIX="]%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="✘"
ZSH_THEME_GIT_PROMPT_CLEAN="✔"

git_custom_prompt() {
  local branch=$(current_branch)
  if [ -n "$branch" ]; then
    echo "$ZSH_THEME_GIT_PROMPT_PREFIX$branch$ZSH_THEME_GIT_PROMPT_SUFFIX $(parse_git_dirty)"
  fi
}
