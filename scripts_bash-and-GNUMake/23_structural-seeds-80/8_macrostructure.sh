#!/bin/bash
#RKPai 2018-11-14
#7_DTI
#Objective: analysis of ROI & white matter macrostructure. could correlate these values with ROI/RTI
#(1) get size of ROIs in (i) number of voxels as well as (ii) volume (mm^3)
#(2) get size (in either voxels or equivalent mm^3 volume) of each subject's individual tract, at each level of thresholding.

#IMP note: you wouldn't necessarily need to correct for seed size, because for each voxel we're only looking at whether it belongs to the tract or not - not the intensity/number of streamlines in the voxel, which depends on the seed size (5000 streamlines are generated from each seed voxel).
#HOWEVER realistically the tract size would depend on the source/seed size (because the number of axons is proportional to the number of cell bodies they spring from). but voxels are bigger than axonal diameters, so if it's a binary measure all you're looking at is whether an axon is likely to have passed through that voxel or not. it could be one it could be ten. so I don't necessarily expect this to be predictive/related to seed size.
#BUT this measure may capture fanning/curving effects. (more axons spread out may lead to more connectivity; alternatively, fewer voxels could mean a complex, less bendy tract that runs from A to B "as the crow flies", but this should theoretically be captured by diffusivity measures also.)

SubjectsFolder=/mnt/tpp/risktaking/roopa/MScThesis/2_subjects
ResultsFolder=/mnt/tpp/risktaking/roopa/MScThesis/results
mkdir -p $ResultsFolder/macrostructure/{ROIs,tracts}
starttime=`date +"%Y%m%d_%H%M%S"`

#(1) ROI volume: in (i) voxels and (ii) in mm^3
echo "Starting: ROI volume calculation"
cd $SubjectsFolder
for i in * #subjectIDs
do
    if [ -d $i ]
    then
	echo starting with $i
	cd ${i}/ROIs
	for j in * #ROI files
	do
	    if [[ -n `echo $j | grep -P _ring[0-2]{1}` ]]
	    then
		#make a file, e.g. RAI_ring1 with 3 cols: subjID, no. of voxels, volume (mm^3)
		echo -n $i >> $ResultsFolder/macrostructure/ROIs/${j/.nii.gz}.xls
		echo -n " " >> $ResultsFolder/macrostructure/ROIs/${j/.nii.gz}.xls
		echo -n `fslstats $j -V | awk '{print $1}'` >> $ResultsFolder/macrostructure/ROIs/${j/.nii.gz}.xls
		echo -n " " >> $ResultsFolder/macrostructure/ROIs/${j/.nii.gz}.xls
		echo `fslstats $j -V | awk '{print $2}'` >> $ResultsFolder/macrostructure/ROIs/${j/.nii.gz}.xls
	    fi
	done
	cd ../..
    fi
done

#(2) tract volume
echo "Starting: tract volume calculation"
cd $SubjectsFolder
for i in * #subjects
do
    if [ -d $i ]
    then
	echo starting with $i
	cd $i/probtrackx2_results
	for j in * #ring
	do
	    cd $j
	    for k in * #tracts
	    do
		cd $k
		for l in * # fdt*, FDT* files
		do
		    if [[ -n `echo $l | grep -P fdt_paths_thresh_[0-9]{2}_bin.nii.gz` ]]
		    then
			echo -n $i >> $ResultsFolder/macrostructure/tracts/vol_${j}_${k}_`echo $l | grep -Po thresh_[0-9]{2}`.xls
			echo -n " " >> $ResultsFolder/macrostructure/tracts/vol_${j}_${k}_`echo $l | grep -Po thresh_[0-9]{2}`.xls
			echo -n `fslstats $l -V | awk '{print $1}'` >> $ResultsFolder/macrostructure/tracts/vol_${j}_${k}_`echo $l | grep -Po thresh_[0-9]{2}`.xls
			echo -n " " >> $ResultsFolder/macrostructure/tracts/vol_${j}_${k}_`echo $l | grep -Po thresh_[0-9]{2}`.xls
			echo `fslstats $l -V | awk '{print $2}'` >> $ResultsFolder/macrostructure/tracts/vol_${j}_${k}_`echo $l | grep -Po thresh_[0-9]{2}`.xls
		    fi
		done
		cd ..
	    done
	    cd ..
	done
	cd ../..
    fi
done

endtime=`date +"%Y%m%d_%H%M%S"`

echo "DONE collating macrostructure information."
echo script started at $starttime and ended at $endtime
