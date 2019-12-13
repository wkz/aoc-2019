BEGIN {
	FS="[, xyz=<>]*";

	moons = 0;
}

{
	x[moons] = $2;
	y[moons] = $3;
	z[moons] = $4;

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

function energy(x, y, z) {
	return (x > 0 ? x : -x) + (y > 0 ? y : -y) + (z > 0 ? z : -z);
}

END {
	for (s = 0; s < steps; s++) {
		for (m1 = 0; m1 < moons; m1++) {
			for (m2 = m1 + 1; m2 < moons; m2++) {
				gravitate(m1, m2);
			}
		}

		for (m = 0; m < moons; m++) {
			x[m] += vx[m];
			y[m] += vy[m];
			z[m] += vz[m];
		}
	}

	for (m = 0; m < moons; m++) {
		e += energy(x[m], y[m], z[m]) * energy(vx[m], vy[m], vz[m]);
	}

	print(e)
}
