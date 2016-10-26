mkdir -p ~/tmp/ratf/
curFrame="$(~/git/dotfiles/scripts/ratframe.sh 3)"
frameNr=$(echo $curFrame | cut -f3 -d-)
sortNr=$(echo $curFrame | cut -f5 -d-)
info=$(
ratpoison -c "windows %s%x%n-%t" | while read p; do
	echo $p
done
)
echo $info > ~/tmp/ratf/$sortNr-$frameNr
echo $info
