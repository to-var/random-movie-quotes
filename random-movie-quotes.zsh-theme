RED="\033[0;31m"
GREEN="\033[0;32m"

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
  "The Shining" \
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
