#require(data.table)
library(dplyr)
#install.packages("RColorBrewer")
library(reshape2)
library(ggplot2)
library(RColorBrewer)

#packrat:::recursivePackageDependencies("RColorBrewer",lib.loc = .libPaths()[1])

dir = "www/"
#orig_responses = data.frame(fread(paste0(dir,"young_people_responses.csv")))

orig_responses = read.csv(paste0(dir,"young_people_responses.csv"))

personality_topics = c("Punctuality","Smoking","Education","Only.child","Alcohol",
                       "Internet.usage","Loneliness","Dreams","Lying","Left...right.handed")
ind = sapply(personality_topics,function(x){
  which(colnames(orig_responses) == x)
})
#table(responses$Left...right.handed)
orig_responses= orig_responses[,c(2:63,124:125,ind)]
get_recommendation <- function(timekeeping,smoking,edu,onlychild,alcohol,
                               internet_use,lonely,dreams,lying,handedness,plot_type){

  # formatted_personality = c("i am often early","never smoked","college/bachelor degree",
  #                           "no", "social drinker","few hours a day", 3,3,"everytime it suits me","left handed")
  # 
  formatted_personality = c(tolower(timekeeping),smoking,edu,onlychild,alcohol,
                                     internet_use,lonely,dreams,lying,handedness)
  print("formatted personality")
  print(formatted_personality)
  
  #query_input = data.frame(rep(0,dim(orig_responses)[2]-length(personality_topics)),formatted_personality)
  
  query_input <- data.frame(matrix(0,nrow = 1, ncol = ncol(orig_responses)))
  colnames(query_input) = colnames(orig_responses)
  query_input[1,personality_topics] =  formatted_personality
  #query_input[1,c("Loneliness","Dreams")] = as.integer(query_input[1,c("Loneliness","Dreams")] )
  responses =rbind(query_input,orig_responses)
  
  int_component = apply(responses[,1:64],2,as.integer)
  cat_component =responses[,65:70]
  int_component2 = apply(responses[,71:72],2,as.integer)
  cat_component2 = responses[,73:74]
  responses = cbind(int_component,cat_component,int_component2,cat_component2)
  colnames(responses)
  #responses[1,personality_topics] =  formatted_personality
  print(responses[1:2,64:ncol(responses)])
  responses = model.matrix( ~ ., data = responses)
  

  music = responses[,3:19]
  hobbies = responses[,20:63]
  happiness = responses[,64:65]


  predictors = responses[,66:ncol(responses)]
  k_select = ceiling(0.10*nrow(responses))
  sample_id = 1
  result = get.knnx(predictors[-sample_id,],predictors[sample_id,,drop=FALSE],
                    algorithm = "cover_tree",k=k_select)
  
  familiars = result$nn.index[1,]
  
  familiar_scores = result$nn.dist[1,]

  
  #   
  print(table(happiness[familiars,1]))
  happiness_scores = rowSums(happiness[familiars, ])
  #names(sort(happiness_scores,decreasing = TRUE))
  # determining the right group
  #sum()
  happy_familiars = names(which(happiness_scores >= 7))
  happy_familiar_scores = familiar_scores[(which(happiness_scores >= 7))]
  
  # get hobbies()
  #hobbies[happy_familiars[1:5],1] *%* -1*happy_familiar_scores[1:5]
  #colSums(hobbies[happy_familiars,])
  hobby_scores = colSums(hobbies[happy_familiars, ])
  best_hobbies = sort(hobby_scores / median(hobby_scores), decreasing =
                        TRUE)[1:10]
  
  music_scores = colSums(music[happy_familiars, ])
  best_music = sort(music_scores / median(music_scores), decreasing =
                      TRUE)[1:10]
  
  best_hobbies_names = gsub("\\.", " ", names(best_hobbies))
  best_music_names = gsub("\\.", " ", names(best_music))
  
  best_hobbies_scores = round(as.numeric(best_hobbies), 2)
  best_music_scores = round(as.numeric(best_music), 2)
  print(best_music_names)
  

  coul <- brewer.pal(10, "Set3") 
  to_plot= data.frame(best_hobbies_names, best_hobbies_scores)
  to_plot$best_hobbies_names = factor(to_plot$best_hobbies_names,
                                      levels =rev( to_plot$best_hobbies_names))
  
  
  p<-ggplot(data=to_plot, aes(x=best_hobbies_names, y=best_hobbies_scores,
                              fill=coul)) +
    geom_bar(stat="identity",show.legend = FALSE)+ coord_flip() + theme_bw()+
    labs(title="Top hobbies of your happiest personality neighbors", 
         x="Hobbies", y = "Score")
  #p
  
  to_plot= data.frame(best_music_names, best_music_scores)
  to_plot$best_music_names = factor(to_plot$best_music_names,
                                    levels =rev( to_plot$best_music_names))
  p2<-ggplot(data=to_plot, aes(x=best_music_names, y=best_music_scores,
                              fill=coul)) +
    geom_bar(stat="identity",show.legend = FALSE)+ coord_flip() + theme_bw()+
    labs(title="Top music genres of your happiest personality neighbors", 
         x="Music Taste", y = "Score")
  #p2
  gridExtra::grid.arrange(p, p2, nrow=2)
  # if(plot_type == "hobbies"){
  #   p<-ggplot(data=to_plot, aes(x=best_hobbies_names, y=best_hobbies_scores,
  #                               fill=coul)) +
  #     geom_bar(stat="identity",show.legend = FALSE)+ coord_flip() + theme_bw()+
  #     labs(title="Top hobbies of your happiest personality neighbors", 
  #          x="Hobbies", y = "Score")
  #   p
  #   
  # }else{
  #   to_plot= data.frame(best_music_names, best_music_scores)
  #   to_plot$best_music_names = factor(to_plot$best_music_names,
  #                                     levels =rev( to_plot$best_music_names))
  #   p<-ggplot(data=to_plot, aes(x=best_music_names, y=best_music_scores,
  #                               fill=coul)) +
  #     geom_bar(stat="identity",show.legend = FALSE)+ coord_flip() + theme_bw()+
  #     labs(title="Top hobbies of your happiest personality neighbors", 
  #          x="Music Taste", y = "Score")
  #   p
  # }
  
 
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
