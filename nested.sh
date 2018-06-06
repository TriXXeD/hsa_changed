#!/bin/bash
#SBATCH --nodes 1
#SBATCH --mem=250G
#SBATCH --partition=production
#SBATCH --cpus-per-task=4
#SBATCH -n 1
#SBATCH --mail-type=ALL
#SBATCH --mail-user=slurm@satai.dk
#SBATCH --array=52-191%16

echo $SLURM_NODELIST
echo $SLURM_NPROCS
#source "$HOME/python/3.6/activate"
TERM=slurm

cd "$HOME/hsa_changed"

k=$(($SLURM_ARRAY_TASK_ID%4))
h=$(((($SLURM_ARRAY_TASK_ID/4)%16)+1))
nest=$(($SLURM_ARRAY_TASK_ID/64))
s7i1=(700001 2500001 6100001)


echo "running reachabillity on nesting $nest with k: $k and h $h"
echo "./h${h}k${k}_${nest}nest"
echo "doing all reachability from port 100001 (should reach all)"
/usr/bin/time -v ./gen h${h}k${k}_${nest}nest
/usr/bin/time -v ./h${h}k${k}_${nest}nest 100001 ${s7i1[${nest}]}
