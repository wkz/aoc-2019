function load(file,    saved_rs, word) {
	saved_rs=RS

	RS=",";
	while ((getline word <file) > 0) {
		mem[i++] = word
	}

	RS=saved_rs
}

function fetch(insn, n,    i, mode) {
	mode = insn / 100;
	for (i = 1; i < n; i++)
		mode /= 10;

	mode = int(mode) % 10;

	switch (mode) {
	case 0:	# position
		return int(mem[pc + n]);
	case 1:	# immediate
		return int(pc + n)
	case 2:	# rbase
		return int(rbase + int(mem[pc + n]))
	default:
		print("Unknown parameter mode %d at %d\n", mode, pc);
		exit(1);
	}
}

BEGIN {
	load(program);

	if (noun != "")
		mem[0] = int(noun);

	rbase = 0;

	for (pc = 0; mem[pc] != 99;) {
		insn = sprintf("%05u", mem[pc]);

		switch (insn % 100) {
		case 1:	# add op1 op2 [dst]
			op1 = fetch(insn, 1);
			op2 = fetch(insn, 2);
			dst = fetch(insn, 3);
			mem[dst] = mem[op1] + mem[op2];
			pc += 4;
			break;
		case 2:	# mul op1 op2 [dst]
			op1 = fetch(insn, 1);
			op2 = fetch(insn, 2);
			dst = fetch(insn, 3);
			mem[dst] = mem[op1] * mem[op2];
			pc += 4;
			break;
		case 3:	# inword ~op1 [dst]
			print ">"; fflush();
			getline op1
			dst = fetch(insn, 1);
			mem[dst] = int(op1);
			pc += 2;
			break;
		case 4:	# outword op1
			op1 = fetch(insn, 1);
			print mem[op1]; fflush();
			pc += 2;
			break;
		case 5:	# bnz op1 op2
			op1 = fetch(insn, 1);
			op2 = fetch(insn, 2);
			if (mem[op1] != 0)
				pc = mem[op2];
			else
				pc += 3;
			break;
		case 6:	# bz op1 op2
			op1 = fetch(insn, 1);
			op2 = fetch(insn, 2);
			if (mem[op1] == 0)
				pc = mem[op2];
			else
				pc += 3;
			break;
		case 7:	# setlt op1 op2 [dst]
			op1 = fetch(insn, 1);
			op2 = fetch(insn, 2);
			dst = fetch(insn, 3);
			mem[dst] = mem[op1] < mem[op2] ? 1 : 0;
			pc += 4;
			break;
		case 8:	# seteq op1 op2 [dst]
			op1 = fetch(insn, 1);
			op2 = fetch(insn, 2);
			dst = fetch(insn, 3);
			mem[dst] = mem[op1] == mem[op2] ? 1 : 0;
			pc += 4;
			break;
		case 9:	# rbase op1
			op1 = fetch(insn, 1);
			rbase += mem[op1];
			pc += 2;
			break;

		default:
			printf("Illegal instruction %d at %d\n", insn, pc);
			exit 1;
		}
	}

	exit 0;
}
