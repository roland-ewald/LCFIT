
# Estimating and forecasting mortality by single
# year of age for both sexes combined using the Lee-Carter method
# Tim Miller
# June 13, 2003


for.jrw <- cbind (seq(2002,2100),round(e0.forecast3[1:99],1),
                      round(e65.forecast3[1:99],1))


# Summary I can approximately match Mike's bx and kt values

postscript("e0.forecast2002.ps")
plot (seq(1950,2002),mike.e0,
      xlab="Year",ylab="e(0)",
main="Life expectancy at birth, fitted (1950-2002) and forecasted (2003-2100)",
 type="l",xlim=c(1950,2100),ylim=c(68,90))
lines (seq(2002,2100),e0.forecast3[1:99],lty=2)
lines (seq(2002,2100),e0.lo.forecast3[1:99],lty=2)
lines (seq(2002,2100),e0.hi.forecast3[1:99],lty=2)

plot (seq(1950,2002),kt.secondstage3,
            xlab="Year",ylab="e(0)",
main="Lee-Carter k(t) index, fitted (1950-2002) and forecasted (2003-2100)",
       type="l",xlim=c(1950,2100),ylim=c(-250,50))
lines (seq(2002,2100),kt.secondstage3[53]+kt.forecast3[1:99],lty=2)
lines (seq(2002,2100),kt.secondstage3[53]+kt.lo.forecast3[1:99],lty=2)
lines (seq(2002,2100),kt.secondstage3[53]+kt.hi.forecast3[1:99],lty=2)
dev.off()





postscript("mike.tim.ps")
plot (seq(1950,2002),mike.kt*sum(mike.bx[1:101]),
      type="l",xlab="Year",ylab="kt",
      main="Mike and Tim's secondstage kt values")
lines (seq(1950,2002),kt.secondstage3,lty=2,col=2,lwd=2)
legend (1950,-10,legend=c("Mike","Tim"),lty=c(1,2),col=c(1,2),lwd=c(1,2))

plot (seq(0,105),mike.bx/sum(mike.bx[1:101]),
      type="l",xlab="Year",ylab="bx",
      main="Mike and Tim's bx values")
lines (seq(0,100),test3$bx,lty=2,col=2,lwd=2)
legend (60,0.02,legend=c("Mike","Tim"),lty=c(1,2),col=c(1,2),lwd=c(1,2))

plot (seq(0,100),kt.drift3*test3$bx, type="l",
      xlab="Age",ylab="Annual decline",
      main="Projected and historical annual decline in ln(mx)")
lines (seq(0,100),bx.actual, lwd=2,lty=2,col=2)
legend (40,-.02,legend=c("Projected decline = bx*kt.drift",
                       "Historical decline = ln(mx,2002)-ln(mx,1950)/52"),
      lty=c(1,2),lwd=c(1,2),col=c(1,2))
dev.off()

postscript("mx.decline.ps")
plot (seq(0,100),kt.drift3*test3$bx, type="l",
      xlab="Age",ylab="Annual decline",
      main="Projected and historical annual decline in ln(mx)")
lines (seq(0,100),kt.drift1*test1$bx,lty=3)
lines (seq(0,100),bx.actual, lwd=2,lty=2,col=2)
legend (40,-.02,legend=c("Projected decline = bx*kt.drift, weighted svd",
             "Projected decline = bx*kt.drift, unweighted svd",
            "Historical decline = ln(mx,2002)-ln(mx,1950)/52"),
      lty=c(1,3,2),lwd=c(1,1,2),col=c(1,1,2))
dev.off()

postscript("mx.decline2.ps")
plot (seq(0,100),kt.drift3*test3$bx, type="l",
      xlab="Age",ylab="Annual decline",
      main="Projected and historical annual decline in ln(mx)")
lines (seq(0,100),kt.drift1*test1$bx,lty=3)
lines (seq(0,100),bx.actual, lwd=2,lty=2,col=2)
lines (seq(0,100),bx.regress,lwd=2,lty=1,col=2)
legend (40,-.02,legend=c("Projected decline = bx*kt.drift, weighted svd",
             "Projected decline = bx*kt.drift, unweighted svd",
            "Historical decline = ln(mx,2002)-ln(mx,1950)/52",
            "Historical decline = slope of ln(mx)"),
      lty=c(1,3,2,1),lwd=c(1,1,2,2),col=c(1,1,2,2))
dev.off()

postscript("mx.decline3.ps")
plot (seq(0,100),kt.drift3*test3$bx, type="l",
      xlab="Age",ylab="Annual decline",
      main="Projected and historical annual decline in ln(mx)")
lines (seq(0,100),kt.drift1*test1$bx,lty=3)
lines (seq(0,100),kt.drift4*test4$bx,lty=1,col=3,lwd=2)
lines (seq(0,100),bx.actual, lwd=2,lty=2,col=2)
lines (seq(0,100),bx.regress,lwd=2,lty=1,col=2)
legend (40,-.02,legend=c("Projected decline = bx*kt.drift, weighted svd",
                  "Projected decline: weighted svd, weights average dx",
             "Projected decline = bx*kt.drift, unweighted svd",
            "Historical decline = ln(mx,2002)-ln(mx,1950)/52",
            "Historical decline = slope of ln(mx)"),
      lty=c(1,1,3,2,1),lwd=c(1,2,1,2,2),col=c(1,3,1,2,2))
dev.off()

# historical decline defined as linear regression!

bx.regress <- rep(0,101)
for (cnt in 1:101){
  bx.regress[cnt] <- lm(log(mike.mx[,cnt]) ~ year)$coef[2]}



# Testing comparing first and secondstagekt
e0.hist1 <- rep(0,53)
e0.hist2 <- rep(0,53)
e0.hist3 <- rep(0,53)
for (cnt in 1:53){
e0.hist1[cnt] <- get.e0(nmx.from.kt(test1$kt[cnt],test1$ax,test1$bx))
e0.hist2[cnt] <- get.e0(nmx.from.kt(test2$kt[cnt],test2$ax,test2$bx))
e0.hist3[cnt] <- get.e0(nmx.from.kt(test3$kt[cnt],test3$ax,test3$bx))
                      }
