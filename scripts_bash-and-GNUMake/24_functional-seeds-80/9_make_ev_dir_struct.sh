#!/bin/bash
#RKPai 2018-11-15
#8_DTI
#Objective: create extr_vals_self directory structure before running self extraction makefile

SubjectsFolder=/mnt/tpp/risktaking/roopa/MScThesis/2_subjects
ResultsFolder=/mnt/tpp/risktaking/roopa/MScThesis/results
AvgTractFolder=$ResultsFolder/average_tracts
sample_size=`cat $SubjectsFolder/subjects | wc -l`
starttime=`date +"%Y%m%d_%H%M%S"`

#(1) create list of values chosen for threshold
if [ ! -e "$AvgTractFolder/thresh_vals.txt" ]
then
    echo "Creating list of thresholding values."
    for th_val in $(seq 0 5 50)
    do
	echo `printf %02d $th_val` >> $AvgTractFolder/thresh_vals.txt
    done
fi

echo 'Creating extr_vals_self directory structure'

#(2) create folders in results directory for self value extraction (done in next scripts)
cd $AvgTractFolder/Roopa
for i in * #tracts, e.g. LNAcc2LAI
do
    while read thresh1
    do
	mkdir -p $ResultsFolder/extr_vals_self/Roopa/{FA,MD,AxD,RD}/${i}/{ring0,ring1}/thr1_${thresh1}
    done < $AvgTractFolder/thresh_vals.txt
done
