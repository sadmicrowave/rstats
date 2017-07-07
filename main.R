#!/usr/local/bin/R


# --------------------------------------------------------------------------------------
# Run this script from a command line using the following command:
#
# $ Rscript main.R
#
# --------------------------------------------------------------------------------------
# Source additional modules/classes for usage within main
source("./bin/modules/Analyze.R")

# --------------------------------------------------------------------------------------

# Declare the name of the file containing historical reference data
file <- "./res/mm_history.csv"


##############################################################################################
# ----------------------------------------- MAIN --------------------------------------------#
##############################################################################################
analyze <- Analyze(file)

oneCommon <- analyze$getCommon(analyze$get("data"), "Num1")
sapply(oneCommon, analyze$normalDistribution, data=analyze$data[["Num1"]])