# Testing comparing first and secondstagekt
e0.act1 <- rep(0,53)
e0.act2 <- rep(0,53)
e0.act3 <- rep(0,53)
for (cnt in 1:53){
e0.act1[cnt] <- get.e0(nmx.from.kt(kt.secondstage1[cnt],test1$ax,test1$bx))
e0.act2[cnt] <- get.e0(nmx.from.kt(kt.secondstage2[cnt],test2$ax,test2$bx))
e0.act3[cnt] <- get.e0(nmx.from.kt(kt.secondstage3[cnt],test3$ax,test3$bx))
                      }

#estimated mortality rates first and second stage from
#  1950-2002

est.mx.first1 <- matrix(0,53,101)
est.mx.second1 <- matrix(0,53,101)
est.mx.first3 <- matrix(0,53,101)
est.mx.second3 <- matrix(0,53,101)
for (cnt in 1:53){
  est.mx.first1[cnt,] <- nmx.from.kt(test1$kt[cnt],test1$ax,test1$bx)
  est.mx.first3[cnt,] <- nmx.from.kt(test3$kt[cnt],test3$ax,test3$bx)
  est.mx.second1[cnt,] <- nmx.from.kt(kt.secondstage1[cnt],test1$ax,test1$bx)
  est.mx.second3[cnt,] <- nmx.from.kt(kt.secondstage3[cnt],test3$ax,test3$bx)
}

graph <- function (cnt){
cnt <- cnt+1
  plot (seq(1950,2002),log(mike.mx[,cnt]),
      xlab="Year",ylab="ln",
   main=paste("ln(mx), Age ",cnt-1,", solid = firststage, dashed= second"))
lines (seq(1950,2002),log(est.mx.first3[,cnt]),lty=1)
lines (seq(1950,2002),log(est.mx.second3[,cnt]),lty=2)
}

graph2<- function (cnt){
cnt <- cnt+1
  plot (seq(1950,2002),log(mike.mx[,cnt]),
      xlab="Year",ylab="ln",
   main=paste("ln(mx), Age ",cnt-1,", solid = weighted, dashed = unweighted"))
lines (seq(1950,2002),log(est.mx.second3[,cnt]),lty=1)
lines (seq(1950,2002),log(est.mx.second1[,cnt]),lty=2)
}

postscript("ages.ps")
graph2(0)
graph2(10)
graph2(25)
graph2(35)
graph2(45)
graph2(55)
graph2(65)
graph2(75)
graph2(85)
graph2(95)
dev.off()


cnt <- 91
plot (seq(1950,2002),log(mike.mx[,cnt]),
      xlab="Year",ylab="ln",
   main=paste("ln(mx), Age ",cnt-1,", solid = firststage, dashed= second"))
lines (seq(1950,2002),log(est.mx.first3[,cnt]),lty=1)
lines (seq(1950,2002),log(est.mx.second3[,cnt]),lty=2)

dev.off()

postscript("e0.diff.ps")
plot(seq(1950,2002),e0.hist3-mike.e0,type="l",
     xlab="Year",ylab="Difference",ylim=c(-0.4,0.3),
     main = "First-stage Estimated e(0) - Actual e(0): 1950-2002")
lines (seq(1950,2002),e0.hist1-mike.e0,lty=2,col=2,lwd=2)
abline (h=0)
legend(1985,0.3,legend=c("Weighted SVD","Unweighted SVD"),
       col=c(1,2),lty=c(1,2),lwd=c(1,2))
dev.off()


# Examines effect of using weighted svd procedure and of using 

# Read in SSA pop data

ssapop <- read.csv("ssajulypop.csv",header=F)

# data for 1950 to 2002

ssa.pop <- matrix(0,53,101)
for (cnt in 1:53){
  x <- (cnt*101) +  809
  ssa.pop[cnt,] <- ssapop$V2[x:(x+100)]}


# read in mike's data

mike.mx <- as.matrix(read.table("mx.asc"))
mike.e0 <- scan("e0.asc")

# mike.mx is 53 years (1950-2002) by 101 ages (0 to 100)


estimate.leecarter <- function(nmx){
        # Use all ages of nmx
	log.nmx <- log(nmx)
	ax <- apply(log.nmx, 2, mean)
	swept.mx <- sweep(log.nmx, 2, ax)
	svd.mx <- svd(swept.mx)
	bx <- svd.mx$v[, 1]/sum(svd.mx$v[, 1])
	kt <- svd.mx$d[1] * svd.mx$u[, 1] * sum(svd.mx$v[, 1])
	result <- list(ax = ax, bx = bx, kt = kt)
	return(result)
}

model <- estimate.leecarter(mike.mx)


lifetable.1mx <- function(nmx){
        n <- 1
	len.m <- length(nmx) - 1
	age <- seq(0, len.m)
        a0 <- .125
	nax <- c(a0, rep(0.5, len.m) )
        nqx <- (n * nmx)/(1 + ((n-nax) * nmx))
	nqx[nqx > 1] <- 1
        lx<- c(1,cumprod(1-nqx[1:len.m]))
	ndx <- -diff(c(lx,0))
        nLx <- (lx * n) - (ndx * (n - nax))
        nLx[length(nmx)] <- lx[length(nmx)]/nmx[length(nmx)]
	Tx <- rev(cumsum(rev(nLx)))
	ex <- Tx/lx
	result <- data.frame(age = age, nqx = nqx, lx = lx, ndx = ndx,
                nLx = nLx, Tx = Tx, ex = ex)
	return(result)
}


get.e0 <- function(x) {return(lifetable.1mx(x)$ex[1])}


get.e65 <- function(x) {return(lifetable.1mx(x)$ex[66])}

nmx.from.kt <- function (kt,ax,bx){
        # Derives mortality rates from kt mortality index, 
        #   per Lee-Carter method
	nmx  <- exp((bx * kt) + ax)
        nmx[nmx>1] <- 1
        nmx[nmx==0] <- 1
        return(nmx)}


