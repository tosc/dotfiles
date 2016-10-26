mergeWindow=$(~/git/dotfiles/scripts/ratframe.sh 2)
if [ "$mergeWindow" == "" ]; then
	echo "Don't merge"	
else
	echo "Merge"
	ratpoison -c "gmerge f$mergeWindow"
	ratpoison -c "gdelete f$mergeWindow"
	ratpoison -c remove
fi
