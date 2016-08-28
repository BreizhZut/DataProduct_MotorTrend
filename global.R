
library(shiny)
library(ggvis,dplyr)

data(mtcars)

faclist <- c("Nb of cylinders","Engine type","Transmission","Nb of gears","Nb of carburators")
varlist <- c("Miles/(US) gallon","Weight","Displacement","Horse power","Rear axle ratio","1/4 Mile time")

setvar <- function(ivar){
    svar <- NULL
    if(ivar == varlist[1]) {svar <- mtcars$mpg}
    if(ivar == varlist[2]) {svar <- mtcars$wt}
    if(ivar == varlist[3]) {svar <- mtcars$disp}
    if(ivar == varlist[4]) {svar <- mtcars$hp}
    if(ivar == varlist[5]) {svar <- mtcars$drat}
    if(ivar == varlist[6]) {svar <- mtcars$qsec}
    svar
} 

setfac <- function(ifac){
    sfac <- NULL
    if(ifac ==faclist[1]) {sfac <- as.factor(mtcars$cyl)}
    if(ifac ==faclist[2]) {sfac <- factor(mtcars$vs,levels=c(0,1),labels = c("V engine","Straight engine"))}
    if(ifac ==faclist[3]) {
        sfac <-factor(mtcars$am,levels=c(1,0),labels=c("automatic","manual"))
    }
    if(ifac ==faclist[4]) {sfac <-as.factor(mtcars$gear)}
    if(ifac ==faclist[5]) {
        sfac <-mtcars$carb
        sfac[grep("[23]",as.character(sfac))] <-2
        sfac[grep("[4-9]",as.character(sfac))] <-3
        sfac <- factor(sfac,levels=c(1,2,3),labels=c("1","2 or 3","4 or more"))
    }
    sfac
} 

setrang <- function(ivar){
    rang <- c(1,10)
    if(ivar == varlist[1]) {rang <- c(10,35)}
    if(ivar == varlist[2]) {rang <- c(1,6)}
    if(ivar == varlist[3]) {rang <- c(50,500)}
    if(ivar == varlist[4]) {rang <- c(50,400)}
    if(ivar == varlist[5]) {rang <- c(2,5)}
    if(ivar == varlist[6]) {rang <- c(10,25)}
    rang
} 


setlab <- function(ilab){
    slab <- NULL
    if(ilab == varlist[1]) {slab <- "Miles/(US) gallon"}
    if(ilab == varlist[2]) {slab <- "Weight [1000 lbs]"}
    if(ilab == varlist[3]) {slab <-"Displacement [cu.in]"}
    if(ilab == varlist[4]) {slab <-"Gross horsepower"}
    if(ilab == varlist[5]) {slab <-"Rear axle ratio"}
    if(ilab == varlist[6]) {slab <-"1/4 mile time [s]"}
    if(ilab %in% faclist) {slab <- ilab}
    slab
}    
