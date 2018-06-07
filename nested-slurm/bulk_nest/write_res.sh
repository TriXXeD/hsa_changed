#!/bin/sh



#for nest in 0 1 2; do
#	for k in 0 1 2 3; do
#		for h in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16; do
#			tail -n50 slurm-372*_.out | grep -A15 "Count:" | grep "Command\|Count\|Time\|Elapsed\|Maximum" >> nest${nest}h${h}k${k}_res.out
#		done



for i in $(seq 0 191); do
	k=$(($i%4))
	h=$(((($i/4)%16)+1))
	nest=$(($i/64))
	tail -n50 slurm-3*_$i.out | grep -A15 "Count:" | grep "Count\|Time\|Elapsed\|Maximum" >> res/nest${nest}h${h}k${k}_res.out
done