iterative.kt <- function (e0,ax,bx){
# Given e(0), search for mortality index k(t)
        step.size <- 20
        guess.kt <- 0
        last.guess <- c("high")
        how.close <- 5
        while(abs(how.close)>.0001){
        nmx <- nmx.from.kt(guess.kt,ax,bx)
	guess.e0 <- get.e0(nmx)
        how.close <- e0 - guess.e0
        if (how.close>0){
        # our guess is too low and must decrease kt
          if (last.guess==c("low")) {step.size <- step.size/2}
          guess.kt <- guess.kt - step.size
          last.guess<- c("high")}
        if (how.close<0){
        # our guess is too high and must increase kt
          if (last.guess==c("high")) {step.size <- step.size/2}
          guess.kt <- guess.kt + step.size
          last.guess <- c("low")}
      }
        return (guess.kt)}


end.year <- 2002
start.year <- 1950
len.series <- end.year - start.year + 1
kt.secondstage <- rep(0,len.series)
for (cnt in 1:len.series){
  kt.secondstage[cnt] <- iterative.kt(mike.e0[cnt],
    model$ax,model$bx)}



# Step 3, Time series estimation of kt as (0,1,0)

kt.diff <- diff(kt.secondstage)
model.kt <- summary(lm(kt.diff ~ 1  ))
kt.drift <- model.kt$coefficients[1,1]
sec <- model.kt$coefficients[1,2]
see <- model.kt$sigma
mort.finalyear <- mike.mx[53,]

# Note using kt.initial since there is a small (0.1 year) difference
# between my life table method and that used by mike

kt.initial <- iterative.kt(mike.e0[53],
                           log(mort.finalyear),
                           model$bx)


x <- seq(0,122)
kt.stderr <- ( (x*see^2) + (x*sec)^2 )^.5
kt.forecast <- kt.initial + (x * kt.drift)
kt.lo.forecast <- kt.forecast + (1.96*kt.stderr)
kt.hi.forecast <- kt.forecast - (1.96*kt.stderr)
# This gives 95% prob interval
# For 90%, us 1.645.

e0.forecast <- rep(0,122)
e0.lo.forecast <- rep(0,122)
e0.hi.forecast <- rep(0,122)
for (cnt in 1:122){
e0.forecast[cnt] <-
    get.e0(nmx.from.kt(kt.forecast[cnt],
     log(mort.finalyear), model$bx))
e0.lo.forecast[cnt] <-
    get.e0(nmx.from.kt(kt.lo.forecast[cnt],
     log(mort.finalyear), model$bx))
e0.hi.forecast[cnt] <-
    get.e0(nmx.from.kt(kt.hi.forecast[cnt],
     log(mort.finalyear), model$bx))
}


e0.forecast.male <- rep(0,122)
e0.forecast.female <- rep(0,122)
for (cnt in 1:122){
e0.forecast.male[cnt] <-
    get.e0(nmx.from.kt(kt.forecast[cnt],
     mike.ax.male[1:101], model$bx))
e0.forecast.female[cnt] <-
    get.e0(nmx.from.kt(kt.forecast[cnt],
     mike.ax.female[1:101], model$bx))}
e0.forecast.both <- ((1.05/2.05)*e0.forecast.male)+
                   ((1.00/2.05)*e0.forecast.female)


e0.forecast.male <- rep(0,122)
e0.forecast.female <- rep(0,122)
for (cnt in 1:122){
e0.forecast.male[cnt] <-
    get.e0(nmx.from.kt(kt.forecast[cnt],
     mike.ax.male[1:101], mike.bx[1:101]))
e0.forecast.female[cnt] <-
    get.e0(nmx.from.kt(kt.forecast[cnt],
     mike.ax.female[1:101], mike.bx[1:101]))}
e0.forecast.mike <- ((1.05/2.05)*e0.forecast.male)+
                   ((1.00/2.05)*e0.forecast.female)



write(model$ax, "model.ax")
write(model$bx, "model.bx")
write(model$kt, "model.kt")
write(kt.secondstage, "k.secondstage")
write(kt.secondstage, "k.secondstage")

write.table(kt.secondstage,"")


