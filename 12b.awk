BEGIN {
	FS="[, xyz=<>]*";

	moons = 0;
}

{
	x[moons] = $2;
	y[moons] = $3;
	z[moons] = $4;

	sx[moons] = $2;
	sy[moons] = $3;
	sz[moons] = $4;

	vx[moons] = 0;
	vy[moons] = 0;
	vz[moons] = 0;
	moons++;
}

function gravitate(m1, m2) {
	if (x[m1] > x[m2]) {
		vx[m1]--;
		vx[m2]++;
	} else if (x[m1] < x[m2]) {
		vx[m1]++;
		vx[m2]--;
	}
			
	if (y[m1] > y[m2]) {
		vy[m1]--;
		vy[m2]++;
	} else if (y[m1] < y[m2]) {
		vy[m1]++;
		vy[m2]--;
	}

	if (z[m1] > z[m2]) {
		vz[m1]--;
		vz[m2]++;
	} else if (z[m1] < z[m2]) {
		vz[m1]++;
		vz[m2]--;
	}
}

function gcd(a, b) {
	while (b > 0) {
		ob = b;
		b = a % b;
		a = ob;
	}

	return a;
}

function lcm(a, b) {
	return a * b / gcd(a, b);
}

END {
	s = 0;
	for (periods = 0; periods < 3; s++) {
		for (m1 = 0; m1 < moons; m1++) {
			for (m2 = m1 + 1; m2 < moons; m2++) {
				gravitate(m1, m2);
			}
		}

		rx = 1; ry = 1; rz = 1;
		for (m = 0; m < moons; m++) {
			x[m] += vx[m];
			y[m] += vy[m];
			z[m] += vz[m];

			if (vx[m] || x[m] != sx[m]) rx = 0;
			if (vy[m] || y[m] != sy[m]) ry = 0;
			if (vz[m] || z[m] != sz[m]) rz = 0;
		}

		if (rx && px == "") {
			px = s + 1;
			periods++;
		}
		if (ry && py == "") {
			py = s + 1;
			periods++;
		}
		if (rz && pz == "") {
			pz = s + 1;
			periods++;
		}
	}

	print lcm(px, lcm(py, pz));
}
