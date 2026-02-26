#!/bin/bash -l
#PBS -N era5_sanity_check
#PBS -A UCUC0007
#PBS -q casper
#PBS -l walltime=01:30:00
#PBS -l select=1:ncpus=8:mpiprocs=1
#PBS -M jonahshaw@ucar.edu

module load conda
conda activate ERA5_CESM2_interp

python3 /glade/u/home/jonahshaw/Scripts/git_repos/ERA5_CESM2_nudgingfiles/sanity_check_files.py