lifetable.mike <- function (nmx){
 lx <- rep (0,106)
 nLx <- lx
 lx[1] <- 1
 lx[2] <- (lx[1] - .125*lx[1]*nmx[1])/(.875*nmx[1] +1)
 nLx[1]<- .125*lx[1] + .875*lx[2]
 for (i1 in 3:101) {
   lx[i1] <- (2*lx[i1-1] - nmx[i1-1]*lx[i1-1])/(2 + nmx[i1-1])
   nLx[i1-1]<-  0.5*(lx[i1-1]+lx[i1])}
 nLx[101] <- lx[101]/nmx[101]
 e0 <- sum(nLx)
 

 ndx <- -diff(c(lx,0))
        nLx <- (lx * n) - (ndx * (n - nax))
        nLx[length(nmx)] <- lx[length(nmx)]/nmx[length(nmx)]
	Tx <- rev(cumsum(rev(nLx)))
	ex <- Tx/lx
	result <- data.frame(age = age, nqx = nqx, lx = lx, ndx = ndx,
                nLx = nLx, Tx = Tx, ex = ex)
	return(result)


      

# Read in ssa data for males in 2100

ssa.male2100 <- read.table("male.csv",header=F,sep=",")


sumr_function(x) apply(x,1,sum)
sumc_function(x) apply(x,2,sum)
meanr_function(x) apply(x,1,mean)
meanc_function(x) apply(x,2,mean)

wsvd_function(y,w,p=svd(y)$u[,1],q=svd(y)$v[,1],tol=1e-4)
  {
    param.old_-1
    while (max(abs(c(p,q)-param.old))>tol) {
      param.old_c(p,q)
      p_((w*y)%*%q)/(w%*%q^2)
      p_p/sqrt(sum(p^2))
      q_t((t(p)%*%(w*y))/(t(p^2)%*%w))
      q_q/sqrt(sum(q^2))
    }
    d_(t(p)%*%(w*y)%*%q)/(t(p^2)%*%w%*%q^2)
    list(d=c(d),p=c(p),q=c(q))
  }

lc.wsvd_function(y,w=matrix(1,nrow(y),ncol(y)),tol=1e-4)
  {
      #y_ifelse(m==0,99,log(m)), note that I pass
      #the log(m) matrix instead of m
    a_b_rep(0,nrow(y))
    k_rep(0,ncol(y))
    param.old_rep(-1, 2*nrow(y)+ncol(y))
    n_1
    while (max(abs(c(a,b,k)-param.old))>tol) {
      param.old_c(a,b,k)    
      a_sumr(w*(y-b%*%t(k)))/sumr(w)
      z_if (n==1) wsvd(y-matrix(a,nrow(y),ncol(y)),w,tol=tol) else
         wsvd(y-matrix(a,nrow(y),ncol(y)),w,b,k/sqrt(sum(k^2)),tol=tol)
      b_z$p
      k_z$d*z$q
      n_n+1
    }
    a_a+mean(k)*b
    k_k-mean(k)
    #normalize b
    norm <- sum(b)
    b <- b/norm
    k <- k*norm
    list(ax=c(a),bx=c(b),kt=c(k))
  }

lc.wsvd2_function(y,w=matrix(1,nrow(y),ncol(y)),tol=1e-4)
  {
      #y_ifelse(m==0,99,log(m)), note that I pass
      #the log(m) matrix instead of m
    a_b_rep(0,nrow(y))
    k_rep(0,ncol(y))
    param.old_rep(-1, 2*nrow(y)+ncol(y))
    n_1
    while (max(abs(c(a,b,k)-param.old))>tol) {
      param.old_c(a,b,k)    
      a_sumr(w*(y-b%*%t(k)))/sumr(w)
      z_if (n==1) wsvd(y-matrix(a,nrow(y),ncol(y)),w,tol=tol) else
         wsvd(y-matrix(a,nrow(y),ncol(y)),w,b,k/sqrt(sum(k^2)),tol=tol)
      b_z$p
      k_z$d*z$q
      n_n+1
    }
    a_a+mean(k)*b
    k_k-mean(k)
       list(ax=c(a),bx=c(b),kt=c(k))
  }

 mike.dx2 <- round(mike.mx*ssa.pop)

 mike.dx3 <- mike.dx2
 for (cnt in 1:101){
   mike.dx3[,cnt] <- mean(mike.dx2[,cnt])}
 
 
 test1 <- lc.wsvd(t(log(mike.mx)))
 test2 <- lc.wsvd(t(log(mike.mx)),t(mike.dx))
 test3 <- lc.wsvd(t(log(mike.mx)),t(mike.dx2))
 test4 <- lc.wsvd(t(log(mike.mx)),t(mike.dx3))

# second stage kt's:

end.year <- 2002
start.year <- 1950
len.series <- end.year - start.year + 1
kt.secondstage1 <- rep(0,len.series)
for (cnt in 1:len.series){
  kt.secondstage1[cnt] <- iterative.kt(mike.e0[cnt],
    test1$ax,test1$bx)}

end.year <- 2002
start.year <- 1950
len.series <- end.year - start.year + 1
kt.secondstage2 <- rep(0,len.series)
for (cnt in 1:len.series){
  kt.secondstage2[cnt] <- iterative.kt(mike.e0[cnt],
    test2$ax,test2$bx)}

 end.year <- 2002
start.year <- 1950
len.series <- end.year - start.year + 1
kt.secondstage3 <- rep(0,len.series)
for (cnt in 1:len.series){
  kt.secondstage3[cnt] <- iterative.kt(mike.e0[cnt],
    test3$ax,test3$bx)}

 end.year <- 2002
start.year <- 1950
len.series <- end.year - start.year + 1
kt.secondstage4 <- rep(0,len.series)
for (cnt in 1:len.series){
  kt.secondstage4[cnt] <- iterative.kt(mike.e0[cnt],
    test4$ax,test4$bx)}

 
kt.diff1 <- diff(kt.secondstage1)
model.kt1 <- summary(lm(kt.diff1 ~ 1  ))
kt.drift1 <- model.kt1$coefficients[1,1]
sec1 <- model.kt1$coefficients[1,2]
see1 <- model.kt1$sigma
mort.finalyear <- mike.mx[53,]

kt.diff2 <- diff(kt.secondstage2)
model.kt2 <- summary(lm(kt.diff2 ~ 1  ))
kt.drift2 <- model.kt2$coefficients[1,1]
sec2 <- model.kt2$coefficients[1,2]
see2 <- model.kt2$sigma
mort.finalyear <- mike.mx[53,]

 kt.diff3 <- diff(kt.secondstage3)
model.kt3 <- summary(lm(kt.diff3 ~ 1  ))
kt.drift3 <- model.kt3$coefficients[1,1]
sec3 <- model.kt3$coefficients[1,2]
see3 <- model.kt3$sigma
mort.finalyear <- mike.mx[53,]

  kt.diff4 <- diff(kt.secondstage4)
model.kt4 <- summary(lm(kt.diff4 ~ 1  ))
kt.drift4 <- model.kt4$coefficients[1,1]
sec4 <- model.kt4$coefficients[1,2]
see4 <- model.kt4$sigma
mort.finalyear <- mike.mx[53,]

 
x <- seq(0,122)
kt.stderr1 <- ( (x*see1^2) + (x*sec1)^2 )^.5
kt.forecast1 <- 0 + (x * kt.drift1)
kt.lo.forecast1 <- kt.forecast1 + (1.96*kt.stderr1)
kt.hi.forecast1 <- kt.forecast1 - (1.96*kt.stderr1)
# This gives 95% prob interval

x <- seq(0,122)
kt.stderr2 <- ( (x*see2^2) + (x*sec2)^2 )^.5
kt.forecast2 <- 0 + (x * kt.drift2)
kt.lo.forecast2 <- kt.forecast2 + (1.96*kt.stderr2)
kt.hi.forecast2 <- kt.forecast2 - (1.96*kt.stderr2)
# This gives 95% prob interval

 x <- seq(0,122)
kt.stderr3 <- ( (x*see3^2) + (x*sec3)^2 )^.5
kt.forecast3 <- 0 + (x * kt.drift3)
kt.lo.forecast3 <- kt.forecast3 + (1.96*kt.stderr3)
kt.hi.forecast3 <- kt.forecast3 - (1.96*kt.stderr3)
# This gives 95% prob interval

e0.forecast1 <- rep(0,122)
e0.lo.forecast1 <- rep(0,122)
e0.hi.forecast1 <- rep(0,122)
for (cnt in 1:122){
e0.forecast1[cnt] <-
    get.e0(nmx.from.kt(kt.forecast1[cnt],
     log(mort.finalyear), test1$bx))
e0.lo.forecast1[cnt] <-
    get.e0(nmx.from.kt(kt.lo.forecast1[cnt],
     log(mort.finalyear), test1$bx))
e0.hi.forecast1[cnt] <-
    get.e0(nmx.from.kt(kt.hi.forecast1[cnt],
     log(mort.finalyear), test1$bx))
}


e0.forecast2 <- rep(0,122)
e0.lo.forecast2 <- rep(0,122)
e0.hi.forecast2 <- rep(0,122)
for (cnt in 1:122){
e0.forecast2[cnt] <-
    get.e0(nmx.from.kt(kt.forecast2[cnt],
     log(mort.finalyear), test2$bx))
e0.lo.forecast2[cnt] <-
    get.e0(nmx.from.kt(kt.lo.forecast2[cnt],
     log(mort.finalyear), test2$bx))
e0.hi.forecast2[cnt] <-
    get.e0(nmx.from.kt(kt.hi.forecast2[cnt],
     log(mort.finalyear), test2$bx))
}

 e0.forecast3 <- rep(0,122)
e0.lo.forecast3 <- rep(0,122)
e0.hi.forecast3 <- rep(0,122)
for (cnt in 1:122){
e0.forecast3[cnt] <-
    get.e0(nmx.from.kt(kt.forecast3[cnt],
     log(mort.finalyear), test3$bx))
e0.lo.forecast3[cnt] <-
    get.e0(nmx.from.kt(kt.lo.forecast3[cnt],
     log(mort.finalyear), test3$bx))
e0.hi.forecast3[cnt] <-
    get.e0(nmx.from.kt(kt.hi.forecast3[cnt],
     log(mort.finalyear), test3$bx))
}


e65.forecast3 <- rep(0,122)
e65.lo.forecast3 <- rep(0,122)
e65.hi.forecast3 <- rep(0,122)
for (cnt in 1:122){
e65.forecast3[cnt] <-
    get.e65(nmx.from.kt(kt.forecast3[cnt],
     log(mort.finalyear), test3$bx))
e65.lo.forecast3[cnt] <-
    get.e65(nmx.from.kt(kt.lo.forecast3[cnt],
     log(mort.finalyear), test3$bx))
e65.hi.forecast3[cnt] <-
    get.e65(nmx.from.kt(kt.hi.forecast3[cnt],
     log(mort.finalyear), test3$bx))
}


 

plot (test1$bx*kt.drift1)
 

 

# So, almost no difference in e(0) using wieghted vs unweighted

 ## Let's look at sex-specific forecasts


 e0.male.forecast1 <- rep(0,122)
 e0.female.forecast1 <- rep(0,122)
 for (cnt in 1:122){
   e0.male.forecast1[cnt] <-
    get.e0(nmx.from.kt(kt.forecast1[cnt],
     log(mx2002.male.ssa), test1$bx))
   e0.female.forecast1[cnt] <-
    get.e0(nmx.from.kt(kt.forecast1[cnt],
     log(mx2002.female.ssa), test1$bx))}
 e0.both.forecast1 <- ((105/205)*e0.male.forecast1)+
                      ((100/205)*e0.female.forecast1)

 
 e0.male.forecast2 <- rep(0,122)
 e0.female.forecast2 <- rep(0,122)
 for (cnt in 1:122){
   e0.male.forecast2[cnt] <-
    get.e0(nmx.from.kt(kt.forecast2[cnt],
     log(mx2002.male.ssa), test2$bx))
   e0.female.forecast2[cnt] <-
    get.e0(nmx.from.kt(kt.forecast2[cnt],
     log(mx2002.female.ssa), test2$bx))}
 e0.both.forecast2 <- ((105/205)*e0.male.forecast2)+
                      ((100/205)*e0.female.forecast2)


 e0.male.forecast3 <- rep(0,122)
 e0.female.forecast3 <- rep(0,122)
 for (cnt in 1:122){
   e0.male.forecast3[cnt] <-
    get.e0(nmx.from.kt(kt.forecast3[cnt],
     log(mx2002.male.ssa), test3$bx))
   e0.female.forecast3[cnt] <-
    get.e0(nmx.from.kt(kt.forecast3[cnt],
     log(mx2002.female.ssa), test3$bx))}
 e0.both.forecast3 <- ((105/205)*e0.male.forecast3)+
                      ((100/205)*e0.female.forecast3)


 
#  Develop weights based on life table deaths??

 mike.dx <- matrix(0,53,101)
 for (cnt in 1:53){
   mike.dx[cnt,] <- 100000*
   lifetable.1mx(mike.mx[cnt,])$ndx}
 
 

 
# Comparing Mike and My Value


 mike.kt <- scan("kt.asc")
 mike.ax.male <- scan("malax.asc")
 mike.ax.female <- scan("femax.asc")
 mike.bx <- scan("bx.asc")

bx.actual <- (log(mike.mx[53,]) - log(mike.mx[1,]))/52


# testing

lc.wsvd(t(log(mike.mx)))


 mx2002.male.ssa <- scan("ssa2002.male.txt")
 mx2002.female.ssa <- scan("ssa2002.female.txt")

 
 

 
postscript("mike.bx.ps")
 plot (seq(0,105),mike.bx*(-1.169302),
       main="bx *kt.drift",type="l",xlab="Age",ylab="bx*kt.drift")
 lines (seq(0,100),model$bx*(-1.153846),lty=2)
 text(20,-.025,
      "Tim (unweighted SVD) estimates faster mortality decline",adj=0)

 
 











 


        # Use modified Coale-Guo for mortality above age 85 
        nmx.part2 <- rep(0,26)
        m83 <- nmx.part1[84]
        m84 <- nmx.part1[85]
        #Set 1m105 based on 1m84 (.421 = average value for last 20 years)
        m105 <- 0.421 + m84
        k84 <- log(m84/m83)
        R <- - ( log(m83/m105) + ((105-83)*k84) ) / (sum(1:(105-84)))
        x <- seq(85,110)
        nmx.part2 <- m83 * exp ( ((x-83)*k84) + (R*cumsum(1:(x[26]-84))) )
	nmx <- c(nmx.part1, nmx.part2)
        
        return(nmx)}












