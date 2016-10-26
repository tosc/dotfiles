mergeWindow=$(~/git/dotfiles/scripts/ratframe.sh 2)
if [ "$mergeWindow" == "" ]; then
	echo "Don't merge"	
else
	echo "Merge"
	oldW="$(ratpoison -c 'curframe')"
	ratpoison -c "gselect f$mergeWindow"
	ratpoison -c "gmerge f$oldW"
	ratpoison -c "gdelete f$oldW"
	ratpoison -c remove
	rm ~/tmp/ratf/$oldW
fi
