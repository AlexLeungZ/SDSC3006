library(caret)
library(e1071)
library(ISLR)

attach(OJ)

MSE <- function(real, pred) {
    return(signif(1 - confusionMatrix(real, pred)$overall[["Accuracy"]], digits = 5))
}

seed <- 1
print(seed)

# A
set.seed(seed)

rand <- sample(nrow(OJ), 800)
OJ.train <- OJ[rand, ]
OJ.test <- OJ[-rand, ]

# B
set.seed(seed)

OJ.svm <- svm(Purchase ~ ., data = OJ.train, kernel = "linear", cost = 0.01)
summary(OJ.svm)

# C
OJ.train.pred <- predict(OJ.svm, OJ.train)
MSE(OJ.train$Purchase, OJ.train.pred)

OJ.test.pred <- predict(OJ.svm, OJ.test)
MSE(OJ.test$Purchase, OJ.test.pred)

# D
set.seed(seed)

tune.out <- tune(svm, Purchase ~ .,
    data = OJ.train,
    kernel = "linear", ranges = list(cost = 10**seq(-2, 1, 0.1))
)
tune.best <- tune.out$best.model
summary(tune.best)

# E
tune.train.pred <- predict(tune.best, OJ.train)
linear.trainMSE <- MSE(OJ.train$Purchase, tune.train.pred)
linear.trainMSE

tune.test.pred <- predict(tune.best, OJ.test)
linear.testMSE <- MSE(OJ.test$Purchase, tune.test.pred)
linear.testMSE

# F
set.seed(seed)

OJ.radial <- svm(Purchase ~ ., data = OJ.train, kernel = "radial")
summary(OJ.radial)

OJ.trainR.pred <- predict(OJ.radial, OJ.train)
MSE(OJ.train$Purchase, OJ.trainR.pred)

OJ.testR.pred <- predict(OJ.radial, OJ.test)
MSE(OJ.test$Purchase, OJ.testR.pred)

set.seed(seed)

radial.out <- tune(svm, Purchase ~ .,
    data = OJ.train,
    kernel = "radial", ranges = list(cost = 10**seq(-2, 1, 0.1))
)
radial.best <- radial.out$best.model
summary(radial.best)

radial.train.pred <- predict(radial.best, OJ.train)
radial.trainMSE <- MSE(OJ.train$Purchase, radial.train.pred)
radial.trainMSE

radial.test.pred <- predict(radial.best, OJ.test)
radial.testMSE <- MSE(OJ.test$Purchase, radial.test.pred)
radial.testMSE

# G
set.seed(seed)

OJ.poly <- svm(Purchase ~ .,
    data = OJ.train,
    kernel = "poly", degree = 2
)
summary(OJ.poly)

OJ.trainP.pred <- predict(OJ.poly, OJ.train)
MSE(OJ.train$Purchase, OJ.trainP.pred)

OJ.testP.pred <- predict(OJ.poly, OJ.test)
MSE(OJ.test$Purchase, OJ.testP.pred)

set.seed(seed)

poly.out <- tune(svm, Purchase ~ .,
    data = OJ.train,
    kernel = "poly", degree = 2, ranges = list(cost = 10**seq(-2, 1, 0.1))
)
poly.best <- poly.out$best.model
summary(poly.best)

poly.train.pred <- predict(poly.best, OJ.train)
poly.trainMSE <- MSE(OJ.train$Purchase, poly.train.pred)
poly.trainMSE

poly.test.pred <- predict(poly.best, OJ.test)
poly.testMSE <- MSE(OJ.test$Purchase, poly.test.pred)
poly.testMSE

# H
print(linear.trainMSE)
print(linear.testMSE)
print(radial.trainMSE)
print(radial.testMSE)
print(poly.trainMSE)
print(poly.testMSE)