# Step 00: Create functions

# Life table derives from mortality rates


estimate.leecarter <- function(nmx){
        # Use only mortality below age 85
	nmx <- nmx[, 1:85]
	log.nmx <- log(nmx)
	ax <- apply(log.nmx, 2, mean)
	swept.mx <- sweep(log.nmx, 2, ax)
	svd.mx <- svd(swept.mx)
	bx <- svd.mx$v[, 1]/sum(svd.mx$v[, 1])
	kt <- svd.mx$d[1] * svd.mx$u[, 1] * sum(svd.mx$v[, 1])
	result <- list(ax = ax, bx = bx, kt = kt)
	return(result)
}

nmx.from.kt <- function (kt,ax,bx){
        # Derives mortality rates from kt mortality index, 
        #   per Lee-Carter method
	nmx.part1 <- exp((bx[1:85] * kt) + ax[1:85])
        # Use modified Coale-Guo for mortality above age 85 
        nmx.part2 <- rep(0,26)
        m83 <- nmx.part1[84]
        m84 <- nmx.part1[85]
        #Set 1m105 based on 1m84 (.421 = average value for last 20 years)
        m105 <- 0.421 + m84
        k84 <- log(m84/m83)
        R <- - ( log(m83/m105) + ((105-83)*k84) ) / (sum(1:(105-84)))
        x <- seq(85,110)
        nmx.part2 <- m83 * exp ( ((x-83)*k84) + (R*cumsum(1:(x[26]-84))) )
	nmx <- c(nmx.part1, nmx.part2)
        nmx[nmx>1] <- 1
        nmx[nmx==0] <- 1
        return(nmx)}


