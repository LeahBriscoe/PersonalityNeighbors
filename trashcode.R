#filter 
#responses = responses[-which(is.na(responses[,"Happiness.in.life"])),]

# responses[1:10,1:10]
# # colnames(test)[grepl("Left",colnames(test))]
# colnames(responses)[grepl("appi",colnames(responses))]
# responses$Personality
# table(responses$Happiness.in.life)
# which(grepl("History",colnames(responses)))
# 
# colnames(responses)[100:170]
# hobbies = responses[,3:34]
# happiness_ind = which(colnames(responses) == "Happiness.in.life" |colnames(responses) == "Energy.levels" )
# hapiness = responses[,happiness_ind]
# non_hobbies = responses[,c(1,2,35:123,125:ncol(responses))]
# 
# categorical_traits = c("Smoking","Alcohol","Punctuality","Lying","Internet.usage"  ,
#                        "Gender", "Left...right.handed","Education", "Only.child", "Village...town" ,            
#                        "House...block.of.flats")

cat_index = which(colnames(responses) %in% categorical_traits)
noncat_index = which(!(colnames(responses) %in% categorical_traits))


dim(model_matrix)
?model.matrix
# head(to.dummy(responses[,"Smoking"],"dum"))
# table(responses[,"Smoking"])


set.seed(1)
#Spliting data as training and test set. Using createDataPartition() function from caret


indxTrain <- createDataPartition(y=non_hobbies[,"Happiness.in.life"], p = 0.80,list = FALSE)
training <- non_hobbies[indxTrain,]
testing <- non_hobbies[-indxTrain,]


trainX <- training[,names(training) != "Happiness.in.life" & names(training) != "Energy.levels" ]
preProcValues <- ?preProcess(x = trainX,method = c("center", "scale"))
?preProcess
