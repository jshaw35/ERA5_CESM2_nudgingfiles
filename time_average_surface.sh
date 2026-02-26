#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
  echo "Usage: $0 '<wildcard_pattern>' [output_dir]"
  echo "Example: $0 'data/*.nc' averages"
  exit 1
fi

pattern="$1"
outdir="${2:-.}"
mkdir -p "$outdir"

matched=false
for file in $pattern; do
  [ -f "$file" ] || continue
  matched=true
  base="$(basename "$file")"
  stem="${base%.*}"
  outfile="$outdir/${stem}_timemean.nc"
  if [ -f "$outfile" ]; then
    echo "Output file already exists, skipping: $outfile"
    continue
  fi
  cdo timmean "$file" "$outfile"
done

if [ "$matched" = false ]; then
  echo "No files matched pattern: $pattern"
  exit 1
fi

echo "Done."

# Run with: bash time_average_files.sh 'data/*.nc' averages
# bash time_average_files.sh '/glade/derecho/scratch/jonahshaw/ERA5regrid/e5.oper.an.sfc.128_235_skt.regrid.202111.nc' /glade/campaign/univ/ucuc0007/ERA5_CESM2_surfaceinterp/