# Step 0:  Get the data

# From Berkeley Mortality Database read in mortality data
# by single year of age 0 to 119 from 1900 to 1995
us.mx.1900.1995 <- read.table("mx.1x1",header=T)
matrix.mx.1900.1995 <- matrix(0,96,120)
for (cnt in 1:96) {
year <- 1899+cnt
matrix.mx.1900.1995[cnt,] <- us.mx.1900.1995$Total[us.mx.1900.1995$Year==year]}
dimnames (matrix.mx.1900.1995) <- list(seq(1900,1995),
  seq(0,119))

# Add in latest data from SSA.  The data for 1996,1997,and 1998
# are final versions as used in the 2001 Trustees Report.
# ALSO USE THE 1999 PRELIMINARY DATA!
matrix.mx.1900.1999<- rbind(matrix.mx.1900.1995,
              ssa.1996$combined$mx,
              ssa.1997$combined$mx,
              ssa.1998$combined$mx,
              ssa.1999$combined$mx)
dimnames (matrix.mx.1900.1999) <- list(seq(1900,1999),
  seq(0,119))


# Get Life Tables for 1900 to 1995 by 1 year age group
#  from the Berkeley Mortality Database.
combined.ltab <- read.table("lee1/historical.usa/utper.lt.1x1",header=T)
# ex matrix
ex.matrix.1900.1999 <- matrix(0,100,120)
for (cnt in 1:96){
year <- 1899+cnt
ex.matrix.1900.1999[cnt,] <- combined.ltab$ex[combined.ltab$Year==year]}
ex.matrix.1900.1999[97,] <- ssa.1996$combined$ex
ex.matrix.1900.1999[98,] <- ssa.1997$combined$ex
ex.matrix.1900.1999[99,] <- ssa.1998$combined$ex
ex.matrix.1900.1999[100,] <- ssa.1999$combined$ex
dimnames (ex.matrix.1900.1999) <- list(seq(1900,1999),
  seq(0,119))


# Test life table function
test.e0.1900.1999 <- apply(matrix.mx.1900.1999,1,get.e0)
# This graph shows that the life table function returns the correct e(0)
# values.
plot (test.e0.1900.1999)
lines (ex.matrix.1900.1999[,1])

# There appears to be a significant difference between CDC and SSA estimate's
# of life expectancy.  Since I am using SSA mortality data for the estimation,
# I will also use SSA e(0) estimates.  

# Read in CDC data on e0
# Sources: 1900 to 1997, Table 12
# National Vital Statistics Report, Vol. 47, No. 28, December 13, 1999
# 1998: Table 6,
#National Vital Statistics Reports, Vol. 48, No. 11, July 24, 2000
e0.cdc <- read.table ("lee1/historical.usa/cdc.e0", header=F)
names (e0.cdc) <- c("year","both","male","female",
                    "white.both","white.male","white.female",
                    "black.both","black.male","black.female")
e0.1900.1998.cdc <- rev(e0.cdc$both)
plot (e0.cdc$year[e0.cdc$year>1949],e0.cdc$both[e0.cdc$year>1949],
      xlab="Year",ylab="e(0)",
      main="Estimates of life expectancy at birth: CDC and SSA")
lines (seq(1900,1999)[51:100],ex.matrix.1900.1999[51:100,1])
legend (1985,71,legend=c("CDC","SSA"),lty=c(-1,1),mark=c(1,-1))

# Step 1: Estimate Lee-Carter on the data set

model <- estimate.leecarter(matrix.mx.1900.1999[51:100,])

#Step 2:  Estimate second-stage kt from e0

end.year <- 1999
start.year <- 1950
len.series <- end.year - start.year + 1
kt.secondstage <- rep(0,len.series)
for (cnt in 1:len.series){
  kt.secondstage[cnt] <- iterative.kt(ex.matrix.1900.1999[(50+cnt),1],
    model$ax,model$bx)}


# Step 3, Time series estimation of kt as (0,1,0)

kt.diff <- diff(kt.secondstage)
model.kt <- summary(lm(kt.diff ~ 1  ))
kt.drift <- model.kt$coefficients[1,1]
sec <- model.kt$coefficients[1,2]
see <- model.kt$sigma

