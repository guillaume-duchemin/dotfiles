#!/bin/bash

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="spaceship"
ZSH_DISABLE_COMPFIX=true

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions history)

source $ZSH/oh-my-zsh.sh

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
alias cz="code ~/.zshrc";
alias sz="source ~/.zshrc";
alias ohmyzsh="code ~/.oh-my-zsh"
alias ll="ls -1a";
alias k="kubectl";

gitplugin() {
	code $HOME/.oh-my-zsh/plugins/git/git.plugin.zsh
}

code () { VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $* ;}

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
[[ -r "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]] && . "$(brew --prefix)/etc/profile.d/bash_completion.sh"

if command -v brew >/dev/null 2>&1; then
	# Load rupa's z if installed
	[ -f $(brew --prefix)/etc/profile.d/z.sh ] && source $(brew --prefix)/etc/profile.d/z.sh
fi

# automatically change node version if .nvmrc detected
cdnvm() {
    cd "$@";
    nvm_path=$(nvm_find_up .nvmrc | tr -d '\n')

    # If there are no .nvmrc file, use the default nvm version
    if [[ ! $nvm_path = *[^[:space:]]* ]]; then

        declare default_version;
        default_version=$(nvm version default);

        # If there is no default version, set it to `node`
        # This will use the latest version on your machine
        if [[ $default_version == "N/A" ]]; then
            nvm alias default node;
            default_version=$(nvm version default);
        fi

        # If the current version is not the default version, set it to use the default version
        if [[ $(nvm current) != "$default_version" ]]; then
            nvm use default;
        fi

        elif [[ -s $nvm_path/.nvmrc && -r $nvm_path/.nvmrc ]]; then
        declare nvm_version
        nvm_version=$(<"$nvm_path"/.nvmrc)

        declare locally_resolved_nvm_version
        # `nvm ls` will check all locally-available versions
        # If there are multiple matching versions, take the latest one
        # Remove the `->` and `*` characters and spaces
        # `locally_resolved_nvm_version` will be `N/A` if no local versions are found
        locally_resolved_nvm_version=$(nvm ls --no-colors "$nvm_version" | tail -1 | tr -d '\->*' | tr -d '[:space:]')

        # If it is not already installed, install it
        # `nvm install` will implicitly use the newly-installed version
        if [[ "$locally_resolved_nvm_version" == "N/A" ]]; then
            nvm install "$nvm_version";
        elif [[ $(nvm current) != "$locally_resolved_nvm_version" ]]; then
            nvm use "$nvm_version";
        fi
    fi
}
alias cd='cdnvm'
cd $PWD

# Avoid use commands with "g" prefix
PATH="/usr/local/opt/grep/libexec/gnubin:$PATH"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export NODE_PATH=`which node`

########################################################################################
########################################################################################
############################### MONOPRIX SPECIFIC CONFIG ###############################
########################################################################################
########################################################################################


#### GCP SDK ####

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/taku/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/taku/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/taku/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/taku/google-cloud-sdk/completion.zsh.inc'; fi

export GOOGLE_APPLICATION_CREDENTIALS="$HOME/workspaces/work/monop/service_account/service-account.json"

#### K8S & KUBCTL ####

source <(kubectl completion zsh)

# kubernetes port-forward
export MPX_DIRECTORY=~/workspaces/work/monop
export SCRIPTS_DIRECTORY=${MPX_DIRECTORY}/dev-tools/kubectl/
alias kubpf=$SCRIPTS_DIRECTORY'kubectlPortForward.sh'
alias kubmongopf=$SCRIPTS_DIRECTORY'kubectlPortForwardMongo.sh'
alias kublog=$SCRIPTS_DIRECTORY'kubectlLog.sh'
alias kublogs=$SCRIPTS_DIRECTORY'kubectlLogs.sh'
alias kubssh=$SCRIPTS_DIRECTORY'kubectlSsh.sh'

alias kubgpf=$SCRIPTS_DIRECTORY'pf-graphql.sh'
alias kubepf=$SCRIPTS_DIRECTORY'pf-export.sh'
alias kubbpf=$SCRIPTS_DIRECTORY'pf-bo.sh'
alias kubupf=$SCRIPTS_DIRECTORY'pf-utils.sh'
alias kubdpf=$SCRIPTS_DIRECTORY'pf-digest.sh'
alias kubpepf=$SCRIPTS_DIRECTORY'pf-price-engine.sh'

alias kubpspf=$SCRIPTS_DIRECTORY'pf-ps.sh'

alias kub='/usr/local/bin/kubectl'
alias kubnd='kubectl config use-context ninja-dev'
alias kubnpp='kubectl config use-context ninja-preprod'
alias kubnp='kubectl config use-context ninja-prod'
alias kk='killall kubectl'

complete -F __start_kubectl kub

#### WORK SETTINGS ####

alias openmonop="code $MPX_DIRECTORY/monop.code-workspace"
