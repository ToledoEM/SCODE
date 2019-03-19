#!/bin/bash

IFS=$'\n'
set -e

fdata=$1
ftime=$2
dir=$3
tfnum=$4
pnum=$5
cnum=$6
maxite=$7
repnum=$8

echo
echo "This script execute SCODE in parallel"
echo

# check that the dependecies are installed
command -v parallel -? >/dev/null 2>&1 || { echo ; echo >&2 "GNU parallel it's not installed.  Aborting."; echo ; exit 1 ;}
command -v Rscript >/dev/null 2>&1 || { echo ; echo >&2 "Rscript it's not installed.  Aborting."; echo ; exit 1 ;}

#make dir
mkdir $dir



parallel  --bar "Rscript SCODE.R $fdata $ftime $dir/out_{} $tfnum $pnum $cnum $maxite" :::: <(seq 1 $repnum)

echo
echo "Making the average"
Rscript averageA.R $dir $repnum
