
name="name"

if [ "$1" = "$name" ]
then
    echo  $(playerctl metadata --player spotify --format "{{title}} - {{artist}}")
fi

if [ "$1" = "pause" ]
then
	playerctl pause --player spotify
fi

if [ "$1" = "play" ]
then
	playerctl play --player spotify
fi

if [ "$1" = "toggle" ]
then
	st=$(playerctl status --player spotify)
	if [ "$st" = "Playing" ]
	then
		playerctl pause --player spotify
	fi
	if [ "$st" = "Paused" ]
	then
		playerctl play --player spotify
	fi
fi
if [ "$1" = "status" ]
then
	st=$(playerctl status --player spotify)
	if [ "$st" = "Playing" ]
	then
		echo ""
	fi
	if [ "$st" = "Paused" ]
	then
		echo ""
	fi
fi
if [ "$1" = "next" ]
then
	playerctl next --player spotify
fi

