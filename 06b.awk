#!/usr/bin/awk -f

BEGIN {
	FS=")";
}

{
	map[$2] = $1;
}

END {
	for (at = map["SAN"]; length(map[at]); at = map[at])
		san[at] = distance++;

	distance = 0;
	for (at = map["YOU"]; length(map[at]); at = map[at]) {
		if (san[at] > 0) {
			print distance + san[at]
			exit 0;
		}

		distance++;
	}

	exit 1;
}
