#!/bin/sh

source "$HOME/python/3.6/activate"

echo `which python3`
export PATH=/user/deis1015/python/3.6/bin:$PATH
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/user/deis1015/python/3.6/lib
echo `which python3`
cd "$HOME/hsa_changed/nested-slurm/bulk_nest/res"

for i in $(seq 0 191); do
        k=$(($i%4))
        h=$(((($i/4)%16)+1))
        nest=$(($i/64))
        python3 calc_avg.py nest${nest}h${h}k${k}_res.out nest${nest}h${h}k${k}
done
#for i in $(seq 0 191); do
#        k=$(($i%4))
#        h=$(((($i/4)%16)+1))
#        nest=$(($i/64))
#        tail -n50 slurm-372*_$i.out | grep -A15 "Count:" | grep "Count\|Time\|Elapsed\|Maximum" >> res/nest${nest}h${h}k${k}_res.out
#done
