library(ISLR2)
library(randomForest)
library(tree)

attach(Carseats)

MSE <- (\(predict, test) signif(mean((predict - test)**2), digits = 5))

seed <- 1
print(seed)

# A
set.seed(seed)

rand <- sample(nrow(Carseats), nrow(Carseats) / 2)
Carseats.train <- Carseats[rand, ]
Carseats.test <- Carseats[-rand, ]

# B
Carseats.tree <- tree(Sales ~ ., data = Carseats.train)
summary(Carseats.tree)

plot(Carseats.tree, type = "uniform")
text(Carseats.tree, pretty = 0)

Carseats.test.pred <- predict(Carseats.tree, Carseats.test)
MSE(Carseats.test$Sales, Carseats.test.pred)

# C
CV.Carseats <- cv.tree(Carseats.tree, FUN = prune.tree)
plot(CV.Carseats$size, CV.Carseats$dev, type = "b")

prune.Carseats <- prune.tree(Carseats.tree, best = 10)
summary(prune.Carseats)

plot(prune.Carseats, type = "uniform")
text(prune.Carseats, pretty = 0)

Carseats.test.prune <- predict(prune.Carseats, Carseats.test)
MSE(Carseats.test$Sales, Carseats.test.prune)

# D
set.seed(seed)

pNum <- length(Carseats) - 1
bag.Carseats <- randomForest(Sales ~ .,
    data = Carseats.train,
    mtry = pNum, ntree = 1000, importance = TRUE
)
bag.Carseats.pred <- predict(bag.Carseats, Carseats.test)
bag.MSE <- MSE(Carseats.test$Sales, bag.Carseats.pred)
bag.MSE

importance(bag.Carseats)

# E
set.seed(seed)

pNum <- sqrt(pNum)
rf.Carseats <- randomForest(Sales ~ .,
    data = Carseats.train,
    mtry = pNum, ntree = 1000, importance = TRUE
)
rf.Carseats.pred <- predict(rf.Carseats, Carseats.test)
rf.MSE <- MSE(Carseats.test$Sales, rf.Carseats.pred)
rf.MSE

importance(rf.Carseats)
