#!/usr/local/bin/R
# -------------------------------------------------------------------------------------- #
# Run this script from a command line using the following command:
# $ Rscript main.R

# ------------------------- Set Environment Options ------------------------------------ #
#options(error=function()traceback(1))
options(encoding = "UTF-8")


# ----------------------------- Install Required Packages ------------------------------ #
#
# ------------------------------ Import Libraries/Modules ------------------------------ #
# Source additional modules/classes for usage within main
source("./bin/modules/Analyze.R")
source("./bin/modules/Randomness.R")




##############################################################################################
# ----------------------------------------- MAIN --------------------------------------------#
##############################################################################################

# Declare the name of the file containing historical reference data
file <- "./res/mm_history.csv"

analyze <- Analyze(file)
random <- Randomness(analyze$data)

d <- random$wald_wolfowitz(analyze$data[["Num1"]])

print( d )
#d <- analyze$nonparametric_linear_regression()

#oneCommon <- analyze$common(analyze$get("data"), "Num1")
#sapply(oneCommon, analyze$normal_distribution, data=analyze$data[["Num1"]])

#print( pnorm(1:75, mean=mean(data$Num1), sd=sd(data$Num1), lower.tail=FALSE) )
