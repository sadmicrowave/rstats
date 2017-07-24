#!/usr/local/bin/R

# --------------------------------------------------------------------------------------
# Run this script from a command line using the following command:
#
# $ Rscript main.R
#
# --------------------------------------------------------------------------------------
# Source additional modules/classes for usage within main
source("./bin/modules/Analyze.R")

# ------------------------------ Set Environment Options -------------------------------

#options(error=function()traceback(1))
# --------------------------------------------------------------------------------------


# Declare the name of the file containing historical reference data
file <- "./res/mm_history.csv"

##############################################################################################
# ----------------------------------------- MAIN --------------------------------------------#
##############################################################################################
analyze <- Analyze(file)

#oneCommon <- analyze$common(analyze$get("data"), "Num1")
#sapply(oneCommon, analyze$normalDistribution, data=analyze$data[["Num1"]])
#data <- analyze$get("data")

print( analyze$count )

#print( pnorm(1:75, mean=mean(data$Num1), sd=sd(data$Num1), lower.tail=FALSE) )
