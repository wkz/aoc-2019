#!/usr/bin/awk -f

function is_candidate(num,    repeat) {
	last = substr(num, 1, 1);

	for (i = 2; i <= length(num); i++) {
		this = substr(num, i, 1)

		if (this < last)
			return 0;

		if (this == last)
			repeat++;

		last = this;
	}

	return repeat;
}

BEGIN {
	FS="-";
}

{
	for (num = $1; num < $2; num++) {
		if (is_candidate(num)) {
			candidates++;
		}
	}
}

END {
	print candidates;
}
