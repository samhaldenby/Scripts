#Needed to $ sudo apt-get install python-matplotlib

import numpy as np, pylab
import Tkinter
import matplotlib.pyplot as plt
from optparse import OptionParser
print np.__version__

#Parse command line options
parser = OptionParser()
parser.add_option("-f", "--frequencies", dest="frequencyFileName", action="store", help="frequency data input file", metavar="FILE")
parser.add_option("-c", "--cumulative-frequencies", dest="cumulativeFileName", action="store", help="cumulative frequency data input file",metavar="FILE")
parser.add_option("-o", "--output", dest="outputTag", help="output file tag", metavar="STRING")


#declare arrays
cumFreq =[]
freq =[]

(options,args) = parser.parse_args()

#load frequency data
inputFile=open(options.frequencyFileName)
for line in inputFile:
    spl=line.rstrip().split("\t")
    freq.append(int(spl[1]))

inputFile.close()

#load cumulative frequency data
inputFile=open(options.cumulativeFileName)
for line in inputFile:
    spl=line.rstrip().split("\t")
    cumFreq.append(float(spl[1]))

inputFile.close()


#checks
print "FreqRange:%d\nCumulativeRange:%d\n",len(freq),len(cumFreq)
if(len(freq)!=len(cumFreq)):
    print "ERROR: lists are not the same size!"
    exit

#PLOT

#arrange plots
fig = plt.figure()
xVal=range(0,(len(freq)))
pylab.xlim([0,200])
xVal=np.array(xVal)
ax1 = plt.subplot(111)
plt.fill_between(xVal,0, freq, color='g')
plt.fill_between(xVal,0, freq, xVal<20, color='y')
plt.plot(xVal,freq,'k-', linewidth=1)

#plt.plot(xVal,frequency,'b-', linewidth=1)
plt.title('Coverage Frequency')
plt.xlabel('Depth')
plt.ylabel('Frequency')
ax2=plt.twinx()
plt.plot(xVal,cumFreq,'r-', linewidth=2)
plt.ylabel('Cumulative Frequency')
pylab.xlim([0,200])

#plt.ylabel('Number of Reads')
#plt.xlabel('Read Length (bp)')
#plt.title('Read Length Distribution')


#export
outFileName = options.outputTag + "_coverageFrequencyPlot.pdf"
plt.savefig(outFileName)
inputFile.close()

