#!/bin/bash

id_current=$(cat ~/.scripts/Conky/conky-spotify/current/current.txt)
id_new=`~/.scripts/Conky/conky-spotify/scripts/id.sh`
cover=
imgurl=

if [ "$id_new" != "$id_current" ]; then

	cover=`ls ~/.scripts/Conky/conky-spotify/covers | grep $id_new`

	if [ "$cover" == "" ]; then

	    imgurl=`~/.scripts/Conky/conky-spotify/scripts/imgurl.sh $id_new`
	    wget -q -O ~/.scripts/Conky/conky-spotify/covers/$id_new.jpg $imgurl &> /dev/null
	    touch ~/.scripts/Conky/conky-spotify/covers/$id_new.jpg
		# clean up covers folder, keeping only the latest X amount, in below example it is 10
	    rm -f `ls -t ~/.scripts/Conky/conky-spotify/covers/* | awk 'NR>10'`
	    rm -f wget-log #wget-logs are accumulated otherwise
	    cover=`ls ~/.scripts/Conky/conky-spotify/covers | grep $id_new`
	fi

	if [ "$cover" != "" ]; then
		cp ~/.scripts/Conky/conky-spotify/covers/$cover ~/.scripts/Conky/conky-spotify/current/current.jpg
	else
		cp ~/.scripts/Conky/conky-spotify/empty.jpg ~/.scripts/Conky/conky-spotify/current/current.jpg
	fi

	echo $id_new > ~/.scripts/Conky/conky-spotify/current/current.txt
fi
