library(caret)
library(data.table)
library(varhandle)
library(FNN)
library(arm)
dir = "~/Documents/RShinyProjs/WellnessRoutines/www/"
#responses = read.csv(paste0(dir,"young_people_responses.csv"))

responses = data.frame(fread(paste0(dir,"young_people_responses.csv")))
responses = model.matrix( ~ ., data = responses)
responses[1:4,1:4]
colnames(responses)
music = responses[,3:20]
hobbies = responses[,21:64]
happiness = responses[,135:136]
predictors = responses[,c(64:134,137:ncol(responses))]
#determine_predictors 

together = cbind(happy = happiness[,1],predictors)
together[1:10,1:10]
lm1 <- train(happy~., data = together, method = "lm")
sort(abs(lm1$finalModel$coefficients),decreasing =TRUE)[1:50]

colnames(together)
# indxTrain <-
#   createDataPartition(y = happines[,1], p = 0.80, list = FALSE)
# training <- non_hobbies[indxTrain, ]
# testing <- non_hobbies[-indxTrain, ]
# 
# default_glm_mod = train(
#   form = as.numeric(happiness[, 1, drop = FALSE]) ~ .,
#   data = predictors,
#   trControl = trainControl(method = "cv", number = 5),
#   method = "blasso"
# )
# 
# default_glm_mod = train(
#   form = happiness[, 1, drop = FALSE] ~ .,
#   data = predictors,
#   trControl = trainControl(method = "cv", number = 5),
#   method = "bayesglm"
# )
