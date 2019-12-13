#!/usr/bin/awk -f

function draw(    x, y) {
	for (y = miny; y <= maxy; y++) {
		for (x = minx; x <= maxx; x++) {
			switch (map[x, y]) {
			case "xx":
				blocks++;
				break;
			case "==":
				paddle = x;
				break;
			case "()":
				ball = x;
				break;
			}					
		}
	}
}

BEGIN {
	core = sprintf("awk -f 13-core.awk -v program=%s -v noun=%s",
		       program, noun);

	maxx = 0;
	miny = 0;
	maxy = 0;

	dir = 0;

	while ((core |& getline x) > 0) {
		if (x == ">") {
			draw();
			print(ball - paddle) |& core;
			continue;
		}

		if ((core |& getline y) <= 0) {
			print("Illegal sequence");
			exit 1;
		}
		if ((core |& getline tile) <= 0) {
			print("Illegal sequence");
			exit 1;
		}

		if (x == -1 && y == 0) {
			score = tile;
			continue;
		}

		switch (tile) {
		case 0:	map[x, y] = "  "; break;
		case 1:	map[x, y] = "##"; break;
		case 2:	map[x, y] = "xx"; break;
		case 3:	map[x, y] = "=="; break;
		case 4:	map[x, y] = "()"; break;
		default:
			print("Unknown tile", tile);
			exit 1;
		}

		minx = x < minx ? x : minx;
		maxx = x > maxx ? x : maxx;
		miny = y < miny ? y : miny;
		maxy = y > maxy ? y : maxy;
	}

	draw();

	if (score)
		print(score);
	else
		print(blocks);
}
