#!/usr/bin/awk -f

BEGIN {
	FS = "";
	pi=atan2(0, -1);
	y = 0;
}

{
	if (width == "") {
		width = NF;
	} else if (width != NF) {
		print("Corrupt map");
		exit 1;
	}

	for (x = 0; x < NF; x++)
		map[x, y] = $(x + 1);

	y++;
}

function scan(ax, ay,    x, y, angles, uniq) {
	for (y = 0; y < height; y++) {
		for (x = 0; x < width; x++) {
			if (map[x, y] == ".")
				continue;

			if (x == ax && y == ay)
				continue;

			angles[atan2(y - ay, x - ax)]++;
		}
	}

	for (angle in angles)
		uniq++;

	return uniq
}

function xatan2(x, y,    rad) {
	# sic. swap x and y to place 0 at "up"
	rad = atan2(x, y);

	if (rad < 0)
		rad += 2 * pi;

	return rad;
}

function vaporize(ax, ay, victim,    x, y, angle, angles, mag, bogeys) {
	for (y = 0; y < height; y++) {
		for (x = 0; x < width; x++) {
			if (map[x, y] == ".")
				continue;

			if (x == ax && y == ay)
				continue;

			angle = xatan2(x - ax, ay - y);
			mag = sqrt((x - ax)^2 + (y - ay)^2)
			bogeys[angle][mag] = int(mag * 100)*10000 + x * 100 + y;
		}
	}

	asorti(bogeys, angles)
	for (angle in angles) {
		asort(bogeys[angles[angle]]);

		if (!--victim)
			print(bogeys[angles[angle]][1] % 10000);

		delete bogeys[angles[angle]][1];
	}
}

END {
	height = y;

	max = 0;
	for (y = 0; y < height; y++) {
		for (x = 0; x < width; x++) {
			if (map[x, y] != "#")
				continue;

			seen = scan(x, y);
			if (seen > max) {
				max_x = x;
				max_y = y;
				max   = seen;
			}
		}
	}

	print max_x, max_y, max

	vaporize(max_x, max_y, 200);
}
