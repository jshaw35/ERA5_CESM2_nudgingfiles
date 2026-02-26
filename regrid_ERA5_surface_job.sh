#!/bin/bash -l
#PBS -N era5_regrid_32
#PBS -A UCUC0007
#PBS -q casper
#PBS -l walltime=24:00:00
#PBS -l select=1:ncpus=8:mpiprocs=1
#PBS -M jonahshaw@ucar.edu

module load conda
module load cdo
conda activate ERA5_CESM2_interp

python3 /glade/u/home/jonahshaw/Scripts/git_repos/ERA5_CESM2_nudgingfiles/regrid_ERA5_surface.py

# Run with: qsub regrid_ERA5_surface_job.sh