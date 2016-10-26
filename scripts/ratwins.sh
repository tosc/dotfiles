mkdir -p ~/tmp/ratf/
curFrame=$(ratpoison -c "curframe")
info=$(
ratpoison -c "windows %s%n-%t" | while read p; do
	echo $p
done
)
echo $info > ~/tmp/ratf/$curFrame
echo $info
