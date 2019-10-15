#!/bin/bash
if [[ -z "$1" ]] ; then
	echo "usage: sh valgrind_filter.sh [executable compiled with -g3 option] [argument(s)]"
	exit 1
fi

name=log
if [[ -e $name.txt ]] ; then
	i=0
	while [[ -e $name-$i.txt ]] ; do
		let i++
	done
	name=$name-$i
fi
touch "$name".txt

name2=log2
if [[ -e $name2.txt ]] ; then
	i=0
	while [[ -e $name2-$i.txt ]] ; do
		let i++
	done
	name2=$name-$i
fi
touch "$name2".txt

valgrind --leak-check=full --show-leak-kinds=all --log-file="$name".txt -q ./"$@"
n_line=$(< "$name".txt wc -l)
cat "$name".txt | grep 'c:[0123456789]*)' -B $n_line > "$name2".txt
if [[ -s "$name2".txt ]] ; then
	echo '--' >> "$name2".txt
	echo "\033[31mHere are the problems that Valgrind found in your program:\033[00m"
	cat -e "$name2".txt |  tail -r | awk '/--\$/{flag=1} /== \$/{flag=0} flag'  | tail -r | tr '\$' ' '
else
	echo "\033[32mNo problem found within your program"
fi
rm -rf "$name".txt "$name2".txt $1.dSYM
