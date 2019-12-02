BEGIN {
	RS=",";
}

{
	mem[i++] = $1;
}

END {
	mem[1] = noun;
	mem[2] = verb;

	for (pc = 0; mem[pc] != 99;) {
		switch (mem[pc]) {
		case 1:
			mem[mem[pc + 3]] = mem[mem[pc + 1]] + mem[mem[pc + 2]];
			pc += 4;
			break;
		case 2:
			mem[mem[pc + 3]] = mem[mem[pc + 1]] * mem[mem[pc + 2]];
			pc += 4;
			break;

		default:
			printf("Illegal instruction %d at %d\n", mem[pc], pc);
			exit(1);
		}
	}

	print mem[0];
}
