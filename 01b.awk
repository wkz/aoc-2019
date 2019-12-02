#!/usr/bin/awk -f

{
	for (f = int($1 / 3) - 2; f > 0; f = int(f / 3) - 2)
		fuel += f
}

END {
	print(fuel)
}
