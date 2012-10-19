install.packages("pixmap")
install.packages("nnet")
install.packages("e1071")
install.packages("ggplot2")

train <- read.csv("data/train.csv")
train.data <- train[0:dim(train)[1],2:dim(train)[2]]
train.label <- train[0:dim(train)[1],1]

# plotting
imageData <- matrix(train.data[1,],28,28)
imageData <- do.call(rbind, lapply(imageData, unlist))
# makes it back into one long list, so convert to matrix again?
imageData <- matrix(imageData, 28, 28)
image(imageData)

# subsets per label, for analysis
train_1 <- subset(train, label == 1)

# test data to get an output from
test.data <- read.csv("data/test.csv")

# neural net
# challenge: 785 neurons in hidden layer too much to calculate
# response: svd
library(nnet)
compress_image <- function(row) {
  imageData <- matrix(row,28,28)
  imageData <- do.call(rbind, lapply(imageData, unlist))
  # makes it back into one long list, so convert to matrix again?
  imageData <- matrix(imageData, 28, 28)
  imageData.svd <- svd(imageData)
  u <- imageData.svd$u
  d <- imageData.svd$d
  v <- imageData.svd$v
  i <- 10
  imageData.compressed <- u[,1:i] %*% diag(d[1:i]) %*% t(v[,1:i])
  imageData.compressed <- matrix(imageData.compressed,1,784)
}
train.data.compressed <- apply(train.data, 1, compress_image)
model <- nnet(train.data, train.label, size = 785)

library(e1071)
write("SVM", stdout())
model <- svm(train.data, train.label)
test.label <- predict(model, test)