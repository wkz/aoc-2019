
all: 01 02 03 04


01: 01a 01b

01a: 01.in
	./01a.awk <$<

01b: 01.in
	./01b.awk <$<


02:
	./02.sh


03: 03a 03b

03a: 03.in
	./03a.awk <$<

03b: 03.in
	./03b.awk <$<


04: 04a 04b

04a: 04.in
	./04a.awk <$<

04b: 04.in
	./04b.awk <$<
