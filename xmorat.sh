ratpoison -c "windows %f-%s%n-%t" | while read p; do
if [ "${p:0:1}" == "-" ]; then
	echo "<fc=#696665>${p:2}</fc> " | tr -d "\n"
else
	if [ "${p:2:1}" == "*" ]; then
		echo "<fc=#ee9a00>${p:3}</fc> " | tr -d "\n"
	else
		echo "${p:3} " | tr -d "\n"
	fi
fi
done
