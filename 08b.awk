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

END {
	for (y = 0; y < height; y++) {
		for (x = 0; x < width; x++) {
			for (l = 0; l <= layer; l++)  {
				pixel = img[l, x, y];
				if (pixel == 0 || pixel == 1) {
					raster[x, y] = pixel;
					l = layer;
				}
			}
		}
	}

	for (y = 0; y < height; y++) {
		for (x = 0; x < width; x++) {
			printf("%s", raster[x, y] == 0 ? "  " : "##");
		}
		print("")
	}
}
