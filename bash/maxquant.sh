#!/bin/bash
#SBATCH --account=def-coulomb
#SBATCH --time=5-00:00:00
#SBATCH --mail-user=christian.poitras@ircm.qc.ca
#SBATCH --mail-type=ALL
#SBATCH --output=maxquant-%A.out
#SBATCH --error=maxquant-%A.out

# Start this script with this command and change parameters to proper values:
# sbatch --cpus-per-task=8 --mem=40G maxquant.sh

rdargs=("-p" "mqpar.xml" "-d" "$PWD" "-o" "mqpar-run.xml")
if [ ! -z "$SLURM_CPUS_PER_TASK" ]
then
  rdargs+=("-t" "$SLURM_CPUS_PER_TASK")
fi

replacedirectories "${rdargs[@]}"
mono "$MAXQUANT_BASE"/current/bin/MaxQuantCmd.exe ./mqpar-run.xml
