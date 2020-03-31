pg <- read.table("PG_parameters.csv",sep=",",fill=TRUE,header = T)
ptpg <- read.table("PTPG_parameters.csv",sep=",",fill=TRUE,header = T)
BURNIN <- 3000

ptpg <- ptpg[BURNIN:dim(ptpg)[1]-1,]
pg <- pg[BURNIN:dim(pg)[1],]

#Fig 2 - upper row - densities of static parameters

library(ggplot2)
sigma_v <- data.frame(dens = c(pg$X1, ptpg$X1),algorithm = rep(c("PGAS", "PTGAS"), each = dim(pg)[1]))

sigma_w <- data.frame(dens = c(pg$X2, ptpg$X2),algorithm = rep(c("PGAS", "PTGAS"), each = dim(pg)[1]))
.
plot1 <- ggplot(sigma_v, aes(x = dens,  linetype = algorithm)) + geom_density(show.legend = FALSE, lwd = 1.2)+labs(x ="Estimated density of sigma_v", y="") +
          theme_light()+theme(axis.text=element_text(size=22), axis.title.x = element_text(size = 26), axis.text.y = element_blank(), axis.ticks.y = element_blank())
plot2 <- ggplot(sigma_w, aes(x = dens,  linetype = algorithm )) + geom_density(lwd = 1.2) +labs(x ="Estimated density of sigma_w", y ="") +
            theme_light()+ theme(legend.text=element_text(size=26), legend.title=element_text(size=26)) +theme(axis.text=element_text(size=22), axis.title.x = element_text(size = 26), axis.text.y = element_blank(), axis.ticks.y = element_blank())
library(gridExtra)

grid.arrange(plot1, plot2, ncol = 2)




pg <- read.table("PG_trajectories.csv",sep=",",fill=TRUE,header = T)
ptpg <- read.table("PTPG_trajectories.csv",sep=",",fill=TRUE,header = T)

#update rates 
frequencyPG <- replicate(300,0)
frequencyPTPG <- replicate(300,0)

for (t in 1:300) {
  previous <- pg[6001,t+1]
  for (i in 6002:7000) {
    if (pg[i,t+1] != previous) {
      frequencyPG[t] <-frequencyPG[t]+1
    }
    previous <- pg[i,t+1]
  }
  
}
frequencyPG <- frequencyPG/1000

for (t in 1:300) {
  previous <- ptpg[6001,t+1]
  for (i in 6002:7000) {
    if (ptpg[i,t+1] != previous) {
      frequencyPTPG[t] <-frequencyPTPG[t]+1
    }
    previous <- ptpg[i,t+1]
  }
  
}
frequencyPTPG <- frequencyPTPG/1000


freqPG <- data.frame(time= 1:300, freq = c(frequencyPG), each = 300)

freqPG_plot<- ggplot(data=freqPG, aes(x=time, y=freq, group=1)) + geom_line(lwd = 1.0) + labs(x ="time (PTGAS)", y="update rate") + theme_light()+theme(axis.text=element_text(size=22), axis.title.x = element_text(size = 26), axis.title.y= element_text(size=26))

freqPTPG <- data.frame(time= 1:300, freq = c(frequencyPTPG), each = 300)

freqPTPG_plot <- ggplot(data=freqPTPG, aes(x=time, y=freq, group=1)) +geom_line(lwd = 1.0) +labs(x ="time (PGAS)", y=NULL) +theme_light()+theme(axis.text=element_text(size=22), axis.title.x = element_text(size = 26))

grid.arrange(plot1, plot2, freqPG_plot, freqPTPG_plot, ncol = 2, nrow=2)

