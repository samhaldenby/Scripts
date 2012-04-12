#get cmd line arguments
args<-commandArgs(trailingOnly=TRUE);

#1 - input
#2 - chr
#3 - output


#read in data
start = as.numeric(args[4]);
end = as.numeric(args[5]);
sizeOfRange=(end-start) +1;
#y =readBin("/scratch/sh695/Z01/Z010003.bam.coverage.overall.TESTL78833", "int", n=100000,size=2, signed=FALSE, endian ="little");
y =readBin(args[1], "int", n=sizeOfRange,size=2, signed=FALSE, endian ="little");

sizeY=length(y);
x = start:end;

#describe regions
regionLine = y;
for(i in 1:length(y)){
  if(regionLine[i]<100){
      regionLine[i]<-100;
  }
  else{
    regionLine[i]<-NaN;
  }
}

goodRegionLine = y;
for(i in 1:length(y)){
  if(goodRegionLine[i]>=100){
      goodRegionLine[i]<-100;
  }
  else{
    goodRegionLine[i]<-NaN;
  }
}



#draw graph
pdf(args[3]);
plot.new();

plot.window(xlim=range(x),ylim=range(y));
lines(x,y,lwd=1);
#polygon(c(x,x[length(x)]),c(y,y[1]),col="lemonchiffon");
rect(c(0:0),c(0,0),c(length(x):length(x)),c(100,100),col="lemonchiffon");
lines(x,regionLine,col="red",lwd=1);
lines(x,goodRegionLine,col=51,lwd=1);
title(main = args[2], xlab = "Local Position (bp)", ylab = "Coverage");
axis(1); axis(2); box();

dev.off();

