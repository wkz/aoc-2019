#!/usr/bin/awk -f

BEGIN {
	FS=")";
}

{
	map[$2] = $1;
}

END {
	for (key in map) {
		for (; length(map[key]); key = map[key])
			edges++;
	}

	print edges
}
