#!/usr/local/bin/R

# ----------------------------- Install Required Packages ----------------------------- #
if(!require(mblm)){install.packages("mblm")}
#if(!require(lmtest)){install.packages("lmtest")}

# ---------------------------------- Import Libraries --------------------------------- #
library(mblm)
# ------------------------------------------------------------------------------------- #


# Class constructor, Regression will contain all pertinent methods/functions for performing
# regression analysis on the main data set, while other classes could be imported for 
# functions related to plotting, etc.

Regression <- function(data) {
  
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
  
  self$nonparametric_linear_regression <- function() {
    ## Kendall–Theil regression is a completely nonparametric approach to linear regression where there 
    ## is one independent and one dependent variable.  It is robust to outliers in the dependent variable.  
    ## It simply computes all the lines between each pair of points, and uses the median of the slopes of these lines.  
    ## This method is sometimes called Theil–Sen.  A modified, and preferred, method is named after Siegel.
    
    ## The method yields a slope and intercept for the fit line, and a p-value for the slope can be determined as well.  
    ## Typically, no measure analogous to r-squared is reported.
    #---------------------------------------------------------------------------------------
    
    model.k = mblm(Num1 ~ Num2, data=self$data)
    
    summary(model.k)
  }
  
  self$quantile_regression <- function() {
    ## While traditional linear regression models the conditional mean of the dependent variable, quantile regression models 
    ## the conditional median or other quantile. Medians are most common, but for example, if the factors predicting the highest 
    ## values of the dependent variable are to be investigated, a 95th percentile could be used.  Likewise, models for several 
    ## quantiles, e.g. 25th , 50th, 75th percentiles, could be investigated simultaneously.
    
    ## Quantile regression makes no assumptions about the distribution of the underlying data, and is robust to outliers in the 
    ## dependent variable.  It does assume the dependent variable is continuous.  However, there are functions for other types of 
    ## dependent variables in the qtools package.  The model assumes that the terms are linearly related. Quantile regression is 
    ## sometimes considered “semiparametric”.
    
    ## Quantile regression is very flexible in the number and types of independent variables that can be added to the model.
  }
  
 
  # ------------------------- Class Closures/Config ------------------------ #
  self <- list2env(self) # sets the class environment, for assign() functions
  class(self) <- "Regression" # names the class
  
  # ---------------------- Assign Instance Variables ----------------------- #
  
  # ------------------------------------------------------------------------ #
  # This is required at the end of a class formation to ensure the instantiation call
  # (i.e. `regression <- Regression(data)` ) receives an object back.  With this return()
  # statement, we are returning the "self" we created previously within the class 
  # definition areas above.
  return( self ) 

}
  