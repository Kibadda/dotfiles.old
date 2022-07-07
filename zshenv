export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export KEYID=0x3B6861376B6D3D78
export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent

export TOBI=0x4b7228cfe59b7380

encrypt() {
    if [ -f "$2" ]; then
        output=~/"${2}".$(date +%s).enc
        gpg --encrypt --armor --sign --output ${output} -r ${1} "${2}" && echo "${2} -> ${output}"
    else
        echo $2 | gpg --armor --clearsign | gpg --encrypt --armor --recipient $1
    fi
}

decrypt() {
    if [ -f "$1" ]; then
        output=$(echo "${1}" | rev | cut -c16- | rev)
        gpg --decrypt --output ${output} "${1}" && echo "${1} -> ${output}"
    else
        MESSAGE="$(echo $1 | gpg --decrypt --armor)"
        echo $MESSAGE | gpg --verify
        echo $MESSAGE
    fi
}
