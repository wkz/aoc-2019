#!/usr/bin/awk -f

function is_candidate(num,    repeat, double) {
	last = substr(num, 1, 1);

	for (i = 2; i <= length(num); i++) {
		this = substr(num, i, 1)

		if (this < last)
			return 0;

		if (this == last)
			repeat++;
		else {
			if (repeat == 1)
				double++;

			repeat = 0;
		}

		last = this;
	}

	return double || (repeat == 1);
}

BEGIN {
	FS="-";
}

{
	for (num = $1; num <= $2; num++) {
		if (is_candidate(num)) {
			candidates++;
		}
	}
}

END {
	print candidates;
}
