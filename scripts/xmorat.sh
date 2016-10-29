curframe=$(ratpoison -c "curframe")
lastScreenNr=""
first=1
sortlines=$(~/git/dotfiles/scripts/ratframe.sh 4)
echo $((ratpoison -c "groups" | while read p; do
	group=${p:3}
	frameNr=$(echo $group | cut -f1 -d:)
	index=0
	sortNr=$(
		for sortFNr in $sortlines; do
			if [ "$sortFNr" == "$frameNr" ]; then
				echo $index	
				break
			fi
			index=$((index + 1))			
		done
	)
	echo $sortNr:$group
done) | sort -n | while read frame; do
	frameInfo=$(echo $frame | cut -f3 -d:)
	frameNr=$(echo $frame | cut -f2 -d:)
	if [ $first == 1 ]; then
		first=0
		lastScreenNr="${frameInfo:1:1}"
	fi
	if [ "${frameInfo:1:1}" == $lastScreenNr ]; then
		:
	else
		echo "<fc=#ee9a00>|</fc> "
		lastScreenNr=${frameInfo:1:1}
	fi
	for window in $frameInfo; do
		if [ "$frameNr" == "$curframe" ]; then
			if [ "${window:0:1}" == "*" ]; then
				echo "<fc=#ee9a00>${window:2:10}</fc> "
			else
				echo "<fc=#F08080>${window:2:10}</fc> "
			fi
		else
			echo "<fc=#696665>${window:2:10}</fc> "
		fi
	done
done)
