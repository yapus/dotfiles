#!/bin/sh

. ~/.bashrc
[ `id -un` = vlad -a -x /usr/bin/cpp  ] && calendar -A 5

if [[ -f /etc/bash_completion ]]; then
    . /etc/bash_completion
fi

# Smart Git Pull one time in 3 days
if [ -d ~/dotfiles ]; then
	touch ~/dotfiles/.now
	# create if .update does not exist
	[ ! -r ~/dotfiles/.update ] && touch ~/dotfiles/.update

	if [ ~/dotfiles/.update -ot ~/dotfiles/.now -a -x "`which git`" ]; then
		( (cd ~/dotfiles && git pull -q origin master 2>/dev/null >/dev/null )& )
		touch -d "`date --date='3 days' +%D`" ~/dotfiles/.update
		[ -x ~/dotfiles/.upgrade ] && ~/dotfiles/.upgrade
	fi
fi

[ -x /usr/bin/keychain ] && /usr/bin/keychain

if [ -d "$HOME/.rbenv" ]; then
	export PATH="$HOME/.rbenv/bin:$PATH"
	eval "$(rbenv init -)"
fi
