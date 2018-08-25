################################################################################
#
#
#
# This is a Shiny web application to support the implementation of health and
# nutrition coverage surveys in Liberia.
#
# This code is for the global R requirements of the Shiny web application.
#
#
################################################################################


################################################################################
#
# Set-up
#
################################################################################
#
# Load libraries
#
if(!require(shiny)) install.packages("shiny")
if(!require(shinydashboard)) install.packages("shinydashboard")
if(!require(devtools)) install.packages("devtools")
if(!require(bbw)) install.packages("bbw")
if(!require(liberia)) install_github("liberia")
if(!require(spatialsampler)) install_github("spatialsampler")
if(!require(odkr)) install_github("odkr")
if(!require(zscorer)) install_github("zscorer")
if(!require(sampsizer)) install_github("sampsizer")


