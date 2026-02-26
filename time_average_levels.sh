#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -lt 5 ] || [ "$#" -gt 5 ]; then
  echo "Usage: $0 [input_dir] [output_dir] [output_prefix] start_year end_year"
  echo "Example: $0 '/glade/campaign/univ/ucub0137/ERA5_CESM2_nudging/' '/glade/campaign/univ/ucuc0007/ERA5_CESM2_levelsinterp/' 'ERA5.6hour.32level.uvtq.' 2002 2003"
  exit 1
fi

pattern="$1"
outdir="${2:-.}"
outpattern="${3:-}"
startyear="${4:-}"
endyear="${5:-}"
mkdir -p "$outdir"

for year in $(seq "${startyear}" "${endyear}"); do
  matched=false 
  echo "Processing year: $year"
  for month in $(seq -w 1 12); do
    echo "  Processing month: $month"
    # Construct the file pattern for this year and month
    month_pattern="${pattern}${year}${month}/*.nc"
    # Check if any files match this pattern
    if compgen -G "$month_pattern" > /dev/null; then
      matched=true
    else
      echo "    No files matched pattern: $month_pattern"
      continue
    fi
    # Perform a time average across all files matching the month pattern
    outfile="${outdir}/${outpattern}${year}${month}.nc"
    if [ -f "$outfile" ]; then
      echo "    Output file already exists, skipping: $outfile"
      continue
    fi
    cdo timmean -cat ${month_pattern} "$outfile"
  done
done
echo "Done."

# Run with: bash time_average_levels.sh 'data/*.nc' averages
# bash time_average_levels.sh '/glade/campaign/univ/ucub0137/ERA5_CESM2_nudging/' '/glade/campaign/univ/ucuc0007/ERA5_CESM2_levelsinterp/' 'ERA5.6hour.32level.uvtq.' 2002 2003