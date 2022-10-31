library(boot)
library(ggplot2)

# A
set.seed(1)
y <- rnorm(100)
x <- rnorm(100)
y <- x - 2 * x^2 + rnorm(100)

dataset <- data.frame(x, y)

# B
ggplot(dataset, aes(x = x, y = y)) +
    geom_point() +
    theme_linedraw()

# C
set.seed(1)
cv.mse <- data.frame()

for (i in 1:4) {
    glm.fit <- glm(y ~ poly(x, i))
    glm.mse <- cv.glm(dataset, glm.fit)$delta
    cv.mse <- rbind(cv.mse, data.frame(avgMse = glm.mse[1], adjMse = glm.mse[2]))
}

cv.mse

# D
set.seed(2)
cv.mse <- data.frame()

for (i in 1:4) {
    glm.fit <- glm(y ~ poly(x, i))
    glm.mse <- cv.glm(dataset, glm.fit)$delta
    cv.mse <- rbind(cv.mse, data.frame(avgMse = glm.mse[1], adjMse = glm.mse[2]))
}

cv.mse

# E
which.min(cv.mse$avgMse)
which.min(cv.mse$adjMse)

# F
summary(glm(y ~ poly(x, 4)))
