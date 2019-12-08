{
	pos = 1;

	for (layer = 0; length(substr($1, pos, 1)) == 1; layer++) {
		for (y = 0; y < height; y++) {
		     for (x = 0; x < width; x++) {
			     pixel = substr($1, pos, 1)
			     if (length(pixel) != 1) {
				     print("Corrupt image");
				     exit 1;
			     }

			     img[layer, x, y] = pixel;
			     pos++;
		     }
		}
	}

	layer--;
}

function count(layer, digit,    x, y, total) {
	for (y = 0; y < height; y++) {
		for (x = 0; x < width; x++) {
			if (img[layer, x, y] == "")
				return total;
			else if (img[layer, x, y] == digit)
				total++;
		}
	}

	return total;
}

END {
	min_z = width * height + 1;

	for (l = 0; l <= layer; l++)  {
		z = count(l, 0);
		if (z < min_z) {
			min_z_layer = l;
			min_z = z;
		}
	}

	print count(min_z_layer, 1) * count(min_z_layer, 2)
}
