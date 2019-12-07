#!/bin/sh

program=$1

thrust() {
    echo 0 | \
	{ echo $1; cat; } | awk -f 05.awk -v program=$program | \
	{ echo $2; cat; } | awk -f 05.awk -v program=$program | \
	{ echo $3; cat; } | awk -f 05.awk -v program=$program | \
	{ echo $4; cat; } | awk -f 05.awk -v program=$program | \
	{ echo $5; cat; } | awk -f 05.awk -v program=$program
}


max=0

for a in $(seq 0 4); do
    for b in $(seq 0 4 | grep -v $a); do
	for c in $(seq 0 4 | grep -ve "$a\|$b"); do
	    for d in $(seq 0 4 | grep -ve "$a\|$b\|$c"); do
		for e in $(seq 0 4 | grep -ve "$a\|$b\|$c\|$d"); do
		    t=$(thrust $a $b $c $d $e)
		    if [ $t -gt $max ]; then
			max=$t
			out="$a,$b,$c,$d,$e"
		    fi
		done
	    done
	done
    done
done

echo $max at $out
