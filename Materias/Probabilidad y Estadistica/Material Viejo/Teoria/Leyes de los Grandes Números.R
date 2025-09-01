##################
# Primer Gráfico #
##################

# Divide la ventana en subplots
par(mfrow = c(2, 2))

for (k in n_values) {
  x <- c()
  for (i in 1:k) {
    s <- sum(rbinom(i, 1, 0.5))
    x[i] <- s / i
  }
  
  # Calcula la posición de subplot
  subplot_index <- match(k, n_values)
  
  # Selecciona el subplot
  plot(1:k, x, main = paste("n =", k), xlab = "n", ylab = "Sn/n", ylim = c(0, 1), pch = 18, cex = 1, col = 2)
  abline(h = 0.5, lty = 3, col = 4)
}

# Restablece la configuración de gráficos a una sola ventana
par(mfrow = c(1, 1))


################
# Gráficos TCL #
################

#########################
# Distribución Binomial #
#########################
par(mfrow=c(2,2))
med= 0.15
VG= med*(1-med)
x<-1:1000
y=x
z=x
w=x
for (i in 1:1000)
{x[i]=mean(rbinom(2,1,0.5))

y[i]=mean(rbinom(5,1,0.5))

z[i]=mean(rbinom(30,1,0.5))

w[i]=mean(rbinom(200,1,0.5))}

DE2=sqrt(VG/2)
DE5=sqrt(VG/5)
DE30=sqrt(VG/30)
DE200=sqrt(VG/200)

hist(x, freq=F, xlab="n=2", main="")
px=seq(min(x),max(x),(max(x)-min(x))/1000)
lines(px,dnorm(px,med,DE2), col = "blue",lwd = 2)

hist(y, freq=F, xlab="n=5", main="")
py=seq(min(y),max(y),(max(y)-min(y))/1000)
lines(py,dnorm(py,med,DE5), col = "blue",lwd = 2)

hist(z, freq=F, xlab="n=30", main="")
pz=seq(min(z),max(z),(max(z)-min(z))/1000)
lines(pz,dnorm(pz,med,DE30), col = "blue",lwd = 2)

hist(w, freq=F, xlab= "n=200", main="")
pw=seq(min(w),max(w),(max(w)-min(w))/1000)
lines(pw,dnorm(pw,med,DE200), col = "blue",lwd = 2)

################################
# Distribución Hipergeométrica #
################################
par(mfrow=c(2,2))

M=5000
N=10000
#n=3
#n=50
n=100
#n=500
med=n*M/N
VG=med*(1-M/N)*(N-n)/(N-1)
x<-1:1000
y=x
z=x
w=x
for (i in 1:1000)
{x[i]=mean(rhyper(2,M,N-M,n))
y[i]=mean(rhyper(5,M,N-M,n))
z[i]=mean(rhyper(30,M,N-M,n))
w[i]=mean(rhyper(200,M,N-M,n))}
DE2=sqrt(VG/2)
DE5=sqrt(VG/5)
DE30=sqrt(VG/30)
DE200=sqrt(VG/200)

hist(x, freq=F, xlab="n=2", main="")
px=seq(min(x),max(x),(max(x)-min(x))/1000)
lines(px,dnorm(px,med,DE2), col = "blue",lwd = 2)

hist(y, freq=F, xlab="n=5", main="")
py=seq(min(y),max(y),(max(y)-min(y))/1000)
lines(py,dnorm(py,med,DE5), col = "blue",lwd = 2)

hist(z, freq=F, xlab="n=30", main="")
pz=seq(min(z),max(z),(max(z)-min(z))/1000)
lines(pz,dnorm(pz,med,DE30), col = "blue",lwd = 2)

hist(w, freq=F, xlab= "n=200", main="")
pw=seq(min(w),max(w),(max(w)-min(w))/1000)
lines(pw,dnorm(pw,med,DE200), col = "blue",lwd = 2)

#######################################################

###########################
# Distribución Geométrica #
###########################
par(mfrow=c(2,2))
#p=0.05
#p=.1
#p=.25
#p=.5
p=.75
med=(1-p)/p
VG=(1-p)/(p**2)
x<-1:1000
y=x
z=x
w=x
for (i in 1:1000)
{x[i]=mean(rgeom(2,p))
y[i]=mean(rgeom(5,p))
z[i]=mean(rgeom(30,p))
w[i]=mean(rgeom(200,p))}

DE2=sqrt(VG/2)
DE5=sqrt(VG/5)
DE30=sqrt(VG/30)
DE200=sqrt(VG/200)

hist(x, freq=F, xlab="n=2", main="")
px=seq(min(x),max(x),(max(x)-min(x))/1000)
lines(px,dnorm(px,med,DE2), col = "blue",lwd = 2)

hist(y, freq=F, xlab="n=5", main="")
py=seq(min(y),max(y),(max(y)-min(y))/1000)
lines(py,dnorm(py,med,DE5), col = "blue",lwd = 2)

hist(z, freq=F, xlab="n=30", main="")
pz=seq(min(z),max(z),(max(z)-min(z))/1000)
lines(pz,dnorm(pz,med,DE30), col = "blue",lwd = 2)

hist(w, freq=F, xlab= "n=200", main="")
pw=seq(min(w),max(w),(max(w)-min(w))/1000)
lines(pw,dnorm(pw,med,DE200), col = "blue",lwd = 2)
