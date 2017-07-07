#!/usr/local/bin/R


# --------------------------------------------------------------------------------------
# Run this script from a command line using the following command:
#
# $ Rscript main.R
#
# --------------------------------------------------------------------------------------

# Declare name of file containing historical reference data
file <- "./res/mm_history.csv"

# --------------------------------------------------------------------------------------

# Class constructor 
Analyze <- function(file) {
	
	# create the class initializer with class variables and basic getters/setters
	self = list(
		 file = file
		 ,data = list()
		 ,get = function(x) self[[x]]
		 ,set = function(x, value) self[[x]] <<- value
		 ,props = list()
	)
	
	
	self$import = function() {
		# Import the historical data into an R Data Frame
	  #---------------------------------------------------------------------------------------
		d <- read.csv(file=self$file, header=TRUE, sep=",")
		assign('data', d, envir=self) # assign the value of d to the class property data
	}
	
	self$makeDate = function() {
	  # Make a date column in the main data.frame if not exists, by combining:
	  # data$Month, data$Day, and data$Year.
	  #---------------------------------------------------------------------------------------
	  # Check if the "Date" column is already in the data frame, only proceed if not
	  if ( !("Date" %in% self$data) ) {
	    # Assign a dynamically created date to the new Date column for each row, derived from the data.frame's Month, Day, and Year columns
  	  self$data[["Date"]] <- as.Date(factor(sprintf("%s/%s/%s", self$data[["Month"]], self$data[["Day"]], self$data[["Year"]] )), format="%m/%d/%Y")
	  }
  }
	
	self$normalDistribution <- function(x, data) {
		## Determine the normal distribution of history vector columns
		
	  # param x [string|numeric]: value to test against normal distribution curve
	  # param data [vector]: data set of values to test param:x against
	  #---------------------------------------------------------------------------------------
		n <- pnorm(as.numeric(x), mean=mean(data), sd=sd(data), lower.tail=FALSE)
		return(n)
	}
	
	self$getCommon <- function(col, lb=1, ub=5) {
		## Determine the 5 most common numbers, in descending order for each vector column

		# param col [string]: string containing column reference of data structure
		# param lb [numeric]: lower bounds of returned vector index - default 1
		# param ub [numeric]: upper bounds of returned vector index - default 5
	  #---------------------------------------------------------------------------------------
		return( names(sort(summary(as.factor(self$data[[col]])), decreasing=TRUE)[lb:ub]) )
	}
	

		# ----------------------- Class Closures/Config ----------------------- #
	self <- list2env(self) # sets the class environment, for assign() functions
	class(self) <- "Analyze" # names the class
	
	############# Instantiate Analyze class with methods executing ############# 
	self$import()
	self$makeDate()
	############################################################################

		return(self) # returns self
}


# ----------------------------------------- MAIN ---------------------------------------------
analyze <- Analyze(file)

oneCommon <- analyze$getCommon("Num1")
sapply(oneCommon, analyze$normalDistribution, data=analyze$data[["Num1"]])
