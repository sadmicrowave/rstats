#!/usr/local/bin/R

# -------------------------------- Import Libraries ------------------------------------ #
# -------------------------------------------------------------------------------------- #

# Class constructor, Construct will contain all pertinent methods/functions for analyzing
# the main data set.  This class should contain any "data-crunching" functions, while 
# other classes could be imported for functions related to plotting, etc.

Construct <- function(file) {
  
  # The term "self = ..." is important next because it names the internal instance of the class.
  # We need a way, within the class, to reference other class functions and properties.  With "self"
  # we can do this by referencing self$_____ where the blank could be a method name or a property.
  # For example: self$import() would call the import function within this class, while self$data 
  # will reference the "data" property of the class, which holds the data imported from the file
  # in the self$import() function below.
  
  # create the class initializer with class variables and basic getters/setters
  self = list(
     get = function(x) self[[x]]
    ,set = function(x, value) self[[x]] <<- value
    ,props = list()
    ,file = file
    ,data = list()
  )
  
  import = function() {
    # Import the historical data into an R Data Frame, expecting the data file to be in .csv
    # format, and a header/label row exists, and fields are delimited by commas.
    #---------------------------------------------------------------------------------------
    
    # read the csv file into memory, specify that a header row exists within file
    d <- read.csv(file=self$file, header=TRUE, sep=",")
    # assign the value of d to the class property data
    assign('data', d, envir=self) 
  }
  
  make_date = function() {
    # Make a date column in the main data.frame if not exists, by combining the data frame's Month, Day, and Year columns.
    #---------------------------------------------------------------------------------------
    
    # Check if the "Date" column is already in the data frame, only proceed if not
    if ( !("Date" %in% self$data) ) {
      # Assign a dynamically created date to the new Date column for each row, derived from the data.frame's Month, Day, and Year columns
      self$data[["Date"]] <- as.Date(factor(sprintf("%s/%s/%s", self$data[["Month"]], self$data[["Day"]], self$data[["Year"]] )), format="%m/%d/%Y")
    }
  }
  
  self$normal_distribution <- function(x, data) {
    ## Determine the normal distribution of the passed data vector 
    
    # param x [string|numeric]: value to test against normal distribution curve
    # param data [vector]: data set of values to test param:x against
    # return n [numeric]: a numeric value representing the normal distribution of the data set
    #---------------------------------------------------------------------------------------
    
    # The pnorm function requires a numeric argument in 1st position to be considered as "normal",
    # followed by the vector's mean, and standard deviation (sd).  The mean and sd can be calculated
    # easily using mean() and sd() functions on the data argument passed into this function.
    n <- pnorm(as.numeric(x), mean=mean(data), sd=sd(data), lower.tail=FALSE)
    return(n)
  }
  
  self$common <- function(data, lb=1, ub=5) {
    ## Determine the 5 most common numbers, in descending order for each vector column
    
    # param data [vector]: data set of values
    # param lb [numeric]: lower bounds of returned vector index - default 1
    # param ub [numeric]: upper bounds of returned vector index - default 3
    # return [data.frame]: a data.frame of the most common values found in the data set for each ball
    #---------------------------------------------------------------------------------------

    # Create the empty data frame for the output
    commonalities.df <- data.frame()

    # Iterate over each column of data within the larger data set 
    for (col in names(data)) {
      # If the column name has the phrase "Num" in it, then we know it is a column of ball numbers we want to use
      if ( grepl("Num", col) ) {
        # Create a named vector with the X most commonly found occurrences in the column of data
        common <- structure( rev(tail(names(sort(table(data[[col]]))),ub)), .Names=c("First.Most", "Second.Most", "Third.Most", "Fourth.Most", "Fifth.Most"))
        # convert vector to data.frame for appending/binding
        common <- as.data.frame(t(common))
        # replace auto created row names with the column names from the loop iteration
        rownames(common) <- c(col)
        # Append/bind this new vector to the data.frame buffer made at the beginning
        commonalities.df <- rbind(commonalities.df, common)
      }
    }

    return( commonalities.df )
  }
  
  # ------------------------- Class Closures/Config ------------------------ #
  self <- list2env(self) # sets the class environment, for assign() functions
  class(self) <- "Construct" # names the class
  
  # ----------- Instantiate Construct class with methods executing ----------- #
  # This section will ensure the following methods/functions are executed upon
  # class instantiation.  This is so we can simply call `Construct()` to create the
  # class, instead of calling the following from outside the class:
  #
  #  Construct <- Construct(file)
  #  Construct$import()
  #  Construct$makeDate()
  #  ... etc ...
  #
  # Essentially, these are methods we always want to execute when Construct() is called,
  # versus making the coder remember to call these as well in the main code.
  
  import()
  make_date()
  
  # ---------------------- Assign Instance Variables ----------------------- #
  # Get the count of the data frame to be Constructd
  self$count <- if ( length(self$data) > 0 ) NROW(self$data) else 0
  
  # ------------------------------------------------------------------------ #
  # This is required at the end of a class formation to ensure the instantiation call
  # (i.e. `Construct <- Construct(file)` ) receives an object back.  With this return()
  # statement, we are returning the "self" we created previously within the class 
  # definition areas above.
  return( self )
}

