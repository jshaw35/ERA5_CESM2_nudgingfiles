import os


variable = [
    'skin_temperature',
    'surface_pressure',
    'sealevel_pressure',
    '2m_temperature',
    'sea_surface_temperature',
]

year = [str(i) for i in range(2002, 2025)]

month = [str(i).zfill(2) for i in range(1,13)]

var_aliases = {
    'skin_temperature':'235_skt',
    'surface_pressure':'134_sp',
    'sealevel_pressure':'151_msl',
    '2m_temperature':'167_2t',
    'sea_surface_temperature':'034_sstk',
    
}

levs = {
    'skin_temperature':'ll025sc',
    'surface_pressure':'ll025sc',
    'sealevel_pressure':'ll025sc',
    '2m_temperature':'ll025sc',
    'sea_surface_temperature':'ll025sc',
}

# Example file path is /gdex/data/d633000/e5.oper.an.sfc/202002/e5.oper.an.sfc.128_235_skt.ll025sc.2020020100_2020022923.nc
DATA_PATH = '/gdex/data/d633000/e5.oper.an.sfc/'
SAVE_PATH = '/glade/derecho/scratch/jonahshaw/ERA5regrid'


def interpolate_data(cvar, cmonth, cyr):
    # Set variables and paths
    var_alias = var_aliases[cvar]
    lev = levs[cvar]

    cfile = os.path.join(DATA_PATH, f'{cyr}{cmonth}',f'e5.oper.an.sfc.128_{var_alias}.{lev}.{cyr}{cmonth}0100_{cyr}{cmonth}????.nc')
    ofile = os.path.join(SAVE_PATH,f'e5.oper.an.sfc.128_{var_alias}.regrid.{cyr}{cmonth}.nc')

    # Exit if file exists
    if os.path.isfile(ofile):
        print(ofile,' already exists')
        return

    # Regrid
    os.system(f"cdo -f nc4 -remapbil,cdo_grid.txt -setgridtype,regular {cfile} {ofile}")


def main():
    for cyr in year:
        # Check if leap year
        leap = (int(cyr) % 4) == 0

        for cmonth in month:
            for cvariable in variable:
                # Try to do download data, catch error if it fails
                try:
                    print(f'Trying {cvariable} {cmonth} {cyr}')
                    interpolate_data(cvariable, cmonth, cyr)
                except Exception as e:
                    print(e)
                    print(f'Download failed for {cvariable} {cmonth} {cyr}')

if __name__ == '__main__':
   main()