# Step 4: Forecast of kt and e(0) for 122 years
# Use mortality in last year (1999) as ax values
# for the forecast. 
mort.finalyear <- matrix.mx.1900.1999[100,]

# Set initial kt for 1999 (should be nearly zero)
kt.initial <- iterative.kt(ex.matrix.1900.1999[100,1],
    log(mort.finalyear[1:85]),model$bx)
kt.initial.male <- iterative.kt(ssa.1999$male$ex[1],
    log(ssa.1999$male$mx[1:85]),model$bx)
kt.initial.female <- iterative.kt(ssa.1999$female$ex[1],
    log(ssa.1999$female$mx[1:85]),model$bx)

x <- seq(0,122)
kt.stderr <- ( (x*see^2) + (x*sec)^2 )^.5
kt.forecast <- kt.initial + (x * kt.drift)
kt.lo.forecast <- kt.forecast + (1.96*kt.stderr)
kt.hi.forecast <- kt.forecast - (1.96*kt.stderr)
# This gives 95% prob interval
# For 90%, us 1.645.

e0.forecast <- rep(0,122)
e0.lo.forecast <- rep(0,122)
e0.hi.forecast <- rep(0,122)
for (cnt in 1:122){
e0.forecast[cnt] <-
    get.e0(nmx.from.lc(kt.forecast[cnt],
     log(mort.finalyear[1:85]), model$bx))
e0.lo.forecast[cnt] <-
    get.e0(nmx.from.lc(kt.lo.forecast[cnt],
     log(mort.finalyear[1:85]), model$bx))
e0.hi.forecast[cnt] <-
    get.e0(nmx.from.lc(kt.hi.forecast[cnt],
     log(mort.finalyear[1:85]), model$bx))
}

# Forecast mortality of each sex.  I assume bx and rate of drift of
# kt are the same for both sexes.  Ax values and the starting value
# (and subsequent values) of kt mortality index are unique for each sex.
e0.male.forecast <- rep(0,122)
e0.female.forecast <- rep(0,122)
for (cnt in 1:122){
e0.male.forecast[cnt] <-
    get.e0(nmx.from.lc(kt.initial.male-kt.forecast[1]+kt.forecast[cnt],
     log(ssa.1999$male$mx[1:85]), model$bx))
e0.female.forecast[cnt] <-
    get.e0(nmx.from.lc(kt.initial.female-kt.forecast[1]+kt.forecast[cnt],
     log(ssa.1999$female$mx[1:85]), model$bx))
}

# Test to see how closely the two-sex forecast matches the unisex forecast
# This graph shows these forecasts are extremely close to each other.
# The two-sex model shows slightly lower e(0) throughout.  By 2075,
# there is a difference of 0.2 years with the unisex forecast at 85.2 and
# the two-sex forecast at 85.0.
plot (seq(1999,2120),e0.forecast)
lines (seq(1999,2120), ((105/205)*e0.male.forecast) +
                       ((100/205)*e0.female.forecast))
e0.combined.forecast <- ((105/205)*e0.male.forecast) +
                       ((100/205)*e0.female.forecast)

e0.forecast[c(1999,2075)-1998]
e0.combined.forecast[c(1999,2075)-1998]
e0.lo.forecast[c(1999,2075)-1998]
e0.hi.forecast[c(1999,2075)-1998]

# In 2075, e(0) 95% prob interval = 81.2 to 88.4
# with median value of 84.9
# Compare to SSA 
((105/205)*c(77.4,80.9,85.2)) +
((100/205)*c(81.7,85.0,89.0))
#[1] 79.5 82.9 87.1

# write out ax, bx, kt.forecast, e0.forecasts,
#sec, see, kt.drift
#> kt.drift
#[1] -1.029377
#> sec
#[1] 0.1951575
#> see
#[1] 1.366102

#> kt.initial
#[1] 0.2001953
#> kt.initial.male
#[1] 0
#> kt.initial.female
#[1] 0.546875

mort.parameters <- cbind (log(ssa.1999$combined$mx[1:85]),
                          log(ssa.1999$male$mx[1:85]),
                          log(ssa.1999$female$mx[1:85]),
                          model$bx)
e0.1999.2120 <- round(cbind(e0.forecast,e0.lo.forecast,e0.hi.forecast),3)

write.table (round(mort.parameters,5),"mort.parameters",sep=",")
write.table (e0.1999.2120,"e0.1999.2120",sep=",")


# Based on CDC life expectancy data
kt.secondstage.cdc <- rep(0,(1998-1950+1))
for (cnt in 1:(1998-1950+1)){
  kt.secondstage.cdc[cnt] <- iterative.kt(e0.1900.1998.cdc[(50+cnt)],
    model$ax,model$bx)}

kt.diff.cdc <- diff(kt.secondstage.cdc)
model.kt.cdc <- summary(lm(kt.diff.cdc ~ 1  ))
kt.drift.cdc <- model.kt.cdc$coefficients[1,1]
sec.cdc <- model.kt.cdc$coefficients[1,2]
see.cdc <- model.kt.cdc$sigma

# Use SSA mortality from 1998 adjust to cdc e(0) level
mort.finalyear.cdc <- matrix.mx.1900.1999[99,]

# Set initial kt for 1998
kt.initial.cdc <- iterative.kt(e0.cdc$both[1],
    log(mort.finalyear.cdc[1:85]),model$bx)
kt.initial.male.cdc <- iterative.kt(e0.cdc$male[1],
    log(ssa.1998$male$mx[1:85]),model$bx)
kt.initial.female.cdc <- iterative.kt(e0.cdc$female[1],
    log(ssa.1998$female$mx[1:85]),model$bx)

x <- seq(0,122)
kt.stderr.cdc <- ( (x*see.cdc^2) + (x*sec.cdc)^2 )^.5
kt.forecast.cdc <- kt.initial.cdc + (x * kt.drift.cdc)
kt.lo.forecast.cdc <- kt.forecast.cdc + (1.96*kt.stderr.cdc)
kt.hi.forecast.cdc <- kt.forecast.cdc - (1.96*kt.stderr.cdc)
# This gives 95% prob interval
# For 90%, us 1.645.

