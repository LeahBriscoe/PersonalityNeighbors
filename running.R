#install.packages("shiny")
library(shiny)
#runExample("01_hello")
runApp("~/Documents/RShinyProjs/PersonalityNeighbors")


library('rsconnect')
rsconnect::setAccountInfo(name='personalityneighbors',
                          token='EB318007AF0046EFC4C99AAA3C9FE3BD',
                          secret='URrym8h4yohA2TZYqwxi8e9s2F69vRDG3WlrGrSC')
rsconnect::deployApp('~/Documents/RShinyProjs/PersonalityNeighbors')

