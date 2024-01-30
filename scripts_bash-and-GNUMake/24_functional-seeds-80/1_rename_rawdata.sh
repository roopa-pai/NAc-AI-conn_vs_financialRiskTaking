#!/bin/bash
#RKPai 20 September 2018
#Objective: (1) Start with raw DTI and FreeSurfer data (2) create a directory structure (2) convert file formats and save the new files there, to be used in later steps.

RRDFolder=/mnt/tpp/risktaking/roopa/MScThesis
cd $RRDFolder/raw_data/DTI

for i in *
do
    cd $i
    for j in *
    do
	if [[ $j == ep2d* ]]
	then
	    cd $j
	    for k in *
	    do
		mkdir -p $RRDFolder/subjects/${k/^*^*^*/}/original/$j
		cp $k/*.anon $RRDFolder/subjects/${k/^*^*^*/}/original/$j
	    done
	    cd ..
	fi
    done
    cd ..
done

#(2) Rename FreeSurfer SubjectID subdirectories
cd $RRDFolder/raw_data/freesurfer
for i in * 
do
    mv $i ${i/^*^*^*/}
    mri_convert $i/mri/T1.mgz $RRDFolder/subjects/$i/t1_1.nii.gz
    fslreorient2std $RRDFolder/subjects/$i/t1_1.nii.gz $RRDFolder/subjects/$i/t1.nii.gz
    rm $RRDFolder/subjects/$i/t1_1.nii.gz
done

#(3)convert DTI raw data: dicom to nifti
cd $RRDFolder/subjects
for i in *
do
    cd $i/original/
    dcm2nii $RRDFolder/subjects/$i/original/
    for j in *.nii.gz
    do
	fslreorient2std $j
    done
    fslmerge -t DTI.nii.gz *.nii.gz
    paste *.bval > bvals.txt
    paste *.bvec > bvecs.txt
    mv DTI.nii.gz $RRDFolder/subjects/$i/
    mv bvals.txt $RRDFolder/subjects/$i/
    mv bvecs.txt $RRDFolder/subjects/$i/
    cd ../..
done

#(4) (a) create a list of subjects (ID and 0/1, i.e. old/new sequence) to be used in makefiles later on and (b) create a status file in each subject subdir with 0 or 1, based on whether their DTI scans were acquired with the old (0) or new (1) sequence.
for i in *
do
    if [[ $(ls $i/original/*.nii.gz | wc -l) == 18 ]]
    then
	echo $i 0 >> subjects
	echo 0 >> $i/status
    elif [[ $(ls $i/original/*.nii.gz | wc -l) == 6 ]]
    then
	echo $i 1 >> subjects
	echo 1 >> $i/status
    else
	echo error in $i
    fi
done
