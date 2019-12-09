
all: 01 02 03 04 05 06 07 08 09


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


05: 05a 05b

05a: 05.in
	echo 1 | awk -f 05.awk -v program=$<
05b: 05.in
	echo 5 | awk -f 05.awk -v program=$<


06: 06a 06b

06a: 06.in
	./06a.awk <$<

06b: 06.in
	./06b.awk <$<


07: 07a 07b

07a: 07.in
	./07a.sh $<

07b: 07.in
	./07b.sh $<


08: 08a 08b

08a: 08.in
	awk -v width=25 -v height=6 -f 08a.awk <$<

08b: 08.in
	awk -v width=25 -v height=6 -f 08b.awk <$<


09: 09a 09b

09a: 09.in
	echo 1 | awk -f 09.awk -v program=$<
09b: 09.in
	echo 2 | awk -f 09.awk -v program=$<

