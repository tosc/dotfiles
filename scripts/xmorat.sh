test=$(~/git/dotfiles/scripts/ratwins.sh)
curframe="$(ratpoison -c 'curframe')"
echo $(
	echo "<fc=#ee9a00>|</fc> "
	ls ~/tmp/ratf/ | while read p; do
		frame=$(cat ~/tmp/ratf/$p | while read l; do
			echo $l
		done)
		if [ "${frame:0:1}" == "N" ]; then
			echo ""
		else
			for i in $frame; do
				if [ "$p" == "$curframe" ]; then
					if [ "${i:0:1}" == "*" ]; then
						echo "<fc=#ee9a00>${i:1}</fc> "
					else
						echo ${i:1}
					fi
				else
					echo "<fc=#696665>${i:1}</fc> "
				fi
			done
		fi
	echo "<fc=#ee9a00>|</fc> "
	done
)
