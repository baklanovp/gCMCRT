# gCMCRT - 3D Monte Carlo Radiative Transfer for exoplanet atmospheres with GPUs

WARNING - this code is not a black box and requires some getting used to, that said it typically takes a student a few hours of tinkering to get a first spectra. Once the model works the first time, further tinkering with options/physics etc becomes more simple.
The best way to learn the code is to use it! And feel free to contact Elsie or other experianced users if stuck or confused.

! If you need the code to do more fancy things than explained here, contact an experianced user or Elsie, usually most fancy things are possible to perform or calculate.

More extensive documentation is in the making, for now here are some bare bones instructions.

Two example models are provided:

1. A 3D WASP-33b SPARC/MITgcm GCM model emission example - which extracts chemical abundances at CE from the file
2. A 3D 10x Solar WASP-39b Exo-FMS GCM model transmission example - uses chemical equilibirum abundance table interpolation
3. A 1D WASP-39b 1D VULCAN + CARMA output example - example extracting 1D chemical and cloud data
4. Several MALBEC 1D benchmark models - examples for using the code in 1D

## k-tables and CE data

k-tables and chemical equilibirum interpolation tables can be found here:
https://drive.google.com/drive/folders/1HVa9xWK_GqOqknIErcXVszzhhztACExw?usp=sharing

! There will be periodic updates to the k-tabls and CE interpolation tables. A more flexible option to extract data from the tables is under development.

## To compile

You will need a Nvidia GPU card on your system.

You will need to install the latest drivers from Nvidia: https://www.nvidia.com/Download/index.aspx

(optional) install the CUDA toolkit: https://developer.nvidia.com/cuda-toolkit

You will need to install the CUDA hpc sdk: https://developer.nvidia.com/hpc-sdk

# Required gCMCRT formated files

.prf file

.hprf file

.clprf (for clouds)

.iprf (if CE interpolation required)

wavelengths.wl (central band wavelenths of calculation)

# How to operate optools

To compile cd to src_optoools_V2 and enter 'make'.
To de-compile enter 'make clean'.

Compile options can be altered in the Makefile

optools uses a fortran namelist (.nml) and parameter (.par) file to communicate with the code.

## optools.par file

Is quite self-explainatory - fill in the number of species followed by the number of species (See examples)

## optools.nml file

Is more difficult to fill out correctly:

### &CK_nml - corr-k namelist

pre_mixed - Does a pre-mixed table interpolation (.True.), otherwise random overlap (.False.)

interp_wl - Interpolate to the wavelengths.wl file (.True.) (.False. if exact wavelengths of the ck table are used)

iopts - Integer option number (dev-only)

form - 1 (NEMESIS format), 2 (gCMCRT format) Note, for multiple k-tables this is a comma separated list, e.g. 2,2,2

nG - number of g-ordinances in k-table 

paths - list of path to the k-table data
NOTE: THESE PATHS MUST BE IN THE SAME SPECIES ORDER AS THE SPECIES IN THE optools.par FILE !!!!

### &lbl_nml - line-by-line namelist

interp_wl - interpolate to wavelengths.wl file (.True.) or use wavelengths.wl file directly (.False.)

iopts - Integer option number (dev-only)

form - 0 (Joost's format), 1 (gCMCRT format)

paths - list of paths to the lbl data
NOTE: THESE PATHS MUST BE IN THE SAME SPECIES ORDER AS THE SPECIES IN THE optools FILE !!!

### &CIA_nml - CIA namelist

iopts - Integer option number (dev-only)

form - 0 (Special CIA species), 1 (NEMESIS CIA table), 4 (HITRAN CIA table)

paths - list of paths to the CIA data
NOTE: put a dummy path (e.g. './' ) for special species (H-, He- etc.)
NOTE: THESE PATHS MUST BE IN THE SAME SPECIES ORDER AS THE SPECIES IN THE optools FILE !!!


### &Rayleigh_nml - Rayleigh opacity namelist

iopts - Integer option number (dev-only)

### &cl_nml - clouds namelist

iopts - Integer option number (dev-only)

imix = 1 (Bruggeman optical constant mixing), 2 (LLL method)

idist - 0 (Read bin model results), 1 (single particle size), 2 (3 size peaked near mean size), 3 (log-normal), 4 (Gamma), 5 (Inv. Gamma), 6 (Rayleigh), 7 (Hansen), 8 (Exoponential)

ndist - number of size distibution points (log-spaced between amin and amax)

idist_int - 1 (Trapezium rule integration)

imie - 0 (Size limiting method), 1 (MieX), 2 (MieExt), 3 (BHMIE), 4 (DHS), 5 (BHCOAT), 6 (LX-MIE)
[Note, some of these are experimental, 0 or 6 typicaly reccomended]

form - 5 (DIHRT format nk-tables)

paths - list of paths to the nk data
\NOTE: THESE PATHS MUST BE IN THE SAME SPECIES ORDER AS THE SPECIES IN THE optools FILE !!!

sig -  (log-normal sigma value (note, not ln(sigma) the actual sigma))

eff_fac - effetive mean size varience

veff - effective varience (Hansen)

amin - Minimum distribution particle size (um)

amax - Maximum distribution particle size (um)

fmax - parameter for DHS theory


# How to operate gCMCRT

To compile cd to src_gCMCRT and enter 'make'.
To de-compile enter 'make clean'.

Compile options can be altered in the Makefile

gCMCRT uses a fortran namelist (.nml) file to communicate with the code.

# What is output and how do I make synthetic observations?

# Example tutorials

## WASP-33b GCM dayside and nightside emission spectrum (with details on phase curve operation)

Example using a SPARC/MITgcm WASP-33b model. In this example we produce a dayside and nightside spectra. 
1. Use the extract script to extract the GCM data into the gCMCRT .hprf and .prf format, chemical abundances are extracted alongside.
2. Run goptools to produce the corr-k, CIA and Rayleigh opacity files.
3. Run gCMCRT to produce Em_001.txt (dayside) and Em_002.txt (nightside) output files
4. Run em_spec.py to convert the output to synthetic observations, Fp/Fs, Fp and Tb. This file contains useful information on how to produce emission spectra.

This example can be extended easily to produce phase curves.

## WASP-39b GCM transmision spectrum (with details on using CE interpolation tables)

Example using an Exo-FMS WASP-39b model. In this example we produce a transmission spectrum.
1. Use the extract script to extract the GCM data into the gCMCRT .hprf and .iprf format
2. Use interp_iprf.py to interpolate the CE abundances to the T,p of the GCM and produce the .prf file.
3. Run goptools to produce the corr-k, CIA and Rayleigh opacity files.
4. Run gCMCRT to produce the Transmission.txt file 
5. Run trans_spec.py to convert the output to synthetic observations, Rp/Rs and compare to G395H and SOSS observations. (This file contains useful information on transmission spectrum fitting etc)

## WASP-39b 1D VULCAN + CARMA model (with details on using the code in 1D)

## MALBEC benchmarks (further examples on 1D code use and comparing to other codes)

