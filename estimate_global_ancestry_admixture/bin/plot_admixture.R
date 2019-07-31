library(ggplot2)
library(reshape2)
options(warn=1)
sessionInfo()
options("scipen"=100, "digits"=4)

args <- commandArgs(trailingOnly = TRUE)
fp <- args[1]
popFp <- args[2]
outFpI <- args[3]

# dir <- "/home/user"
# fp <- paste0(dir,"/demo.merge.pruned.3.Q")
# popFp <- paste0(dir,"/demo.merge.pruned.pop")

t.pop <- read.table(popFp,header=F)
head(t.pop)

t.global<- read.table(fp,header=F)
cat("t.global\n")
head(t.global)
colnames(t.global) <- c("CEU","NAM","YRI")

t <- t.global
n <- nrow(t)
t$rank <- NA
t[order(t$YRI),"rank"] <- 1:n
head(t)

t.sum.melt.all <- melt(t,id=c("rank"))
head(t.sum.melt.all)
pdf(paste0(outFpI,".pdf"),height=7,width=13)

a <- c("YRI","CEU","NAM")
color.list <- c("#CE2528","#4454A1","#E9A331")
df <- t.sum.melt.all
n <- length(unique(df$rank))
plot <- ggplot() + theme(panel.background = element_rect(fill=0,colour=0), axis.ticks=element_blank(), panel.grid = element_blank())
plot <- plot + theme(axis.text.x = element_blank())
plot <- plot + theme(axis.text.y = element_blank())
plot <- plot + theme(axis.title = element_text(size=24))
plot <- plot + theme(axis.text = element_text(size=18))
plot <- plot + theme(legend.title = element_text(size=18))
plot <- plot + theme(legend.text = element_text(size=18))
plot <- plot + xlab("")
plot <- plot + ylab("")
plot <- plot + labs(title=paste0("N=",n))
plot <- plot + geom_bar(data=df, aes(reorder(rank,rank),fill=variable,weight=value),width=1)
plot <- plot + scale_fill_manual(name="Ancestry",limits=a,values=c(color.list))
print(plot)

dev.off()
