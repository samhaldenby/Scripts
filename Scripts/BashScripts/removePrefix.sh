#!/bin/bash

outName=${1/M00205_0007_1_/}
echo $outName

mv $1 $outName
