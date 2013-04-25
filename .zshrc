print_branch_name() {
    hgroot=`hg root` &> /dev/null #redirecting stdout AND stderr ensures that any output of this command will not be sent to the caller/the terminal
    if [ -n "$hgroot" ] #check if the variable is not empty
        then
#        cat "$hgroot/.hg/branch"
        echo `cat $hgroot/.hg/branch` `hg id -ni`
#        echo `cat $hgroot/.hg/branch` `echo \`hg id -n; hg id -i\` | tr ' ' ':'`
    else
        echo 'n/a'
        return 1
    fi  
}

# aliases
if [ -f ~/.aliases ]; then
    . ~/.aliases
fi

# set up the prompt
autoload -Uz promptinit
promptinit
prompt elite2

#export ps1="\$(print_branch_name) %{^[[01;36m%}(%{^[[22;36m%}%n%{^[[01;30m%}@%{^[[22;36m%}%m%{^[[01;36m%})%{^[[01;36m%}(%{^[[22;36m%}%!%{^[[01;30m%}/%{^[[22;36m%}%y%{^[[01;36m%})%{^[[01;36m%}(%{^[[22;36m%}%d{%i:%m%p}%{^[[01;30m%}:%{^[[22;36m%}%d{%m/%d/%y}%{^[[01;36m%})%{^[[01;30m%}-%{^[[00m%}
#%{^M%}%{^[[01;36m%}(%{^[[22;36m%}%#%{^[[01;30m%}:%{^[[22;36m%}%~%{^[[01;36m%})%{^[[01;30m%}-%{^[[00m%} "

#export PS1="%{^[[0;92m%}hg: \$(print_branch_name) %{^[[01;36m%}(%{^[[22;36m%}%#%{^[[01;30m%}:%{^[[22;36m%}%~%{^[[01;36m%})%{^[[02;36m%} ------------------------------
#%{^M%}%{^[[01;36m%}(%{^[[22;36m%}%n%{^[[01;30m%}@%{^[[22;36m%}%m%{^[[01;36m%})%{^[[01;36m%}(%{^[[22;36m%}%!%{^[[01;30m%}/%{^[[22;36m%}%y%{^[[01;36m%})%{^[[01;36m%}(%{^[[22;36m%}%D{%I:%M%P}%{^[[01;30m%}:%{^[[22;36m%}%D{%m/%d/%y}%{^[[01;36m%})%{^[[01;30m%}-%{^[[00m%} "

export PS1="%{^[[22;36m%}%{^[[22;36m%}%~%{^[[02;36m%}%{^[[01;36m%} -.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.- %{^[[22;36m%}%n%{^[[01;36m%}@%{^[[22;36m%}%m%{^[[01;36m%}|%{^[[22;36m%}%!%{^[[01;30m%}/%{^[[22;36m%}%y%{^[[01;36m%}|%{^[[22;36m%}%D{%I:%M%P}%{^[[01;30m%}:%{^[[22;36m%}%D{%Y-%m-%d}
%{^[[01;36m%}hg: \$(print_branch_name) %{^[[01;30m%}%{^[[00m%} "

#export PS1=''

#print_pre_prompt () 
#{ 
#    PS1L=$PWD
#    if [[ $PS1L/ = "$HOME"/* ]]; then PS1L=\~${PS1L#$HOME}; fi
#    PS1R=$USER@$HOSTNAME
#    printf "%s%$(($COLUMNS-${#PS1L}))s" "$PS1L" "$PS1R"
#}
#PROMPT_COMMAND=print_pre_prompt
#PS1=`print_pre_prompt`

HISTFILE=~/.histfile
HISTSIZE=10000000
SAVEHIST=90000000
setopt appendhistory autocd beep extendedglob nomatch notify share_history
setopt histignorealldups
#extendedhistory

# use emacs keybindings even if our editor is set to vi
#bindkey -e


# use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)ls_colors}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %sat %p: hit tab for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={a-z}' 'm:{a-za-z}={a-za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %sscrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $user -o pid,%cpu,tty,cputime,cmd'



bindkey '5D' emacs-backward-word
bindkey '5C' emacs-forward-word
bindkey ';5D' emacs-backward-word
bindkey ';5C' emacs-forward-word
bindkey '^[OD' emacs-backward-word
bindkey '^[OC' emacs-forward-word
bindkey '^[[1;5D' emacs-backward-word
bindkey '^[[1;5C' emacs-forward-word
bindkey "^[[1~" beginning-of-line   # home
bindkey "^[[4~" end-of-line         # end
bindkey '^[[3~' delete-char            # del

#bindkey -v
#bindkey "^p" vi-up-line-or-history
#bindkey "^n" vi-down-line-or-history
#
#
#bindkey "^[oh" vi-beginning-of-line   # home
#bindkey "^[of" vi-end-of-line         # end
#
#bindkey "^[[1~" vi-beginning-of-line   # home
#bindkey "^[[4~" vi-end-of-line         # end
#bindkey '^[[2~' beep                   # insert
#bindkey '^[[3~' delete-char            # del
#bindkey '^[[5~' vi-backward-blank-word # page up
#bindkey '^[[6~' vi-forward-blank-word  # page down
#
#bindkey '5d' vi-backward-blank-word 
#bindkey '5c' vi-forward-blank-word
#bindkey ';5d' vi-backward-blank-word 
#bindkey ';5c' vi-forward-blank-word
#
#bindkey -m vicmd '^r' history-incremental-search-backward


export WORDCHARS="*?_-[]~=!#$%^(){}"

case $TERM in
    xterm*)
        precmd () {print -Pn "\e]0;%n@%m: %~\a"}
        ;;
esac
