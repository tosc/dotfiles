frame=$(~/git/dotfiles/scripts/ratframe.sh 3)
curframe=$(ratpoison -c "curframe")
screenNr=$(echo $frame | cut -f4 -d-)
group=$(
	ratpoison -c 'groups' | while read p; do
		groupNr=$(echo $p | cut -f2 -d:)
		if [ $groupNr == $curframe ]; then
			echo $p
		fi
	done
)
prevMsg=$(echo $group | cut -f3 -d:)
if [ "$group" == "" ]; then
	ratpoison -c "gnewbg :$curframe:"
	ratpoison -c "gselect :$curframe:"
else
	ratpoison -c "gselect :$curframe:"
	msg=$((
		ratpoison -c "windows %s%x%n-%t" | while read p; do
			if [ "${p:0:1}" == "N" ]; then
				echo "-$screenNr"
			else
				echo $p
			fi
		done
	) | tr "\n" " ")
	if [ "$msg" == "$prevMsg" ]; then
		:
	else	
		ratpoison -c "grename :$curframe:$msg"
	fi
fi
echo ""
