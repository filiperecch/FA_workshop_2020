#********************************************************************************
#********************************************************************************
#************** Basic commands - Factor Analysis and PCA ************************
#*************************** Workshop 2019 **************************************
#***************** Based on Ben Shear's workshop on 2016 ************************
#********************************************************************************

##############################################################################-
## Project: FA workshop
## Script purpose: Basic commands - FA and PCA Based on Ben Shear's 2016 workshop
## Date: 2020-03-05
## Author: Filipe Recch
##############################################################################-

## Packages, Parameters, & Input Data ----
##############################################################################-
suppressPackageStartupMessages(library(conflicted))
suppressPackageStartupMessages(library(janitor))
suppressPackageStartupMessages(library(magrittr))
suppressPackageStartupMessages(library(psych))
suppressPackageStartupMessages(library(GPArotation))
suppressPackageStartupMessages(library(tidyverse))

# Paths -------------------------------------------------------------------

source("file_paths.R")

##  Loading data ----
##############################################################################-

data_all_ctry <- read_csv(fs::path(data_root, "data_all_ctry.csv")) %>% 
  drop_na()

###  Overall check of the data ----
##############################################################################-

describe(data_all_ctry)

data_all_ctry_noID <- data_all_ctry %>% 
  select(-CNTRYID, -ID)

corr_matrix <- cor(data_all_ctry_noID)

round(corr_matrix, 2)

##  Factor Analysis ----
##############################################################################-

# All variables

ev <- eigen(corr_matrix)

ev$values

plot(ev$values, las = 1, type = "b") #scree plot

sum(ev$values > 1)

fa_results <- fa(r = data_all_ctry_noID,
                 fm = "minres", 
                 nfactors = 5, 
                 rotate = "promax", #allows correlation - use varimax for uncorrelated factors
                 covar = FALSE, # Covariance matrix if variable scales are similar; correlation matrix if different scales.
                 scores = "regression") #impute -> "mean" or "median" 

fa_results

print(fa_results$loadings, cutoff = 0.1)
print(fa_results$loadings, cutoff = 0.3)

cor(fa_results$scores) # What is expected to happen if we change the rotation to "varimax"

fa.diagram(fa_results, cut = 0.25, digits = 2, errors = TRUE, e.size = 0.1, rsize = 1)

factors <- fa_results$scores

factors

describe(factors)

# Only Section K: School Curriculum

data_sectionK <- data_all_ctry_noID %>% 
  select("CS4K1", 	"CS4K2", 	"CS4K3", 	"CS4K4", 	"CS4K5", 	"CS4K6", 	"CS4K7")

corr_matrix_sectionK <- cor(data_sectionK)

round(corr_matrix_sectionK, 2)

ev_sectionK <- eigen(corr_matrix_sectionK)

ev_sectionK$values

plot(ev_sectionK$values, las = 1, type = "b") #scree plot

sum(ev_sectionK$values > 1)

fa_results_sectionK <- fa(r = data_sectionK,
                 fm = "minres", # fm = "pa" for PCA
                 nfactors = 2, 
                 rotate = "promax", #allows correlation - use varimax for uncorrelated factors
                 covar = FALSE, # Covariance matrix if variable scales are similar; correlation matrix if different scales.
                 scores = "regression") #impute -> "mean" or "median" 

fa_results_sectionK

print(fa_results_sectionK$loadings, cutoff = 0.3)

cor(fa_results_sectionK$scores) # What is expected to happen if we change the rotation to "varimax"

fa.diagram(fa_results_sectionK, cut = 0.25, digits = 2, errors = TRUE, e.size = 0.1, rsize = 1)

factors_sectionK <- fa_results_sectionK$scores

factors_sectionK

describe(factors_sectionK)

# Only Section N: Classrooms

data_sectionN <- data_all_ctry_noID %>% 
  select("CS4N1", 	"CS4N2", 	"CS4N3", 	"CS4N4", 	"CS4N5",  "CS4N6", 	"CS4N7", 	
         "CS4N8", 	"CS4N9", 	"CS4N10", "CS4N11", "CS4N12")

corr_matrix_sectionN <- cor(data_sectionN)

round(corr_matrix_sectionN, 2)

ev_sectionN <- eigen(corr_matrix_sectionN)

ev_sectionN$values

plot(ev_sectionN$values, las = 1, type = "b") #scree plot

sum(ev_sectionN$values > 1)

fa_results_sectionN <- fa(r = data_sectionN,
                          fm = "minres", # fm = "pa" for PCA
                          nfactors = 4, 
                          rotate = "promax", #allows correlation - use varimax for uncorrelated factors
                          covar = FALSE, # Covariance matrix if variable scales are similar; correlation matrix if different scales.
                          scores = "regression") #impute -> "mean" or "median" 

fa_results_sectionN

print(fa_results_sectionN$loadings, cutoff = 0.3)

cor(fa_results_sectionN$scores) # What is expected to happen if we change the rotation to "varimax"

fa.diagram(fa_results_sectionN, cut = 0.25, digits = 2, errors = TRUE, e.size = 0.1, rsize = 1)

factors_sectionN <- fa_results_sectionN$scores

factors_sectionN

describe(factors_sectionN)

##################################################################################

##################################################################################

# # Ordinal data 
# 
# poly_data <- polychoric(data_ORDINAL)
# 
# matrix_poly <- poly_data$rho
# 
# poly_results <- fa(r = matrix_poly, n.obs = 300, nfactors = 2, rotate = "promax", fm = "pa", covar = FALSE)
# 
# poly_results_pysch <- fa.poly(x = data_ORDINAL, nfactors = 2, rotate = "promax", fm = "pa", covar = F, scores = "regression")
# 
# plot(poly_results_pysch$fa$e.values, las = 1, type = "b") # scree plot
# 
# print(loadings(poly_results_pysch$fa), cutoff=0)
# 
# Fscores_poly <- factor.scores(x = data_ORDINAL,
#                               f = poly_results_pysch$fa$Structure,
#                               method = "regression",
#                               rho = poly_results_pysch$rho)$scores
# 
# describe(Fscores_poly)




