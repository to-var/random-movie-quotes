RED="\033[0;31m"
GREEN="\033[0;32m"
CURRENT_BG='NONE'
PRIMARY_FG=black
DIR_BG=white
GIT_CLEAN_BG=green
GIT_DIRTY_BG=yellow

SEGMENT_SEPARATOR=""
PLUSMINUS="\u00b1"

local quotes=( \
  "\"Beetlejuice, Beetlejuice, Beetlejuice!\"" \
  "\"It’s showtime!\"" \
  "\"They’re heeeere!\"" \
  "\"Say ‘hello’ to my little friend!\"" \
  "\"Hello, my name is Inigo Montoya. You killed my father. Prepare to die\"" \
  "\"Heeeeere’s Johnny!\"" \
  "\"Khaaaaan!\"" \
  "\"To infinity…and beyond!\"" \
  "\"I know kung fu\"" \
  "\"Who are you?” – “Your worst nightmare\"" \
  "\"You talkin’ to me?\"" \
  "\"There can be only one\"" \
  "\"YOU SHALL NOT PASS!\"" \
  "\"THIS IS SPARTA!\"" \
  "\"Houston, we have a problem\"" \
  "\"Shit just got real\"" \
  "\"It’s clobberin’ time!\"" \
  "\"HULK SMASH!\"" \
  "\"Go ahead, make my day\"" \
  "\"Time to nut up or shut up\"" \
  "\"Run, Forrest, run!\"" \
  "\"I’ll be back\" The Terminator" \
  "\"I’m too old for this shit\"" \
  "\"SHOW ME THE MONEY!!!\"" \
  "\"You can’t handle the truth!\"" \
  "\"Why so serious?\"" \
  "\"Cowabunga!\"" \
  "\"Machete don’t text\"" \
  "\"You’re gonna need a bigger boat\"" \
  "\"Luke, I am your father\"" \
  "\"I see dead people\"" \
  "\"Great scott!\"" \
  "\"Schwing!\"" \
  "\"Wayne's world, Wayne's world. Party time. Excellent!\"" \
  "\"My precious!\"" \
  "\"Wax on, wax off. Wax on, wax off\"" \
  "\"Hakuna Matata!\"" \
  "\"Live long and prosper\"" \
  "\"May the Force be with you\"" \
  "\"Hasta la vista…baby\"" \
  "\"Chewie, we're home\"" \
  "\"Elementary, my dear Watson\"" \
  "\"Help me, Obi-Wan Kenobi. You're my only hope\"" \
  "\"The greatest trick the devil ever pulled was convincing the world he didn't exist\"" \
  "\"The first rule of Fight Club is: You do not talk about Fight Club\"" \
  "\"Frankly, my dear, I don't give a damn\"" \
  "\"They call it a Royale with Cheese\"" \
  "\"Say 'what' again. Say 'what' again, I dare you, I double dare you motherfucker, say what one more Goddamn time!\"" \
)

local movies=( \
  "Beetlejuice" \
  "Beetlejuice" \
  "Poltergeist" \
  "Scarface" \
  "The Princess Bride" \
  "The Shine" \
  "Star Trek" \
  "Toy Story" \
  "The Matrix" \
  "Rambo III" \
  "Taxi Driver" \
  "Highlander" \
  "Lord of the Rings: The Fellowship of the Ring" \
  "300" \
  "Apollo 13" \
  "Bad Boys 2" \
  "Fantastic 4" \
  "The Hulk" \
  "Sudden Impact" \
  "Zombieland" \
  "Forrest Gump" \
  "The Terminator" \
  "Lethal Weapon" \
  "Jerry Maguire" \
  "A Few Good Men" \
  "The Dark Night" \
  "Teenage Mutant Ninja Turtles" \
  "Machete" \
  "Jaws" \
  "Star Wars: The Empire Strikes Back" \
  "The Sixth Sense" \
  "Back to the Future" \
  "Wayne's World" \
  "Wayne's World" \
  "The Lord of the Rings: The Fellowship of the Ring" \
  "The Karate Kid" \
  "The Lion King" \
  "Star Trek" \
  "Star Wars" \
  "The Terminator" \
  "Star Wars: The Force Awakens" \
  "Sherlock Holmes" \
  "Star Wars: A new hope" \
  "The Usual Suspects" \
  "Fight Club" \
  "Gone with the wind" \
  "Pulp Fiction" \
  "Pulp Fiction" \
)

ZSH_THEME_GIT_PROMPT_PREFIX="["
ZSH_THEME_GIT_PROMPT_SUFFIX="]%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="$fg[red]✘%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="$fg[green]✔%{$reset_color%}"

# Movie  prompt
prompt_movie() {
  rndm_quote="$((RANDOM % ${#quotes[@]}))"
  echo "
🎬 %{$fg_bold[cyan]%}${quotes[${rndm_quote}]}%{$reset_color%} - ${movies[${rndm_quote}]}
    "
}

# Segment separator in promt
prompt_segment() {
  local bg fg
  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
  if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
    print -n "%{$bg%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR%{$fg%}"
  else
    print -n "%{$bg%}%{$fg%}"
  fi
  CURRENT_BG=$1
  [[ -n $3 ]] && print -n $3
}

# Git prompt with dirty status colour
prompt_git() {
  local branch=$(current_branch)
  if [ -n "$branch" ]; then
    local color ref
    is_dirty() {
      test -n "$(git status --porcelain --ignore-submodules)"
    }
    ref="$vcs_info_msg_0_"
    if [[ -n "$ref" ]]; then
      if is_dirty; then
        color=$GIT_DIRTY_BG
        ref="${ref} $PLUSMINUS"
      else
        color=$GIT_CLEAN_BG
        ref="${ref} "
      fi
      if [[ "${ref/.../}" == "$ref" ]]; then
        ref="$BRANCH $ref"
      else
        ref="$DETACHED ${ref/.../}"
      fi
      prompt_segment $color $PRIMARY_FG "$ZSH_THEME_GIT_PROMPT_PREFIX$branch$ZSH_THEME_GIT_PROMPT_SUFFIX $(parse_git_dirty) "
    fi
  fi
}

# Current working directory in prompt
prompt_dir() {
  CURRENT_BG=$DIR_BG
  prompt_segment $DIR_BG $PRIMARY_FG ' %~ '
}

# End the prompt, closing any open segments
prompt_end() {
  if [[ -n $CURRENT_BG ]]; then
    print -n "%{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR"
  else
    print -n "%{%k%}"
  fi
  print -n "%{%f%}"
  CURRENT_BG=''
}

# Main prompt
prompt_main() {
  RETVAL=$?
  CURRENT_BG='NONE'
  prompt_movie
  prompt_dir
  prompt_git
  prompt_end
}

prompt_precmd() {
  vcs_info
  PROMPT='%{%f%b%k%}$(prompt_main) '
}
prompt_setup() {
  autoload -Uz add-zsh-hook
  autoload -Uz vcs_info

  prompt_opts=(cr subst percent)

  add-zsh-hook precmd prompt_precmd

  zstyle ':vcs_info:*' enable git
  zstyle ':vcs_info:*' check-for-changes false
  zstyle ':vcs_info:git*' formats '%b'
  zstyle ':vcs_info:git*' actionformats '%b (%a)'
}

prompt_setup
