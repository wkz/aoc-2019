#!/bin/sh

program=$1

thrust() {
    socat system:'echo 0; while read line; do echo $line >&2; echo $line; done' \
	  system:"{ echo $1;  cat 2>/dev/null; } | awk -f 05.awk -v program=$program | \
	  	  { echo $2;  cat 2>/dev/null; } | awk -f 05.awk -v program=$program | \
		  { echo $3;  cat 2>/dev/null; } | awk -f 05.awk -v program=$program | \
		  { echo $4;  cat 2>/dev/null; } | awk -f 05.awk -v program=$program | \
		  { echo $5;  cat 2>/dev/null; } | awk -f 05.awk -v program=$program" \
	  2>&1 | tail -n 1
}


max=0

for a in $(seq 5 9); do
    for b in $(seq 5 9 | grep -v $a); do
	for c in $(seq 5 9 | grep -ve "$a\|$b"); do
	    for d in $(seq 5 9 | grep -ve "$a\|$b\|$c"); do
		for e in $(seq 5 9 | grep -ve "$a\|$b\|$c\|$d"); do
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
