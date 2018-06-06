#!/bin/sh
#SBATCH --nodes 1
#SBATCH --mem=512G
#SBATCH --partition=production
#SBATCH -n 1
#SBATCH --cpus-per-task=4
#SBATCH --mail-type=ALL
#SBATCH --mail-user=slurm@satai.dk
#SBATCH --array=47-47

echo $SLURM_NODELIST
echo $SLURM_NPROCS
#source "$HOME/python/3.6/activate"
TERM=slurm

cd "$HOME/hsa_changed"

k=$(($SLURM_ARRAY_TASK_ID%6))
h=$((($SLURM_ARRAY_TASK_ID/6)+1))

echo "running reachabillity on nordunet with k: $k and h $h"
echo "us-pal = 6500000"
echo "no-uts = 5200000"
echo "se-fre = 5300000"
echo "de-hmb = 4000000"
echo "dk-ore = 4100000"
echo "dk-uni = 4200000"
echo "gen ./h${h}k${k}_${nest}nn"
/usr/bin/time -v ./gen h${h}k${k}_nn


echo "uni to ore, combos of 1 1, 2 1, 3 3, 1 3, 2 2, 3 2"
echo "./h${h}k${k}_${nest}nn 1 1, 2 1, 3 3, 1 3, 2 2, 3 2"
#/usr/bin/time -v ./h${h}k${k}_${nest}nn 4200001 4100001
/usr/bin/time -v ./h${h}k${k}_${nest}nn 4200002 4100001
#/usr/bin/time -v ./h${h}k${k}_${nest}nn 4200003 4100003
#/usr/bin/time -v ./h${h}k${k}_${nest}nn 4200001 4100003
#/usr/bin/time -v ./h${h}k${k}_${nest}nn 4200002 4100002
#/usr/bin/time -v ./h${h}k${k}_${nest}nn 4200003 4100002


echo "us to se"
echo "./h${h}k${k}_${nest}nn 6500002 5300002, 6500002 5300003, 6500004 5300002, 6500004 5300003, 6500005 5300002, 6500005 5300003"
/usr/bin/time -v ./h${h}k${k}_${nest}nn 5300002 6500002
#/usr/bin/time -v ./h${h}k${k}_${nest}nn 5300003 6500002
#/usr/bin/time -v ./h${h}k${k}_${nest}nn 5300002 6500004
#/usr/bin/time -v ./h${h}k${k}_${nest}nn 5300003 6500004
#/usr/bin/time -v ./h${h}k${k}_${nest}nn 5300002 6500005
#/usr/bin/time -v ./h${h}k${k}_${nest}nn 5300003 6500005

echo "us to no"
echo "./h${h}k${k}_${nest}nn 6500002 5200002, 6500002 5200001, 6500004 5200002, 6500004 5200001, 6500005 5200002, 6500005 5200001"
/usr/bin/time -v ./h${h}k${k}_${nest}nn 5200002 6500002
#/usr/bin/time -v ./h${h}k${k}_${nest}nn 5200001 6500002
#/usr/bin/time -v ./h${h}k${k}_${nest}nn 5200002 6500004
#/usr/bin/time -v ./h${h}k${k}_${nest}nn 5200001 6500004
#/usr/bin/time -v ./h${h}k${k}_${nest}nn 5200002 6500005
#/usr/bin/time -v ./h${h}k${k}_${nest}nn 5200001 6500005

echo "de to se"
echo "./h${h}k${k}_${nest}nn 4000001 5300002, 4000001 5300003, 4000005 5300002, 4000005 5300003, 4000014 5300002, 4000014 5300003"
/usr/bin/time -v ./h${h}k${k}_nn 4000001 5300002
#/usr/bin/time -v ./h${h}k${k}_nn 4000001 5300003
#/usr/bin/time -v ./h${h}k${k}_nn 4000005 5300002
#/usr/bin/time -v ./h${h}k${k}_nn 4000005 5300003
#/usr/bin/time -v ./h${h}k${k}_nn 4000014 5300002
#/usr/bin/time -v ./h${h}k${k}_nn 4000014 5300003


#fre links on    5300002/3
#no links on     5200001/2
#uspal links on  6500002/4/5/6
#de-hmb links on 4000005/14/15/1/2/3/9/10
#ore links on    4100001/2/3/4/5/6/7/8/9
#uni links on    4200001-9
