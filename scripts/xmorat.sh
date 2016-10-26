test=$(~/git/dotfiles/scripts/ratwins.sh)
curFrame="$(~/git/dotfiles/scripts/ratframe.sh 3)"
frameNr=$(echo $curFrame | cut -f3 -d-)
screenNr=$(echo $curFrame | cut -f4 -d-)
echo $(
	first=1
	lastScreenNr=""
	ls ~/tmp/ratf/ | while read p; do
		frame=$(cat ~/tmp/ratf/$p)
		if [ "${frame:1:1}" == $lastScreenNr ]; then
			:
		else
			echo "<fc=#ee9a00>|</fc> "
			lastScreenNr=${frame:1:1}
		fi
		if [ "${frame:0:1}" == "N" ]; then
			echo ""
		else
			for i in $frame; do
				if [ "${p:2:1}" == "$frameNr" ]; then
					if [ "${i:0:1}" == "*" ]; then
						echo "<fc=#ee9a00>${i:2:10}</fc> "
					else
						echo "<fc=#2ECC71>${i:2:10}</fc> "
					fi
				else
					if [ "${i:1:1}" == "$screenNr" ]; then
						echo "<fc=#F08080>${i:2:10}</fc> "
					else
						echo "<fc=#696665>${i:2:10}</fc> "
					fi
				fi
			done
		fi
	done
)
