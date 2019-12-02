#!/bin/sh

awk -f 02.awk -v noun=12 -v verb=2 <02.in

for noun in $(seq 0 99); do
    for verb in $(seq 0 99); do
	res=$(awk -f 02.awk -v noun=$noun -v verb=$verb <02.in)
	if [ $res -eq 19690720 ]; then
	    echo $(($noun * 100 + $verb))
	    exit 0
	fi
    done
done

exit 1
