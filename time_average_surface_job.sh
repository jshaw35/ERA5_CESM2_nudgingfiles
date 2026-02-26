#!/bin/bash -l
#PBS -N time_average_surface
#PBS -A UCUC0007
#PBS -q casper
#PBS -l walltime=24:00:00
#PBS -l select=1:ncpus=8:mpiprocs=1
#PBS -M jonahshaw@ucar.edu

module load cdo

bash time_average_surface.sh '/glade/derecho/scratch/jonahshaw/ERA5regrid/e5.oper.an.sfc.128_*.regrid.??????.nc' /glade/campaign/univ/ucuc0007/ERA5_CESM2_surfaceinterp/

# Run with: qsub time_average_surface_job.sh