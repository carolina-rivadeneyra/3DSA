# 3DSA Model

This is the 3DSA model, constructed to locate regional events in the 
stable part of South America, as published in Brazilian Journal of Geophysics (BrJG).

The model presents grids for P- and S-wave velocities.  It is sampled 
every 0.5 deg (55.5 km) in the region between -75W and -34W degrees 
longitude and -32S and 10N degrees latitude.

The model is distributed as a binary file and as a text file. Original 
files are in the `model` folder.

If you find this model useful and use it in your research please cite 
us as http://dx.doi.org/10.22564/rbgf.v39i4.2124

## The NLLoc

The model was created to be used together with the NLLoc routines. 
Before using it you should have it installed on your computer.

Please follow the instructions at: http://alomax.free.fr/nlloc/

To generate the last figure it will also be necessary to have GMT 
(https://www.generic-mapping-tools.org/), version 4.X or above 
installed.

## Observation files

The NLLoc program can read different formats for the observation files. 
We normally use the NORDIC file format. To obtain the NORDIC files we 
use the ObsPy package to read our quakeML or Sc3ML files and, export 
them to NORDIC. We normally do something like:

```
from obspy import read_events

catalog = read_events("input.xml")
catalog.write("output.nordic", format = "NORDIC")
```

The current supplied example is for the Guyana 2021 magnitude 6 Mb 
earthquake. It occurred near the  Brazilian border and was well 
registered by the RSBR network 
(http://www.moho.iag.usp.br/eq/event/usp2021cegw).

## How to use the model

To use this model you should refer to all supplied control statement 
files (*.in files in this folder).  We extensively documented all those 
main files that will be used in the example given.  Also, don't forget 
to refer to the NLLoc documentation for further options and 
explanations about the commands.

Additionally, to the supplied '.in' files, we are also supplying a 
Makefile that can guide you in the process of locating the example. The 
Makefile cover the following steps:

 * Prepare the SLOWNESS GRIDS for p
 * Prepare the SLOWNESS GRIDS for s
 * Run the location procedure
 * Generate basic output image

We refer you to read the Makefile to understand what commands, and in 
which order, should be run to obtain the final location. In 
summary, you run:

```
$ make p
$ make s
$ make loc
$ make fig
```

In terms of NonLinLoc commands, you should run:

```
$ Vel2Grid3D guyana_p.in
$ Grid2Time guyana_p.in
$ Vel2Grid3D guyana_s.in
$ Grid2Time guyana_s.in
$ NLLoc guyana_location.in
$ Grid2GMT guyana_location.in loc/last loc/ L S
$ gv loc/last.LS.ps # Replace gv by your preferred ps viewer
```

> All shown commands are elegantly encoded into the Makefile.

## Contacts and comments

If you would like to get in contact with the authors please write to me at carolina.rivadeneyra
 __at__ gmail.com. It is also possible to contact m.bianchi __at__iag.usp.br.
