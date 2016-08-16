amixer get -M Master | awk '$0~/%/{ print $4 }' | tr -d "[]"
