# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH



# Path to your oh-my-zsh installation.
export ZSH="/home/$USER/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="jtriley"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(adb
         command-not-found
         colorize
         composer z)
source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

favoka=u0504861@favoka.art
climbtech=u0673162@climbtech.ru
finfactory_back="andrew@my.finfactory.one/api -p 2067"
finfactory_front="andrew@my.finfactory.one"
finfactory_bd="andrew@176.122.25.49 -p 2067"

favoka_mount=$favoka:/var/www/u0504861/data
alias mount_favoka="sshfs $favoka_mount ~/favoka-prod"

export VISUAL="emacsclient"
export EDITOR="$VISUAL"

# | clip
alias clip="xclip -sel clip"

h265(){
    case $1 in
        "-h" | "")
            echo "h265 \$1 File input \$2 output";;
        *)
            echo ffmpeg -i $file -c:v libx265 -c:a copy $out
            ffmpeg -i "$1" -c:v libx265 -c:a copy "$2";;
    esac
}

vapi(){
    case $1 in
        -h | "")
            echo "vapi\n\$1\tFile name\n\$2\toutput";;
        *)
            ffmpeg -i "$1" -c:v libvpx-vp9 -pass 2 -b:v 1000K -threads 8 -speed 1 \
                -tile-columns 6 -frame-parallel 1 -auto-alt-ref 1 -lag-in-frames 25 \
                -c:a libopus -b:a 64k -f webm "$2";;
    esac
}

export USE_CCACHE=1
export CCACHE_EXEC=/usr/bin/ccache
export CCACHE_DIR=/mnt/Home/ccache
export ANDROID_JACK_VM_ARGS="-Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx4G"

if [ -d "/opt/atlassian/plugin-sdk/bin" ] ; then
    PATH="/opt/atlassian/plugin-sdk/bin:$PATH"
fi

if [ -d "/opt/toolchains/arm-eabi-4.6/bin" ] ; then
    PATH="/opt/toolchains/arm-eabi-4.6/bin:$PATH"
fi

PATH="/home/andrew/.local/share/gem/ruby/2.7.0/bin:$PATH"

alias python=python2

export PATH="$PATH:/home/$USER/.dotnet/tools"
export PATH="$PATH:/home/$USER/.emacs.d/bin"
export PATH="$PATH:/home/$USER/.local/bin"

alias rf="gnome-terminal --role=ranger -x ranger"

export VISUAL="emacsclient -n"
export PAGER=more
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

ssh-add  "/home/$USER/.ssh/finfactory"

alias em="emacsclient -n"

alias dotnet-test-debug="VSTEST_HOST_DEBUG=1 dotnet test"

alias list-packages='expac -H M "%011m\t%-20n\t%10d" $(comm -23 <(yay -Qqen | sort) <({ yay -Qqe; expac -l "\n" "%E" base; } | sort | uniq)) | sort -n | less'

if [ -d "/mnt/Home/nuget" ]; then
   export NUGET_PACKAGES="/mnt/Home/nuget"
fi

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
