ratpoison -c "gmove :$(~/git/dotfiles/scripts/ratframe.sh $1 $2)"
ratpoison -c "select -"
ratpoison -c "fselect $(~/git/dotfiles/scripts/ratframe.sh $1 $2)"
sleep .1
ratpoison -c other
