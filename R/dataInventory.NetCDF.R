#' @title Inventory of a gridded dataset
#' @description Returns a list with summary information about the variables stored in a gridded dataset.
#' Sub-routine of \code{dataInventory}
#' @param dataset A full path to the file describing the dataset (NcML)
#' @return A (named) list whose length is determined by the number of variables stored in the dataset,
#' its names corresponding to the short names of the variables.
#' For each variable, information on the variable long name, data type, units, data size (in Mb) and
#' characteristics of its dimensions is provided.
#' @author J. Bedia, S. Herrera
#' @keywords internal
#' @importFrom rJava J


dataInventory.NetCDF <- function(dataset) {
   gds <- J("ucar.nc2.dt.grid.GridDataset")$open(dataset)
   nc.dataset <- gds$getNetcdfDataset()
   varNames <- unlist(strsplit(gsub("\\[|]|\\s", "", gds$getGrids()$toString()), ","))
   rm.ind <- grep("^lon|^lat", varNames)  
   if (length(rm.ind) > 0) {
      varNames <- varNames[-rm.ind]
   }
   if (length(varNames) == 0) {
      stop("No variables found", call. = FALSE)
   } else {
      var.list <- vector(mode = "list", length = length(varNames))   
      for (i in 1:length(varNames)) {
         message("[", Sys.time(), "] Retrieving info for \'", varNames[i], "\' (", length(varNames) - i, " vars remaining)")
         datavar <- gds$getDataVariable(varNames[i])
         description <- datavar$getDescription()
         varName <- datavar$getShortName()
         version <- tryCatch({trimws(datavar$findAttribute("version")$getValues()$toString())}, error = function(e){NA})
         dataType <- datavar$getDataType()$toString()
         element.size <- datavar$getDataType()$getSize()
         data.number <- datavar$getSize()
         dataSize <- element.size * data.number * 1e-06
         units <- datavar$getUnitsString()
         shape <- datavar$getShape()
         grid <- gds$findGridByShortName(varName)
         dim.list <- scanVarDimensions(grid)
         if (grid$getXDimensionIndex() >= 0) {
           xDimIndex <- grid$getXDimensionIndex() + 1
           if (length(dim.list[[xDimIndex]]$Shape) > 1) {
             dimX.list <- list()
             length(dimX.list) <- length(dim.list[[xDimIndex]]$Shape)
             for (v in c(1:length(dimX.list))) {
                dimX.list[[v]] <- tryCatch({
                   Xcoord <- nc.dataset$findVariable(dim.list[[xDimIndex]]$Coordinates[v])
                   Xunits <- Xcoord$getUnitsString()
                   XType <- Xcoord$getAxisType()$toString()
                   XAxisShape <- Xcoord$getShape()
                   values <- Xcoord$getCoordValues()
                   aux.XAxis <- Xcoord$getDimensionsString()
                   list("Type" = XType, "Units" = Xunits,
                        "Values" = values, "Shape" =  XAxisShape,"Coordinates" = aux.XAxis)
                }, error = function(e) {
                   list("Type" = NULL, "Units" = NULL,
                        "Values" = NULL, "Shape" =  NULL,
                        "Coordinates" = NULL)
                   })
                names(dimX.list)[v] <- dim.list[[xDimIndex]]$Coordinates[v] # "lon"
             }
             dim.list[[xDimIndex]]$Dimensions <- dimX.list
           }
         }
         if (grid$getYDimensionIndex() >= 0) {
           yDimIndex <- grid$getYDimensionIndex() + 1
           if (length(dim.list[[yDimIndex]]$Shape) > 1) {
             dimX.list <- list()
             length(dimX.list) <- length(dim.list[[yDimIndex]]$Shape)
             for (v in c(1:length(dimX.list))) {
                dimX.list[[v]] <- tryCatch({
                   Xcoord <- nc.dataset$findVariable(dim.list[[yDimIndex]]$Coordinates[v])
                   Xunits <- Xcoord$getUnitsString()
                   XType <- Xcoord$getAxisType()$toString()
                   XAxisShape <- Xcoord$getShape()
                   values <- Xcoord$getCoordValues()
                   aux.XAxis <- Xcoord$getDimensionsString()
                   list("Type" = XType, "Units" = Xunits,
                        "Values" = values, "Shape" =  XAxisShape,"Coordinates" = aux.XAxis)
                }, error = function(e) {
                   list("Type" = NULL, "Units" = NULL,
                        "Values" = NULL, "Shape" =  NULL,
                        "Coordinates" = NULL)
                   })
                names(dimX.list)[v] <- dim.list[[yDimIndex]]$Coordinates[v] # "lon"
             }
             dim.list[[yDimIndex]]$Dimensions <- dimX.list
           }
         }
         var.list[[i]] <- list("Description" = description,
                               "DataType" = dataType,
                               "Shape" = shape,
                               "Units" = units,
                               "DataSizeMb" = dataSize,
                               "Version" = version,
                               "Dimensions" = dim.list)
      }
      names(var.list) <- varNames
   }
   gds$close()
   return(var.list)
}
# End
