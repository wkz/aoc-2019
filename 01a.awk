#!/usr/bin/awk -f

{
	fuel += int($1 / 3) - 2
}

END {
	print(fuel)
}
