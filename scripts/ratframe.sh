# $1 is the operation
#	$1 == 0 gives the framenumber to the left or right.
#	$1 == 1 gives the framenumber above or below.
#	$1 == 2 a frame in the same window as the current frame, if there is one.
# $2 is the direction of the script. (default 0)
#	$2 == 0 is left or up depending on context.
#	$2 == 1 is right or down depending on context.

# $1 is the screennr you want to know x for.
screenx()
(
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
			if [ $nr == $1 ]; then
				echo ${x}
			fi
			current=""
		else
			current=${current}${c}
		fi
	done
)

# $1 is the sorting
#	$1 == 0 sorts by x
#	$1 == 1 sorts by y
frames()
(
	(dump="$(ratpoison -c "sfdump")"
	current=""
	for i in $(seq 0 ${#dump}); do
		c=${dump:i:1}
		if [ "$c" == "," ] || [ $i == ${#dump} ]; then
			i2=0
			nr=0
			x=0
			y=0
			screenNr=0
			for value in $current; do
				if [ $i2 == 2 ]; then
					nr=$value
				elif [ $i2 == 4 ]; then
					x=$value
				elif [ $i2 == 6 ]; then
					y=$value
				elif [ $i2 == 21 ]; then
					screenNr=$value
				fi
				i2=$((i2 + 1))
			done
			if [ "$1" == "1" ]; then
				echo ${y}-${x}-${nr}-${screenNr}
			else
				x=$(($x + $(screenx $screenNr)))
				echo ${x}-${y}-${nr}-${screenNr}
			fi
			current=""
		else
			current=${current}${c}
		fi
	done
	) | sort -n
)

inrow()
(
	if [ "$(echo $1 | cut -f4 -d-)" == "$(echo $2 | cut -f4 -d-)" ]; then
		if [ "$(echo $1 | cut -f2 -d-)" == "$(echo $2 | cut -f2 -d-)" ]; then
			echo "1"
		else
			echo "0"
		fi
	else
		if [ "$(echo $1 | cut -f2 -d-)" == "0" ]; then
			echo "1"
		else
			echo "0"
		fi
	fi
)

incolumn()
(
	if [ "$(echo $1 | cut -f4 -d-)" == "$(echo $2 | cut -f4 -d-)" ]; then
		if [ "$(echo $1 | cut -f2 -d-)" == "0" ]; then
			if [ "$(echo $1 | cut -f1 -d-)" == "$(echo $2 | cut -f1 -d-)" ]; then
				echo "0"
			else
				echo "1"
			fi
		else
			echo "0"
		fi
	else
		echo "0"
	fi
)

samewindow()
(
	if [ "$(echo $1 | cut -f4 -d-)" == "$(echo $2 | cut -f4 -d-)" ]; then
		echo "1"
	else
		echo "0"
	fi
)

if [ $1 == 1 ]; then
	curframes=$(frames 1)
elif [ $1 == 2 ]; then
	curframes=$(frames 1)
else
	curframes=$(frames)
fi
prevFrame=""
firstFrame=""
curFrame=""
doneH=""
doneL=""
doneC=""
done=0
skip=0
index=0

for frame in $curframes; do
	nr=$(echo $frame | cut -f3 -d-)
	if [ "$(ratpoison -c curframe)" == "$nr" ]; then
		curFrame=$frame
		break
	fi
done
for frame in $curframes; do
	skip=1
	if [ $1 == 0 ]; then
		if [ $(inrow $frame $curFrame) == "1" ]; then
			skip=0
		fi
	elif [ $1 == 2 ]; then
		if [ $(samewindow $frame $curFrame) == "1" ]; then
			skip=0
		fi
	elif [ $1 == 1 ]; then
		if [ $(incolumn $frame $curFrame) == "1" ]; then
			skip=0
		fi
	fi
	if [ $skip == 0 ]; then
		if [ "$firstFrame" == "" ]; then
			firstFrame=$frame
		fi
		if [ $done == 1 ]; then
			done=0
			doneL=$frame
		fi
	fi
	if [ "$curFrame" == "$frame" ]; then
		doneH=$prevFrame
		done=1
	fi
	if [ $skip == 0 ]; then
		prevFrame=$frame
	fi
done
if [ "$doneH" == "" ]; then
	doneH=$prevFrame
fi
if [ "$doneL" = "" ]; then
	doneL=$firstFrame
fi
if [ "$2" == "1" ]; then
	doneC=$doneL
else
	doneC=$doneH
fi
if [ $1 == 2 ]; then
	if [ "$doneC" == "$curFrame" ]; then
		doneC=""
	fi
fi
echo $(echo $doneC | cut -f3 -d-)
