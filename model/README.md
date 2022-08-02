# Model and SLOWNESS grids

This folder holds the 3DSA model buffer file, it will also holds the
SLOWNESS grids that will be computed with the 'make p' and 'make s'
commands. Those grids are SLOWNESS grids for your selected area.

The .txt files are text versions of the Model. 

Variables are:

 * Latitude: Node Degrees from South 
 * Longitude: Node Degrees from West
 * Depth: Node depth (km) in Earth reference (Mean Sea Level)
 * Vp|Vs: P|S-wave velocity (km/s)
 * Topo: Topography in node position (km)
 * Sed: Sediment thickness in node position (km)
 * Moho: Crustal thickness in node position  (km)
 * i : Model i index (km)
 * j : Model j index (km)
 * k : Model j index (km)
