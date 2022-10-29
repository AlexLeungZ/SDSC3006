library(ISLR2)
library(ggplot2)
attach(Carseats)

# A
summary(Carseats)

lm.fit = lm(Sales ~ Price + Urban + US)
summary(lm.fit)

# E
lm.fit2 = lm(Sales ~ Price + US)
summary(lm.fit2)

# G
confint(lm.fit2, level = 0.95)

# H
ggplot(lm.fit2, aes(.fitted, .stdresid)) + 
    geom_point() +
    theme_linedraw()

mean(hatvalues(lm.fit2))

ggplot(lm.fit2, aes(.hat, .stdresid, colour = .hat)) +
    scale_colour_continuous(guide = "none") +
    geom_point(aes(size = .cooksd)) +
    geom_line(aes(x = mean(.hat)), size = 1, colour = "red") +
    theme_linedraw()