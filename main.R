#!/usr/local/bin/R


# --------------------------------------------------------------------------------------
# Run this script from a command line using the following command:
#
# $ Rscript main.R
#
# --------------------------------------------------------------------------------------

# Declare name of file containing historical reference data
file <- "mm_history.csv"

# Load the historical data into an R Data Frame
history <- read.csv(file=sprintf("./res/%s", file), header=TRUE, sep=",")

print( history )