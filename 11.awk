#!/usr/bin/awk -f

BEGIN {
	core = sprintf("awk -f 09.awk -v program=%s", program);

	x = 0;
	y = 0;

	minx = 0;
	maxx = 0;
	miny = 0;
	maxy = 0;

	dir = 0;

	map[0, 0] = int(start);

	print(int(map[x, y])) |& core

	while ((core |& getline color) > 0) {
		if ((core |& getline turn) <= 0) {
			print("Illegal sequence");
			exit 1;
		}
		
		map[x, y] = color;

		switch (turn) {
		case 0:
			dir = (dir + 270) % 360;
			break;
		case 1:
			dir = (dir +  90) % 360;
			break;
		default:
			print("Unknown direction", turn);
			exit 1;
		}

		switch (dir) {
		case   0: y++; break;
		case  90: x++; break;
		case 180: y--; break;
		case 270: x--; break;
		default:
			print("Unknown direction", turn);
			exit 1;
		}

		minx = x < minx ? x : minx;
		maxx = x > maxx ? x : maxx;
		miny = y < miny ? y : miny;
		maxy = y > maxy ? y : maxy;

		print(int(map[x, y])) |& core;
	}
}

/seen/ {
	for (coord in map)
		seen++;

	print seen;
}

/print/ {
	for (y = maxy; y >= miny; y--) {
		for (x = minx; x <= maxx; x++) {
			printf("%s", map[x, y] == 1 ? "##" : "  ");
		}

		print("");
	}
}
