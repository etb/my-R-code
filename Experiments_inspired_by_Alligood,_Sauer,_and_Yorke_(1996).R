# rm(list = ls(all = TRUE)) ## Clear workspace
####################################################################
#####       Author: etb                                         ####
#####       Date Created: Sat Sep 12  11:54:00 AM 2015          ####
#####       Version 0.1                                         ####
#####       The scrips: Experiments inspired by Alligood,       ####
#####                   Sauer, and Yorke (1996). Chaos: An      #### 
#####                   Introduction to Dynamical               #### 
#####                   Systems, New York, Springer,            ####
#####                   chapters 1-2 using R                    ####
#####        Thanks to: code inspired by bayesianbiologist.com  ####
####################################################################


####################################################################
##                                                                ##
##            Define Parameters cf. p. 3-4                        ##
##                                                                ##
N <- 12+1 # iterations
x_o <- 10000/1000000 # # initial_state 
r=2 # factor

####################################################################
##                                                                ##
##            f^n(x) in a transparent way, f(x) = 2x              ##
##                                                                ##
f_x <- array(dim=N)
f_x[1] <- x_o
for(i in 2:N)
f_x[i] <- r*f_x[i-1]
f_x <- format(f_x, nsmall = 10)
# f_x

####################################################################
##                                                                ##
##            g^n(x) in a transparent way, g(x) = 2x(1-x)         ##
##                                                                ##
g_x <- array(dim=N)
g_x[1] <- x_o
for(i in 2:N)
g_x[i]<-r*g_x[i-1]*(1-g_x[i-1])
g_x <- format(g_x, nsmall = 10)
# g_x

####################################################################
##                                                                ##
##            Display data (table 1.1. p. 4)                      ##
##                                                                ##
iteration_no <- 0:(N-1)
df <- data.frame(iteration_no, f_x, g_x)
df


####################################################################
##                                                                ##
##            Cobweb Plot, exponential growth  f^n(x)             ##
##            (Figure 1.1 p. 6)                                   ##
##                                                                ##

exponential_growth_map<-function(r=1,x_o=runif(1,0,1),N=20,burn_in=0,...)
{
par(mfrow=c(2,1),mar=c(4,4,1,2),lwd=1)
############# Trace #############
x<-array(dim=N)
x[1]<-x_o
for(i in 2:N)
x[i]<-r*x[i-1]

plot(x[(burn_in+1):N],type='l',xlab=paste(N, "iterations"),ylab='x',...)
#################################
 
##########  exponential Map ########
x<-seq(from=0,to=1,length.out=100)
x_np1<-array(dim=100)
for(i in 1:length(x))
x_np1[i]<-r*x[i]
 
plot(x,x_np1,type='l', lwd = 2,xlab=expression(x[t]),ylab=expression(x[t+1]))
text(.5,1.3,paste0("f(x)=",r,"x"), cex = .75)
abline(0,1)
text(.7,.4,"y=x", cex = .75) 
start=x_o
vert=FALSE
lines(x=c(start,start),y=c(0,r*start), lty = 2, lwd = 0.7)
for(i in 1:(2*N))
{
if(vert)
{
lines(x=c(start,start),y=c(start,r*start), lty = 2, lwd = 0.7)
vert=FALSE
}
else
{
lines(x=c(start,
r*start),
y=c(r*start,
r*start), lty = 2, lwd = 0.7)
vert=TRUE
start=r*start
}
}
#################################
}

# plot
exponential_growth_map(r=2,x_o=x_o, N=13)

####################################################################
##                                                                ##
##            Cobweb Plot, logistic growth  g^n(x)                ##
##            (Figure 1.2 p. 7)                                   ##
##                                                                ##

logistic_growth_map<-function(r=1,x_o=runif(1,0,1),N=20,burn_in=0,...)
{
par(mfrow=c(2,1),mar=c(4,4,1,2),lwd=1)
############# Trace #############
x<-array(dim=N)
x[1]<-x_o
for(i in 2:N)
x[i]<-r*x[i-1]*(1-x[i-1])
 
plot(x[(burn_in+1):N],type='l',xlab=paste(N, "iterations"),ylab='x',...)
#################################
 
##########  Quadradic Map ########
x<-seq(from=0,to=1,length.out=100)
x_np1<-array(dim=100)
for(i in 1:length(x))
x_np1[i]<-r*x[i]*(1-x[i])

plot(x,x_np1,type='l', lwd = 2, xlab=expression(x[t]),ylab=expression(x[t+1]))
text(.1,(.2*r),paste0("g(x)=",r,"x(1-x)"), cex = .75)
abline(0,1, lty = 1, lwd = 0.9)
 
start=x_o
vert=FALSE
lines(x=c(start,start),y=c(0,r*start*(1-start)), lty = 2, lwd = 0.7)
for(i in 1:(2*N))
{
if(vert)
{
lines(x=c(start,start),y=c(start,r*start*(1-start)), lty = 2, lwd = 0.7)
vert=FALSE
}
else
{
lines(x=c(start,
r*start*(1-start)),
y=c(r*start*(1-start),
r*start*(1-start)), lty = 2, lwd = 0.7)
vert=TRUE
start=r*start*(1-start)
}
}
#################################
}

