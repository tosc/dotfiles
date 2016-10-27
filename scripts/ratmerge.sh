mergeWindow=$(~/git/dotfiles/scripts/ratframe.sh 2)
if [ "$mergeWindow" == "" ]; then
	echo "Don't merge"	
else
	echo "Merge"

	curFrame="$(~/git/dotfiles/scripts/ratframe.sh 3)"
	oldW=$(echo $curFrame | cut -f3 -d-)
	sortNr=$(echo $curFrame | cut -f5 -d-)
	ratpoison -c "gselect f$mergeWindow"
	ratpoison -c "gmerge f$oldW"
	ratpoison -c "gdelete f$oldW"
	ratpoison -c remove
	rm ~/tmp/ratf/*
fi
