What is loadeR?
===============

`loadeR` is an R package for climate data data access and manipulation powered by NetCDF-Java (trough the `rJava` package). It allows:
 * Reading local and remote (OPeNDAP) climate datasets (NetCDF, Grib, HDF, etc.)
 * Creation of catalogs
 * Integration with the User Data Gateway ([UDG](http://www.meteo.unican.es/udg-wiki))
 * Basic data maniputation, homogeneization and spatiotemporal collocation.

Find out more about this package (including [installation information](https://github.com/SantanderMetGroup/loadeR/wiki/Installation)) in the [loadeR's WIKI](https://github.com/SantanderMetGroup/loadeR/wiki).

# Other packages of the `climate4R` bundle

 * [`loadeR.ECOMS`](https://github.com/SantanderMetGroup/loadeR.ECOMS/) extends `loadeR` by providing homogenized access to ***seasonal and decadal forecast datasets*** from the [ECOMS](http://www.eu-ecoms.eu) initiative. More information in the [ECOMS-UDG web](https://meteo.unican.es/trac/wiki/udg/ecoms). 

 * [`loadeR.2nc`](https://github.com/SantanderMetGroup/loadeR.2nc/) provides support for **exporting to NetCDF**.
 
 * [`transformeR`](https://github.com/SantanderMetGroup/transformeR) is an R package for **climate data transformation** integrated with the `loadeR's` data structures. It includes tools for subsetting, aggregation, principal component/EOF analysis, regridding and more...

 * [`downscaleR`](https://github.com/SantanderMetGroup/downscaleR/wiki) is an R package for **empirical-statistical downscaling** of daily data, including bias correction techniques.  
 
 * [`visualizeR`](https://github.com/SantanderMetGroup/visualizeR/wiki) is an R package implementing a set of advanced **visualization tools for forecast verification**.

---
*Since November 2015, this package supersedes the data loading capabilities of package [`downscaleR`](https://github.com/SantanderMetGroup/downscaleR).*
