
all: 01

01: 01a 01b

01a: 01.in
	./01a.awk <$<

01b: 01.in
	./01b.awk <$<