e0.forecast.cdc <- rep(0,123)
e0.lo.forecast.cdc <- rep(0,123)
e0.hi.forecast.cdc <- rep(0,123)
for (cnt in 1:123){
e0.forecast.cdc[cnt] <-
    get.e0(nmx.from.lc(kt.forecast.cdc[cnt],
     log(mort.finalyear.cdc[1:85]), model$bx))
e0.lo.forecast.cdc[cnt] <-
    get.e0(nmx.from.lc(kt.lo.forecast.cdc[cnt],
     log(mort.finalyear.cdc[1:85]), model$bx))
e0.hi.forecast.cdc[cnt] <-
    get.e0(nmx.from.lc(kt.hi.forecast.cdc[cnt],
     log(mort.finalyear.cdc[1:85]), model$bx))
}


plot (e0.cdc$year[e0.cdc$year>1949],e0.cdc$both[e0.cdc$year>1949],
      xlab="Year",ylab="e(0)",
      main="Estimates of life expectancy at birth: CDC and SSA")
lines (seq(1900,1999)[51:100],ex.matrix.1900.1999[51:100,1])
legend (1985,71,legend=c("CDC","SSA"),lty=c(-1,1),mark=c(1,-1))

plot (seq(1998,2080),e0.forecast.cdc[1:83],
      xlab="Year",
      ylab="e(0)",
      main="E(0) forecasts based on kt derived from CDC and SSA")
lines (seq(1999,2080),e0.forecast[1:82])
legend (2060,80,legend=c("CDC","SSA"),lty=c(-1,1),mark=c(1,-1))

plot (seq(1999,2080),e0.forecast.cdc[2:83]-e0.forecast[1:82],
      xlab="Year",
      ylab="e(0) difference",
      main="Difference in E(0) forecasts based on kt derived from CDC and SSA")

plot (e0.cdc$year,e0.cdc$both,
      xlab="Year",ylim=c(40,90),xlim=c(1900,2080),
      ylab="e(0)",
      main="Life expectancy: 1900-2080, LC using CDC data",type="l")
lines (seq(1998,2080),e0.forecast.cdc[1:83])
lines (seq(1998,2080),e0.lo.forecast.cdc[1:83])
lines (seq(1998,2080),e0.hi.forecast.cdc[1:83])

plot (seq(1900,1999),ex.matrix.1900.1999[,1],
      xlab="Year",ylim=c(40,90),xlim=c(1900,2080),
      ylab="e(0)",
      main="Life expectancy: 1900-2080, LC using SSA data",type="l")
lines (seq(1999,2080),e0.forecast[1:82])
lines (seq(1999,2080),e0.lo.forecast[1:82])
lines (seq(1999,2080),e0.hi.forecast[1:82])

plot (seq(1998,2080),e0.forecast.cdc[1:83],
      xlab="Year",ylim=c(76,90),xlim=c(1998,2080),
      ylab="e(0)",
      main="Life expectancy: 1998-2080",type="l")
lines (seq(1998,2080),e0.lo.forecast.cdc[1:83])
lines (seq(1998,2080),e0.hi.forecast.cdc[1:83])
lines (seq(1999,2080),e0.forecast[1:82],lty=2)
lines (seq(1999,2080),e0.lo.forecast[1:82],lty=2)
lines (seq(1999,2080),e0.hi.forecast[1:82],lty=2)
points (ssa.tableva3.highcost$year,ssa.tableva3.highcost$e0.both)
points (ssa.tableva3.lowcost$year,ssa.tableva3.lowcost$e0.both)
points (ssa.tableva3.midcost$year,ssa.tableva3.midcost$e0.both)
legend (2000,89,legend=c("LC using CDC e(0)", "LC using SSA e(0)",
                         "SSA forecast"),
        lty=c(1,2,-1),marks=c(-1,-1,1))

# WRITE OUT ax, bx, kt values for forecasts

test3$bx
kt.drift3
sec3
see3

> test3$bx
  [1] 0.027149961 0.024959113 0.022309538 0.022351153 0.022732252 0.022163718
  [7] 0.021146122 0.020479544 0.020421572 0.021229224 0.022387936 0.021884581
 [13] 0.018140574 0.013384010 0.009921483 0.007723645 0.006618490 0.006210132
 [19] 0.006277431 0.006660547 0.007110237 0.007393173 0.007518216 0.007341517
 [25] 0.006978120 0.006596282 0.006255433 0.005907687 0.005648484 0.005407030
 [31] 0.005270075 0.005198977 0.005304796 0.005565624 0.005952277 0.006379026
 [37] 0.006845308 0.007410956 0.008043468 0.008692392 0.009325820 0.009885231
 [43] 0.010355529 0.010745941 0.011072094 0.011304873 0.011500045 0.011759622
 [49] 0.012079809 0.012396421 0.012659262 0.012790681 0.012721356 0.012452559
 [55] 0.012068993 0.011607580 0.011208624 0.010936850 0.010820824 0.010767523
 [61] 0.010758160 0.010660567 0.010375764 0.009893469 0.009333772 0.008791403
 [67] 0.008384964 0.008150155 0.008108162 0.008185065 0.008267093 0.008319840
 [73] 0.008390021 0.008472278 0.008550723 0.008579722 0.008578023 0.008592033
 [79] 0.008623884 0.008636326 0.008590189 0.008472195 0.008308108 0.008108216
 [85] 0.007877695 0.007614342 0.007317972 0.006989066 0.006630054 0.006243245
 [91] 0.005835668 0.005410889 0.004966226 0.004511028 0.004035543 0.003638610
 [97] 0.003321474 0.003095672 0.002938075 0.002856394 0.002158175
> kt.drift3
[1] -1.131920
> sec3
[1] 0.1893172
> see3
[1] 1.365186

write.table(test3$bx,"test3$bx")

year <- seq(1950,2000)
result <- approx(c(1950,2000),c(-5.2,-5.8),
           seq(1950,2000))$y+c((rnorm(50)/10),.2)
plot (year, result,ylab="log of mortality",
      main="Do we want to match the average annual rate of decline?")
lines (year,18.054 - (.01193*year))
lines (year[c(1,51)],result[c(1,51)],lty=2)
