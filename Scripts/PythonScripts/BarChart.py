#!/usr/bin/env python
# a stacked bar plot with errorbars
import numpy as np
import matplotlib.pyplot as plt



#A = (100,0  ,0  ,59 ,0  ,0, 0,0  ,75  ,0 ,46 ,0)
#T = (0  ,25,100,0  ,0  ,55, 0,100  ,0  ,0 ,48  ,0)
#C = (0  ,0  ,0  ,21 ,0  ,45, 0,0  ,0  ,0 ,6  ,0)
#G = (0  ,75  ,0  ,20 ,100,0, 100,0  ,25  ,100 ,0  ,100)

A = (0 ,0 ,20,0 ,0 ,0 ,12) 
T = (0 ,0 ,0 ,0 ,15,0 ,0 ) 
C = (0 ,10,0 ,6 ,0 ,4 ,0 )
G = (7 ,0 ,0 ,6 ,0 ,0 ,0 )
bases = ('GG','CC','AA','CT','TT','CC','AA')
N = len(A)
#menMeans   = (20, 35, 30, 35, 27)
#womenMeans = (25, 32, 34, 20, 25)
#menStd     = (2, 3, 4, 1, 2)
#womenStd   = (3, 5, 2, 3, 3)
ind = np.arange(N)    # the x locations for the groups
width = 1      # the width of the bars: can also be len(x) sequence

#p1 = plt.bar(ind, menMeans,   width, color='r', yerr=womenStd)
#p2 = plt.bar(ind, womenMeans, width, color='y',bottom=menMeans, yerr=menStd)


print A,"\n"
print T,"\n"

AT= []
ATC=[]
for i in range(0,N):
    AT.append(A[i]+T[i])
    ATC.append(A[i]+T[i]+C[i])
print AT,"\n"


myRed=(205/255.0,92/255.0,92/255.0,0)
myBlue=(100/255.0,149/255.0,237/255.0,0)
myGreen=(60/255.0,179/255.0,113/255.0,0)
myBlack=(112/255.0,112/255.0,112/255.0,0)
p1 = plt.bar(ind, A,   width, color=myRed)        
p2 = plt.bar(ind, T, width, color=myBlue, bottom=A)
p3 = plt.bar(ind, C, width, color=myGreen, bottom=AT)
p4 = plt.bar(ind, G, width, color=myBlack, bottom=ATC)


plt.ylabel('Frequency')
plt.title('Consensus')
plt.xticks(ind+width/2., bases )
#plt.yticks(np.arange(0,101,10))
plt.legend( (p1[0], p2[0], p3[0], p4[0]), ('A', 'T', 'C', 'G') )

plt.show()