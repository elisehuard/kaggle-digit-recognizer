install.packages("pixmap")
install.packages("nnet")
install.packages("e1071")
install.packages("ggplot2")

train <- read.csv("data/train.csv")
train.data <- train[0:dim(train)[1],2:dim(train)[2]]
train.label <- train[0:dim(train)[1],1]

library(pixmap)
library(ggplot2)
imageData <- matrix(train.data[1,],28,28)
bitmap <- pixmap(imageData)
ggplot(bitmap)

test.data <- read.csv("data/test.csv")

# neural net
# challenge: 785 neurons in hidden layer too much to calculate
library(nnet)
model <- nnet(train.data, train.label, size = 785)

library(e1071)
write("SVM", stdout())
model <- svm(train.data, train.label)
test.label <- predict(model, test)