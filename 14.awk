#!/usr/bin/awk -f

BEGIN {
	FS="[ ,=>]+";

	T = 1000000000000;
}

{
	if (NF % 2) {
		print("Invalid formula");
		exit 1;
	}

	batch[$NF] = $(NF - 1)
	for (i = 1; i <= NF - 2; i += 2) {
		chems[$NF][$(i+1)] = $i
	}
}

function ceil(f) {
	return (int(f) == f) ? f : int(f) + 1;
}

function build(c, q,   dep, dq) {
	if (c in batch) {
		q = ceil(q/batch[c]) * batch[c]
	}

	if (c in chems) {
		for (dep in chems[c]) {
			dq = ceil((q * chems[c][dep]) / batch[c]);
			if (stores[dep] < dq) {
				build(dep, dq - stores[dep]);
			}

			stores[dep] -= dq;
		}
	}

	stores[c] += q;

	if (c == "ORE")
		ore += q;
}

END {
	build("FUEL", 1);
	single = ore;
	print(single);

	for (left = T - ore; ore < T; left = T - ore) {
		build("FUEL", ceil(left / single));
	}

	if (ore > T)
		stores["FUEL"]--;

	print(stores["FUEL"]);
}
