#!/usr/bin/awk -f

BEGIN {
	FS=",";
	result = 0;
}

function scout(x, y,     dist) {
	walked++;

	if (!grid[x, y])
		return;

	dist = grid[x, y] + walked;

	if (!result || (result > dist))
		result = dist;
}

function mark(x, y) {
	grid[x, y] = ++walked;
}

function walk(mode,     x, y, dir, dist) {
	x = 0;
	y = 0;
	walked = 0;

	for (move = 1; move <= NF; move++) {
		dir=substr($move, 1, 1)
		dist=int(substr($move, 2))

		switch (dir) {
		case "U":
			for (; dist > 0; dist--) @mode(x, ++y);
			break;
		case "D":
			for (; dist > 0; dist--) @mode(x, --y);
			break;
		case "L":
			for (; dist > 0; dist--) @mode(--x, y);
			break;
		case "R":
			for (; dist > 0; dist--) @mode(++x, y);
			break;
		}
	}
}

{
	walk("scout");
	walk("mark");
}

END {
	print result;
}
