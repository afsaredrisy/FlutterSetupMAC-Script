#!/bin/zsh

if [[ $(ls sdk/flutter/bin 2&> /dev/null ) ]]; then
	if [[ -z $(echo $PATH | grep sdk/flutter/bin) ]]; then
		export PATH="$PATH:sdk/flutter/bin";
		source ~/.zshrc > /dev/null;
		flutter upgrade --force;
		echo "\n\nFlutter added to environement!"
		zsh;
	else
		echo "Flutter already installed!";
	fi
else
	data=$(curl --silent "https://storage.googleapis.com/flutter_infra/releases/releases_macos.json" | grep -m 2 -A 4 '"channel": "stable"')
	url=$(echo $data | grep archive | cut -d '"' -f4)
	curl --progress-bar "https://storage.googleapis.com/flutter_infra/releases/$url" > $HOME/flutter.zip;
	unzip -q $HOME/flutter.zip -d $HOME/.;
	rm -f $HOME/flutter.zip;
	if [[ -z $(echo $PATH | grep $HOME/flutter/bin) ]]; then
		export PATH="$PATH:$HOME/flutter/bin";
		source ~/.zshrc > /dev/null;
	fi
	chmod -R 777 "$HOME/flutter"
	flutter doctor;
	echo "\n\nFlutter installation done!";
	zsh;
fi
