library(glmnet)
library(ISLR2)
library(pls)

attach(College)

MSE <- (\(predict, test) as.integer(mean((predict - test)**2)))

seed <- 1668526516
print(seed)

# A
set.seed(seed)

rand <- sample(nrow(College), nrow(College) / 2)
College.train <- College[rand, ]
College.test <- College[-rand, ]

# B
College.lm <- lm(Apps ~ ., data = College.train)
College.lm.pred <- predict(College.lm, College.test)
College.lm.MSE <- MSE(College.test$Apps, College.lm.pred)
College.lm.MSE

# C
College.train.mat <- model.matrix(Apps ~ ., College.train)
College.test.mat <- model.matrix(Apps ~ ., College.test)
grid <- 10**seq(5, -5, length = 1000)

set.seed(seed)

ridge.mod <- cv.glmnet(College.train.mat, College.train$Apps,
    alpha = 0, lambda = grid, thresh = 1e-12
)
lambda.ridge <- ridge.mod$lambda.min
lambda.ridge

ridge.pred <- predict(ridge.mod, College.test.mat, s = lambda.ridge)
ridge.MSE <- MSE(College.test$Apps, ridge.pred)
ridge.MSE

# D
set.seed(seed)

lasso.mod <- cv.glmnet(College.train.mat, College.train$Apps,
    alpha = 1, lambda = grid, thresh = 1e-12
)
lambda.lasso <- lasso.mod$lambda.min
lambda.lasso

lasso.pred <- predict(lasso.mod, College.test.mat, s = lambda.lasso)
lasso.MSE <- MSE(College.test$Apps, lasso.pred)
lasso.MSE

lasso.modA <- glmnet(model.matrix(Apps ~ ., data = College), College$Apps, alpha = 1)
lasso.coef <- predict(lasso.modA, s = lambda.lasso, type = "coefficients")
lasso.coef

# E
set.seed(seed)

pcr.mod <- pcr(Apps ~ ., data = College.train, scale = TRUE, validation = "CV")
validationplot(pcr.mod, val.type = "MSEP")

pcr.pred <- predict(pcr.mod, College.test, ncomp = 9)
pcr.MSE <- MSE(College.test$Apps, pcr.pred)
pcr.MSE
