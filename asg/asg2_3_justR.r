library(caret)
library(class)
library(ggplot2)
library(ISLR2)
library(MASS)
library(reshape2)

attach(Weekly)

# A
summary(Weekly)

meltCor=melt(round(cor(Weekly[,-9]),10))
ggplot(data=meltCor,aes(x=Var1,y=Var2,fill=value))+
    geom_tile(color="black")+
    scale_fill_gradient(low="white",high="red")+
    coord_fixed()+
    theme_grey(base_size=14)+
    theme(legend.position="none",
        axis.ticks=element_blank(),
        axis.text.x=element_text(angle=330,hjust=0))

# B
log.fit=glm(Direction~Lag1+Lag2+Lag3+Lag4+Lag5+Volume,data=Weekly,family=binomial)
summary(log.fit)

# C
log.resp=predict(log.fit,type="response")
log.pred=rep("Down",length(log.resp))
log.pred[log.resp>0.5]="Up"

confusionMatrix(factor(log.pred),factor(Direction))

# D
train=(Year<2009)
test=Weekly[!train,]

test.direction=Direction[!train]

slog.glm=glm(Direction~Lag2,data=Weekly,family=binomial,subset=train)
slog.resp=predict(slog.glm,test,type="response")
slog.pred=rep("Down",length(slog.resp))
slog.pred[slog.resp>0.5]="Up"

confusionMatrix(factor(slog.pred),factor(test.direction))

# E
lda.lda=lda(Direction~Lag2,data=Weekly,subset=train)
lda.pred=predict(lda.lda,test)

confusionMatrix(factor(lda.pred$class),factor(test.direction))

# F
qda.qda=qda(Direction~Lag2,data=Weekly,subset=train)
qda.pred=predict(qda.qda,test)

confusionMatrix(factor(qda.pred$class),factor(test.direction))

# G
train.mat=as.matrix(Lag2[train])
test.mat=as.matrix(Lag2[!train])

train.direction=Direction[train]

knn.pred=knn(train.mat,test.mat,train.direction,k=1)
confusionMatrix(factor(knn.pred),factor(test.direction))