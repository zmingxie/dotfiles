case "$TERM" in
    xterm-256color) color_prompt=yes;;
esac

export TMPDIR=/tmp
export CLICOLOR=1
export EDITOR=/usr/local/bin/vim

## Make sure that we're always using vim
alias vi='vim'

## Make sure that prompt has nice colors
export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.flac=01;35:*.mp3=01;35:*.mpc=01;35:*.ogg=01;35:*.wav=01;35:'

# Show Git Branch name
source ~/.git-prompt.sh
PS1='\[\033[0;1;35m\]\u@\h: \[\033[0;32m\]\W$(__git_ps1 " (%s)") >\[\033[0m\] '

export PATH=/usr/local/bin:/usr/local/sbin:$PATH
# Bash git completion
if [ -f /usr/local/etc/bash_completion ]; then
    . /usr/local/etc/bash_completion
fi

alias ls='gls --color=auto' ## Only works with 'brew install coreutils'


export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

# added by travis gem
[ -f /Users/mingxie/.travis/travis.sh ] && source /Users/mingxie/.travis/travis.sh

complete -C /usr/local/bin/vault vault

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
source <(kubectl completion bash)
alias k=kubectl
complete -F __start_kubectl k

complete -C /usr/local/Cellar/tfenv/2.0.0/versions/0.13.0/terraform terraform

complete -C /usr/local/Cellar/tfenv/2.0.0/versions/0.13.4/terraform terraform

# >>>> Vagrant command completion (start)
. /opt/vagrant/embedded/gems/2.2.10/gems/vagrant-2.2.10/contrib/bash/completion.sh
# <<<<  Vagrant command completion (end)
