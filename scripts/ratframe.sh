frames=$((dump="$(ratpoison -c "sfdump")"
current=""
for i in $(seq 0 ${#dump}); do
	c=${dump:i:1}
	if [ "$c" == "," ] || [ $i == ${#dump} ]; then
		i2=0
		nr=0
		x=0
		screenNr=0
		for value in $current; do
			if [ $i2 == 2 ]; then
				nr=$value
			elif [ $i2 == 4 ]; then
				x=$value
			elif [ $i2 == 21 ]; then
				screenNr=$value
			fi
			i2=$((i2 + 1))
		done
		screenX=$(
			dump="$(ratpoison -c "sdump")"
			current=""
			for i in $(seq 0 ${#dump}); do
				c=${dump:i:1}
				if [ "$c" == "," ] || [ $i == ${#dump} ]; then
					i2=0
					nr=0
					x=0
					for value in $current; do
						if [ $i2 == 0 ]; then
							nr=$value
						elif [ $i2 == 1 ]; then
							x=$value
						fi
						i2=$((i2 + 1))
					done
					if [ $nr == $screenNr ]; then
						echo ${x}
					fi
					current=""
				else
					current=${current}${c}
				fi
			done
		)
		x=$(($x + $screenX))
		echo ${x}-${nr}
		current=""
	else
		current=${current}${c}
	fi
done
) | sort -n)
prevFrame=""
firstFrame=""
doneH=""
doneL=""
doneC=""
done=0
for frame in $frames; do
	if [ "$firstFrame" == "" ]; then
		firstFrame=$frame
	fi
	nr=$(echo $frame | cut -f2 -d-)
	if [ $done == 1 ]; then
		done=0
		doneL=$frame
	fi
	if [ "$(ratpoison -c curframe)" == "$nr" ]; then
		doneH=$prevFrame
		done=1
	fi
	prevFrame=$frame
done
if [ "$doneH" == "" ]; then
	doneH=$prevFrame
fi
if [ "$doneL" = "" ]; then
	doneL=$firstFrame
fi
if [ "$1" == "1" ]; then
	doneC=$doneL
else
	doneC=$doneH
fi
echo $(echo $doneC | cut -f2 -d-)
