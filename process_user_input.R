dir = "~/Documents/RShinyProjs/WellnessRoutines/www/"
responses = data.frame(fread(paste0(dir,"young_people_responses.csv")))
personality_topics = c("Punctuality","Smoking","Education","Only.child","Alcohol",
                       "Internet.usage","Loneliness","Dreams","Lying","Left...right.handed")
ind = which(colnames(responses) %in% personality_topics)
responses
responses = responses[,c(2:63,124:125,ind)]
responses = model.matrix( ~ ., data = responses)

colnames(responses)
music = responses[,3:19]
hobbies = responses[,20:63]
happiness = responses[,64:65]


predictors = responses[,66:ncol(responses)]
k_select = ceiling(0.10*nrow(responses))
sample_id = 50
result = get.knnx(predictors[-sample_id,],predictors[sample_id,,drop=FALSE],
                  algorithm = "cover_tree",k=k_select)

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
# education
# village
# children only
# alcohol
# internet useage
# 
# loneliness 
# lyring
# handedness
# persaonlity
# canging the pas
# parens advice
# ahcievments
# reliability
# prioritiziting worklopad
