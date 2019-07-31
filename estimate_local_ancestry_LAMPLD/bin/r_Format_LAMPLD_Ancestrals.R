# This script extracts data for each ancestral pop and formats the data for lampld.
# There are 3 input files.
# Input file 1: a shapeit haps file.
# Input file 2: a shapeit sample file.
# Input file 3: a list of samples for pop 1 (first 2 columns of plink fam file).
# There can be lists of samples for pop2, 3, etc.

args <- commandArgs(trailingOnly = TRUE)

inPrefix=args[1]
inNameCEU=args[2]
inNameYRI=args[3]
inNameNAM=args[4]
outNameCEUPrefix=paste0(inPrefix,".CEU")
outNameYRIPrefix=paste0(inPrefix,".YRI")
outNameNAMPrefix=paste0(inPrefix,".NAM")
outNamePrefix=paste0(inPrefix)
ceu=read.table(inNameCEU,stringsAsFactors=F)
yri=read.table(inNameYRI,stringsAsFactors=F)
nam=read.table(inNameNAM,stringsAsFactors=F)

# for (i in 1:22) {
for (i in 22){
	inNameHaps=paste0(inPrefix,".",i,'.haps')
	inNameSample=paste0(inPrefix,".",i,'.sample')
	outNameCEU=paste0(outNameCEUPrefix,".",i,'.txt')
	outNameYRI=paste0(outNameYRIPrefix,".",i,'.txt')
	outNameNAM=paste0(outNameNAMPrefix,".",i,'.txt')
	outNameAllele=paste0(outNamePrefix,".allele.",i,'.txt')
	outNamePos=paste0(outNamePrefix,".pos.",i,'.txt')

	haps=read.table(inNameHaps,stringsAsFactors=F)
	haps.num=haps[,6:ncol(haps)]
	samples.all=read.table(inNameSample,skip=2,stringsAsFactors=F)
	ind.ceu=which(is.element(samples.all[,2],ceu[,2]))
	ind.yri=which(is.element(samples.all[,2],yri[,2]))
	ind.nam=which(is.element(samples.all[,2],nam[,2]))

	ind.ceu.2=2*ind.ceu
	ind.ceu.1=ind.ceu.2-1
	ind.ceu.final=sort(c(ind.ceu.1,ind.ceu.2))
	ind.yri.2=2*ind.yri
	ind.yri.1=ind.yri.2-1
	ind.yri.final=sort(c(ind.yri.1,ind.yri.2))
	ind.nam.2=2*ind.nam
	ind.nam.1=ind.nam.2-1
	ind.nam.final=sort(c(ind.nam.1,ind.nam.2))

	haps.ceu=haps.num[,ind.ceu.final]
	haps.yri=haps.num[,ind.yri.final]
	haps.nam=haps.num[,ind.nam.final]

	write.table(t(haps.ceu),outNameCEU,sep='',quote=F,col.names=F,row.names=F)
	write.table(t(haps.yri),outNameYRI,sep='',quote=F,col.names=F,row.names=F)
	write.table(t(haps.nam),outNameNAM,sep='',quote=F,col.names=F,row.names=F)
	write.table(haps[,c(3)],outNamePos,quote=F,sep='\t',col.names=F,row.names=F)
	write.table(haps[,c(2,5)],outNameAllele,quote=F,sep='\t',col.names=F,row.names=F)
}

rm(list=ls())
