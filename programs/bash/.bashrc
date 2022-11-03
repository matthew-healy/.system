#!/bin/bash

###############
# DIRENV HOOK #
###############

eval "$(direnv hook bash)"

#####################
# HELPFUL FUNCTIONS #
#####################

function mkd() {
  mkdir -p "$1" && cd "$_" || exit;
};

##########
# PROMPT #
##########

prompt_git() {
  local prefix=$1;
  local branchColour=$2;
  local stateColour=$3;
  local state='';
  local branchName='';

  # is the current dir in a git repo?
  if [ $(git rev-parse --is-inside-work-tree &>/dev/null; echo "${?}") == '0' ]; then
    # is the current dir under source control?
    if [ "$(git rev-parse --is-inside-git-dir 2> /dev/null)" == 'false' ]; then
      # ensure index is up to date
      git update-index --really-refresh -q &>/dev/null;
      # uncommitted changes
      if ! $(git diff --quiet --ignore-submodules --cached); then
        state+='+';
      fi;
      # unstaged changes
      if ! $(git diff-files --quiet --ignore-submodules --); then
        state+='!';
      fi;
      # untracked files
      if [ -n "$(git ls-files --others --exclude-standard)" ]; then
        state+='?';
      fi;
      # stashed files
      if $(git rev-parse --verify refs/stash &>/dev/null); then
        state+='$';
      fi;
    fi;
    # get short symbolic ref.
    # if HEAD isn’t a symbolic ref, get short SHA for latest commit.
    # otherwise, just give up.
    branchName="$(git symbolic-ref --quiet --short HEAD 2> /dev/null || \
                  git rev-parse --short HEAD 2> /dev/null || \
                  echo '(unknown)')";

    [ -n "${state}" ] && state=" [${state}]";

    echo -e "${prefix}${branchColour}${branchName}${stateColour}${state}";
  else
    return;
  fi;
}

PS1="\n";
# '[' in bold light blue
PS1+="\[\e[0;1;38;5;153m\][";
# the time in pink
PS1+="\[\e[0;38;5;225m\]\A";
# ']' in bold light blue
PS1+="\[\e[0;1;38;5;153m\]] ";
# username in bold pink
PS1+="\[\e[0;1;38;5;225m\]\u ";
# 'at' in white
PS1+="\[\e[0m\]at ";
# hostname in bold light blue
PS1+="\[\e[0;1;38;5;153m\]\h ";
# 'in' in white
PS1+="\[\e[0m\]in ";
# pwd in bold mint green
PS1+="\[\e[0;1;38;5;158m\]\w ";
# git info
PS1+="\$(prompt_git '\[\e[0m\]on ' '\[\e[0;1;38;5;230m\]' '\[\e[0;1;38;5;177m\]')";
# a pink turnstyle
PS1+="\n\[\e[0;1;38;5;225m\]|- ";
# reset colours to white
PS1+='\[\e[0m\]';
export PS1;

PS2="\[\e[0;1;38;5;153m\]-> \[\e[0m\]";
export PS2;