# plot
logistic_growth_map(r=2,x_o=x_o, N=13)


####################################################################
##                                                                ##
##            Güney's example of a periodic point                 ##
##                                                                ##

# plot
logistic_growth_map(r=3.3,x_o=0.2, N=7)

# plot
logistic_growth_map(r=3.3,x_o=0.2, N=40)

####################################################################
##                                                                ##
##            raw data                                            ##
##                                                                ##

r=3.3
x_o=0.2
N=40

pp_x <- array(dim=N)
pp_x[1] <- x_o
for(i in 2:N)
pp_x[i]<-r*pp_x[i-1]*(1-pp_x[i-1])
pp_x <- format(pp_x, nsmall = 20)
iteration_no <- 0:(N-1)

data.frame(iteration_no, pp_x)

N=400

pp_x <- array(dim=N)
pp_x[1] <- x_o
for(i in 2:N)
pp_x[i]<-r*pp_x[i-1]*(1-pp_x[i-1])
pp_x <- format(pp_x, nsmall = 20)
iteration_no <- 0:(N-1)

tail(data.frame(iteration_no, pp_x))

####################################################################
##                                                                ##
##      COMPUTER EXPERIMENT 1.2 (Alligood and Sauer, 1996:16)     ##
##                                                                ##
# Write a computer program with the goal of redoing Table 1.2 for 
# the logistic map ga(x) = ax(1 - x), using a = 3.5. What 
# periodic behavior wins out in the long run? Try several 
# different initial conditions to explore the basin of the 
# attracting periodic behavior. Then try different values of 
# a < 3.57 and report your results.

EXPERIMENT12 <- function(r=3.3, x_o=.2, N=0, dec=20) {
    pp_x <- array(dim=N)
    pp_x[1] <- x_o
    for(i in 2:N)
    pp_x[i]<-r*pp_x[i-1]*(1-pp_x[i-1])
    iteration_no <- 0:(N-1)
    g_hat_n_x <- format(round(pp_x, dec), nsmall = dec)
    data.frame(iteration_no, g_hat_n_x)
 }
# EXPERIMENT12(r=3.3, x_o=0.5, N=14+1, dec=4)

a <- 3.3
iter <- 14+1
decimals <- 4

g_hat_020 <- EXPERIMENT12(r=a, x_o=0.2, N=iter, dec=decimals)
g_hat_050 <- EXPERIMENT12(r=a, x_o=0.5, N=iter, dec=decimals)
g_hat_095 <- EXPERIMENT12(r=a, x_o=0.95, N=iter, dec=decimals)

# redoing Table 1.2 
data.frame(n = g_hat_020[,1], gn02 = g_hat_020[,2], gn05 = g_hat_050[,2], gn095 = g_hat_095[,2])

# what hapens in a longer run

a <- 3.3
iter <- 1400+1
decimals <- 4

g_hat_020 <- EXPERIMENT12(r=a, x_o=0.2, N=iter, dec= decimals)
g_hat_050 <- EXPERIMENT12(r=a, x_o=0.5, N=iter, dec= decimals)
g_hat_095 <- EXPERIMENT12(r=a, x_o=0.95, N=iter, dec= decimals)

# tail of longer run 
tail(data.frame(n = g_hat_020[,1], gn02 = g_hat_020[,2], gn05 = g_hat_050[,2], gn095 = g_hat_095[,2]))
# all
# data.frame(n = g_hat_020[,1], gn02 = g_hat_020[,2], gn05 = g_hat_050[,2], gn095 = g_hat_095[,2])

# now with alternative a
a <- 3.9
iter <- 14+1

g_hat_020 <- EXPERIMENT12(r=a, x_o=0.20, N=iter, dec=4)
g_hat_050 <- EXPERIMENT12(r=a, x_o=0.50, N=iter, dec=4)
g_hat_095 <- EXPERIMENT12(r=a, x_o=0.95, N=iter, dec=4)
 
data.frame(n = g_hat_020[,1], gn02 = g_hat_020[,2], gn05 = g_hat_050[,2], gn095 = g_hat_095[,2])
