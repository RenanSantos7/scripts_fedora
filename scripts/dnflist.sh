#!/bin/zsh

function dnflist {
    if [[ -z "$1" ]]; then
        dnf list --installed
        return
    fi
	
	if ! dnf list --installed | grep --quiet -- "$1"; then
        echo "$1 não instalado pelo dnf"
    else
        dnf list --installed | grep -- "$1"
    fi
}
