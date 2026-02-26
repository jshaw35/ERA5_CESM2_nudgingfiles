#!/bin/bash -l
#PBS -N time_average_levels
#PBS -A UCUC0007
#PBS -q casper
#PBS -l walltime=24:00:00
#PBS -l select=1:ncpus=8:mpiprocs=1
#PBS -M jonahshaw@ucar.edu

module load cdo

bash time_average_levels.sh '/glade/campaign/univ/ucub0137/ERA5_CESM2_nudging/' '/glade/campaign/univ/ucuc0007/ERA5_CESM2_levelsinterp/' 'ERA5.6hour.32level.uvtq.' 2002 2024

# Run with: qsub time_average_levels_job.sh