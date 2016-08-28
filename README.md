# Data Product Assignment: Motor Trend WebApp


## Overview

The repository contains the completed assignment of the DataProduct course from the Data Science Specialisation proposed by John Hopkins university on Coursera.

This assignment consists on:

1. Creating a Shiny application and deploy it on Rstudio's servers. It must include:
	* Some form of input (widget: textbox, radio button, checkbox, ...)
	* Some operation on the ui input in `server.R`
	* Some reactive output displayed as a result of server calculations
	* Enough documentation so that a novice user could use your application
1. use Slidify or Rstudio Presenter to prepare a reproducible pitch presentation about your application.

## Content

This repository contains the following files

1. Shiny Application
	* `global.R` contains global variables and function use by both `ui.R` and `server.R`
	* `ui.R` control the interface layout
	* `server.R` contains the commands needed for the reactive output and calculations
1. Slidify presentation
	* `index.Rmd` R markdown source of the presentation
	* `index.html` Compiled html presentation
	* Note: The markdown version is not included as the figure cannot display while compiling this format

## Shiny Application: Motor Trend Data set, Visualization and linear modeling

The idea of the application is to:

1. visualize the `mtcars` dataset package. 
To this purpose 
1. superimpose and test linear model on selected variables

### Data

The data was extracted from the 1974 Motor Trend US magazine  [^1]. This data set is a data set within `R`, it comprises fuel consumption and 10 aspects of automobile design and performance for 32 automobiles (1973–74 models). 

This dataset `mtcars` contains:

* continuous variables
	* Miles/(US) Gallon: `mpg`
	* Weight: `wt` [1000 lbs]
	* Displacement: `disp` [cu.in]
	* Horse Power: `hp`
	* Rear Axle ratio: `drat`
	* 1/4 Mile time: `qsec`
* factor variables
	* Nb of cylinders: `cyl` with levels 4, 6 and 8
	* Engine type: `V/S` with levels 0 and 1, rewritten as "V engine" and "Straight engine"
	* Transmission: `am` with levels 0 and 1, rewritten as "automatic" and "manual"
	* Nb of gear: `gear` with levels 3, 4 and 5
	* Nb of carburators: 'carb` with levels 1, 2, 3, 4, 6 and 8 rewritten as "1", "2 or 3" and "4 or more"
	
	
### Application Layout

1. **Sidebar**: 
	* control which variable to display and use for the linear model
	* control which option to use for the linear model
	*  a slider input can be unable to test the impact of one of the variable on the prediction
1. **Visualization** Tab:
	* Top figure:
		*  display an interactive bubble plot of the variables selected by the user
		*  over-impose the linear prediction of the linear model per factor variable
		*  the prediction can be affected by the slider input depending on the model
	* Bottom figure:
		* display an interactive bubble plot of the residual to the selected linear model
1. **Modelization** Tab:
	* Top table: show the fitted coefficients  of the fitted model with their p-values
	* Bottom table: anova test of the 4 possible models, the r-squared values have been added as an additional column.
		
### Changing the variables

The upper part of the sidebar enable the user to select which variable to use and display through vertical menu. Each change cause automatic modifications of the figures, models and text.

* **X variable** drop down list: The user select one of the continuous variable to use as abscissa. Default: Weight.
* **Y variable** drop down list: The user select one of the continuous variable to use as ordinate. Default: Miles/(US) Gallon
* **Point size variable** drop down list: The user select one of the continuous variable to display as the size of the bubble. Default: Displacement
* **Color variable** drop down list: The user select the factor of the variable to display as the color of the bubble. Default: Nb of cylinders

### Fitting a linear model

The lower part of the sidebar enable the users to test up to 4 linear models, and test the impact of an additional variable to the prediction. Each modification will automatically impact the fitted lines ont the upper figure on the **Visualization** tab. The checkbox additionally impact the lower figure on the **Visualization** tab as well as the text and upper table in the **Modelization** tab.

* **Multiple slope** check box: The user select whether the model is single slope (default), or multiple slopes. If unchecked all lines are parallel.
* **Use `Point size variable`** check box: If the  **Point size variable** differ from both the  **X variable** and **Y variable**, the user has the option to use this third variable in the linear model (not the case by default). If used the slider is activated.
*  **Delta `Point size variable`** slider: In order to make prediction using this third variable, we first set a linear model to predict it as a function of the 
**X variable** and **Color variable**. The slider input controls which value to take within the 90% confidence interval of the prediction. 

## Version and package requirement

This application and related document were created on a MacBook Pro running Mac OS X 10.11.6 (15G31) and RStudio Version 0.99.892

The package requirement are the foolowing

* Shiny Application:
	* `shiny`
	* `dplyr`
	* `ggvis`
* Slidify Presentation
	* `slidify`
	* `slidify_libraries`
	* `knitr`
	* `dplyr`
	* `ggvis`

[^1]: Henderson and Velleman (1981), Building multiple regression models interactively. Biometrics, 37, 391–411.