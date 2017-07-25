#!/usr/local/bin/R

# ----------------------------- Install Required Packages ----------------------------- #
if(!require(randtests)){install.packages("randtests")}
# ---------------------------------- Import Libraries --------------------------------- #
library(randtests)
# ------------------------------------------------------------------------------------- #


# Class constructor, Randomness will contain all pertinent methods/functions for determining
# and proving the random variance of the main data set, while other classes could be imported 
# for functions related to plotting, etc.

Randomness <- function(data) {
  
  # The term "self = ..." is important next because it names the internal instance of the class.
  # We need a way, within the class, to reference other class functions and properties.  With "self"
  # we can do this by referencing self$_____ where the blank could be a method name or a property.
  
  # create the class initializer with class variables and basic getters/setters
  self = list(
     get = function(x) self[[x]]
    ,set = function(x, value) self[[x]] <<- value
    ,props = list()
    ,data = data
  )
  
  self$wald_wolfowitz <- function(x, p=FALSE) {
    ## The Wald–Wolfowitz runs test (or simply runs test), named after Abraham Wald and Jacob Wolfowitz, 
    ## is a non-parametric statistical test that checks a randomness hypothesis for a two-valued data sequence. 
    ## More precisely, it can be used to test the hypothesis that the elements of the sequence are mutually independent.
    
    ## This test searches for randomness in the observed data series x by examining the frequency of runs. A "run" is defined 
    ## as a series of similar responses.
    
    # param x [list|factor]: a list/factor of data to test and prove non-randomness
    # returns list: list containing following value sets:
    #   - statistic: the value of the normalized statistic test.
    #   - parameter: a vector with the sample size, and the values of n1 and n2.
    #   - p.value: the p-value of the test.
    #   - alternative: a character string describing the alternative hypothesis.
    #   - method: a character string indicating the test performed.
    #   - data.name: a character string giving the name of the data.
    #   - runs: the total number of runs (not shown on screen).
    #   - mu: the mean value of the statistic test (not shown on screen).
    #   - var: the variance of the statistic test (not shown on screen).
    #---------------------------------------------------------------------------------------
    
    return( runs.test( x, plot=p ) )
  }
  
  
  # ------------------------- Class Closures/Config ------------------------ #
  self <- list2env(self) # sets the class environment, for assign() functions
  class(self) <- "Randomness" # names the class
  
  # ---------------------- Assign Instance Variables ----------------------- #

  # ------------------------------------------------------------------------ #
  # This is required at the end of a class formation to ensure the instantiation call
  # (i.e. `randomness <- Randomness(data)` ) receives an object back.  With this return()
  # statement, we are returning the "self" we created previously within the class 
  # definition areas above.
  return( self ) 
  
}
