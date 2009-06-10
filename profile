#!/bin/sh

. ~/.bashrc
[ `id -u` = 600 ] && calendar -A 5

# Smart Git Pull one time in 3 days
if [ -d ~/dotfiles ]; then
	touch ~/dotfiles/.now
	# create if .update does not exist
	[ ! -r ~/dotfiles/.update ] && touch ~/dotfiles/.update

	if [ ~/dotfiles/.update -ot ~/dotfiles/.now -a -x `which git-pull` ]; then
		cd ~/dotfiles && git pull -q origin master 2>/dev/null &
		touch -d "`date --date='3 days' +%D`" ~/dotfiles/.update
	fi
fi
