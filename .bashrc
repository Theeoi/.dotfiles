#
# ~/.bashrc
#

[[ $- != *i* ]] && return

colors() {
	local fgc bgc vals seq0

	printf "Color escapes are %s\n" '\e[${value};...;${value}m'
	printf "Values 30..37 are \e[33mforeground colors\e[m\n"
	printf "Values 40..47 are \e[43mbackground colors\e[m\n"
	printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"

	# foreground colors
	for fgc in {30..37}; do
		# background colors
		for bgc in {40..47}; do
			fgc=${fgc#37} # white
			bgc=${bgc#40} # black

			vals="${fgc:+$fgc;}${bgc}"
			vals=${vals%%;}

			seq0="${vals:+\e[${vals}m}"
			printf "  %-9s" "${seq0:-(default)}"
			printf " ${seq0}TEXT\e[m"
			printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
		done
		echo; echo
	done
}

[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

# Change the window title of X terminals
case ${TERM} in
	xterm*|rxvt*|Eterm*|aterm|kterm|gnome*|interix|konsole*)
		PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\007"'
		;;
	screen*)
		PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\033\\"'
		;;
esac

use_color=true

# Set colorful PS1 only on colorful terminals.
# dircolors --print-database uses its own built-in database
# instead of using /etc/DIR_COLORS.  Try to use the external file
# first to take advantage of user additions.  Use internal bash
# globbing instead of external grep binary.
safe_term=${TERM//[^[:alnum:]]/?}   # sanitize TERM
match_lhs=""
[[ -f ~/.dir_colors   ]] && match_lhs="${match_lhs}$(<~/.dir_colors)"
[[ -f /etc/DIR_COLORS ]] && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
[[ -z ${match_lhs}    ]] \
	&& type -P dircolors >/dev/null \
	&& match_lhs=$(dircolors --print-database)
[[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] && use_color=true

function git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

if ${use_color} ; then
	# Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
	if type -P dircolors >/dev/null ; then
		if [[ -f ~/.dir_colors ]] ; then
			eval $(dircolors -b ~/.dir_colors)
		elif [[ -f /etc/DIR_COLORS ]] ; then
			eval $(dircolors -b /etc/DIR_COLORS)
		fi
	fi

	if [[ ${EUID} == 0 ]] ; then
        PS1='\[\033[1;32m\]\h\[\033[1;37m\] \W \[\033[0;36m\]$(git_branch)\[\033[1;32m\]->\[\033[00m\] '
	else
		PS1='\[\033[1;32m\]\u@\h\[\033[1;37m\] \W \[\033[0;36m\]$(git_branch)\[\033[1;32m\]->\[\033[00m\] '
	fi

	alias ls='ls --color=auto'
	alias grep='grep --colour=auto'
	alias egrep='egrep --colour=auto'
	alias fgrep='fgrep --colour=auto'
else
	if [[ ${EUID} == 0 ]] ; then
		# show root@ when we don't have colors
		PS1='\u@\h \W \$ '
	else
		PS1='\u@\h \w \$ '
	fi
fi

unset use_color safe_term match_lhs sh

alias mkdir="mkdir -p"                    # create dir recursively
alias rm="irm"                            # use irm (function below) as default 
alias cp="cp -i"                          # confirm before overwriting something
alias mv="mv -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias np='nano -w PKGBUILD'
alias more=less

xhost +local:root > /dev/null 2>&1

complete -cf sudo

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.  #65623
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize

shopt -s expand_aliases

# export QT_SELECT=4

## Bash history fixes
shopt -s histappend # Enable history appending instead of overwriting.  #139609
HISTTIMEFORMAT="%F %T " # Adds date and time to history command
HISTCONTROL=ignoredups # No duplicates

function hg() {
    history | grep "$1";
}

#
# # ex - archive extractor
# # usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

## Vim as default editor
export EDITOR=vim
set -o vi #Vim commands in CL

## Improved folder movement
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

## An implementation of a wastebasket for the rm command.
# Taken from: https://github.com/beala/irm/blob/master/irm.sh
TRASH="$HOME/.local/share/Trash/files"  #The trashcan directory within your home directory

irm()
{

  #Check to make sure there are arguments to operate on.
  if [ $# = 0 ]; then
    echo "No arguments provided."
    echo "Type irm -e to empty the trash."
    echo "Type irm [file1 file2 ...] to delete file1 file2 etc."
    return
  fi

  #Check to make sure the trashcan exists.
  if [ ! -e "$TRASH" ];then
    echo "$TRASH does not exist. Would you like to create it? Y/N"
    read INPUT

    if [[ $INPUT = "Y" || $INPUT = "y" ]]; then
      mkdir "$TRASH"
      echo "Trashcan created."
    else
      echo "Ok, no trashcan was created and no files were deleted."
      return
    fi
  fi

  #Check for the -e flag, which empties the trash.
  if [ "$1" = "-e" ]; then
    echo "Are you sure you wish to empty the trash? Y/N"
    read VERIFY

    if [[ $VERIFY = "Y" || $VERIFY = "y" ]]; then
      \rm -rf "$TRASH"/*
      echo "Trash emptied."
    else
      echo "Ok, nothing has been deleted."
    fi

    return
  fi

  #Finally, move the specified files to the trash.
  SAVEIFS=$IFS
  IFS=$(echo -en "\n\b")

  for i in $*; do
    if [ -e "$i" ]; then #Make sure each file exists before moving.
      if [ -e "$TRASH/$i" ]; then #Make sure we're not overwriting a trashed file.
        echo "A file named $i already exists in the trashcan. Overwrite? Y/N"
        read INPUT
        if [[ $INPUT = "Y" || $INPUT = "y" ]]; then
          \rm -rf "$TRASH/$i"
        else
          echo "Ok, $i was not deleted. Continuing..."
          continue
        fi
      fi
      mv "$i" "$TRASH/"
    else
      echo "File $i does not exist."
    fi
  done

  IFS=$SAVEIFS
}
