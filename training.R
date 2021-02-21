library(caret)
library(data.table)
library(varhandle)
library(FNN)
library(arm)
dir = "~/Documents/RShinyProjs/WellnessRoutines/www/"
responses = read.csv(paste0(dir,"young_people_responses.csv"))
responses = model.matrix( ~ ., data = responses)
colnames(responses)
music = responses[,3:20]
hobbies = responses[,21:64]
happiness = responses[,135:136]
predictors = responses[,c(64:134,137:ncol(responses))]
determine_predictors <- function(){
  indxTrain <- createDataPartition(y=non_hobbies[,"Happiness.in.life"], p = 0.80,list = FALSE)
  training <- non_hobbies[indxTrain,]
  testing <- non_hobbies[-indxTrain,]
  
  default_glm_mod = train(
    form = as.numeric(happiness[,1,drop=FALSE]) ~ .,
    data = predictors,
    trControl = trainControl(method = "cv", number = 5),
    method = "blasso"
  )
  
  default_glm_mod = train(
    form = happiness[,1,drop=FALSE] ~ .,
    data = predictors,
    trControl = trainControl(method = "cv", number = 5),
    method = "bayesglm"
  )
}
colnames(non_hobbies)


set.seed(0)
k_select = ceiling(0.10*nrow(responses))
if(train_mode){
  sample_id = 50
  result = get.knnx(predictors[-sample_id,],predictors[sample_id,,drop=FALSE],
                    algorithm = "cover_tree",k=k_select)
  
}else{
  result = get.knnx(predictors[-sample_id,],query,
                    algorithm = "cover_tree",k=k_select)
}






qualities_individual_train <- function(familiars = result$nn.index[1,],
                                       familiar_scores = result$nn.dist[1,]){
  print("results")
  print(table(happiness[familiars,]))
  happiness_scores = rowSums(happiness[familiars,])
  #names(sort(happiness_scores,decreasing = TRUE))
  happy_familiars = names(which(happiness_scores>= 7))
  happy_familiar_scores =familiar_scores[(which(happiness_scores>= 7))]
  
  # get hobbies()
  #hobbies[happy_familiars[1:5],1] *%* -1*happy_familiar_scores[1:5]
  #colSums(hobbies[happy_familiars,])
  hobby_scores = colSums(hobbies[happy_familiars,])
  best_hobbies = sort(hobby_scores/median(hobby_scores),decreasing=TRUE)[1:10]
  
  music_scores = colSums(music[happy_familiars,])
  best_music = sort(music_scores/median(music_scores),decreasing=TRUE)[1:10]
  
  best_hobbies_names = gsub("\\.", " ",names(best_hobbies))
  best_music_names = gsub("\\.", " ",names(best_music))
  
  best_hobbies_scores =round(as.numeric(best_hobbies),2)
  best_music_scores =round(as.numeric(best_music),2)
  
}

qualities_individual_train <- function(query = sample_id,familiars = result$nn.index[1,],
                                 familiar_scores = result$nn.dist[1,]){
  print("individual")
  print(happiness[sample_id,])
  
  print("results")
  print(table(happiness[familiars,]))
  happiness_scores = rowSums(happiness[familiars,])
  #names(sort(happiness_scores,decreasing = TRUE))
  happy_familiars = names(which(happiness_scores>= 7))
  happy_familiar_scores =familiar_scores[(which(happiness_scores>= 7))]
  
  # get hobbies()
  #hobbies[happy_familiars[1:5],1] *%* -1*happy_familiar_scores[1:5]
  #colSums(hobbies[happy_familiars,])
  hobby_scores = colSums(hobbies[happy_familiars,])
  best_hobbies = sort(hobby_scores/median(hobby_scores),decreasing=TRUE)[1:10]
  
  music_scores = colSums(music[happy_familiars,])
  best_music = sort(music_scores/median(music_scores),decreasing=TRUE)[1:10]
  
  best_hobbies_names = gsub("\\.", " ",names(best_hobbies))
  best_music_names = gsub("\\.", " ",names(best_music))
  
  best_hobbies_scores =round(as.numeric(best_hobbies),2)
  best_music_scores =round(as.numeric(best_music),2)
  
}

