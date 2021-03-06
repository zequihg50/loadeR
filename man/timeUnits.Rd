% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/loadGridData.R
\name{timeUnits}
\alias{timeUnits}
\title{time units}
\usage{
timeUnits(dft)
}
\arguments{
\item{dft}{A time step (numeric), in hours}
}
\value{
The time units
}
\description{
Internal helper to check time resolution
}
\details{
When calculating threshold exceedance counts, the units attribute need to be updated via this internal.
}
\note{
This functionality is similar to \code{getTimeResolution} in \pkg{transformeR}.
 It is introduced here for internal use only in loadGridData to avoid the transformeR dependency, 
 but shouldn't be used elsewhere.
}
\author{
J Bedia, S. Herrera
}
\keyword{internal}
