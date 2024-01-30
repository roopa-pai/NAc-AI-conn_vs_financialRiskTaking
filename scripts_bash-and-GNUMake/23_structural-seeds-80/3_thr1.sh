#!/bin/bash
#RKPai 2018-11-24
#Objective: threshold the output of probtrackx2 with different threshold values
#edit1: binarized Stanford l/r tracts in this script

SubjectsFolder=/mnt/tpp/risktaking/roopa/MScThesis/2_subjects
ResultsFolder=/mnt/tpp/risktaking/roopa/MScThesis/results
AvgTractFolder=$ResultsFolder/average_tracts
mkdir -p $AvgTractFolder/{Roopa,Stanford}

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

echo 'Starting first round of thresholding.'
#(2) threshold tracts with values 0.05:0.05:0.5
cd $SubjectsFolder
for subject in *
do
    if [ -d $subject ]
    then
	echo Starting subject $subject
	ThrFolder=${SubjectsFolder}/${subject}/probtrackx2_results
	cd $ThrFolder
	while read th_val
	do
	    th=$(bc <<<"scale=2; $th_val / 100" )
	    #(a) threshold my tracts
	    for i in * #ring
	    do
		cd $i
		for j in * #tract
		do
		    if [[ "$j" = "LAI2LNAcc" || "$j" = "RAI2RNAcc" ]]
		    then
			if [ ! -e "${ThrFolder}/${i}/${j}/fdt_paths_thresh_`printf %02d $th_val`.nii.gz" ]
			then
			    maxpaths=`fslstats $ThrFolder/$i/$j/fdt_paths.nii.gz -R | awk '{print $2}'`; \
			    minthresh=`echo "${maxpaths}*$th" | bc`; \
			    fslmaths ${ThrFolder}/${i}/${j}/fdt_paths.nii.gz -thr ${minthresh} ${ThrFolder}/${i}/${j}/fdt_paths_thresh_`printf %02d $th_val`.nii.gz; \
			    fslmaths ${ThrFolder}/${i}/${j}/fdt_paths_thresh_`printf %02d $th_val`.nii.gz -bin ${ThrFolder}/${i}/${j}/fdt_paths_thresh_`printf %02d $th_val`_bin.nii.gz; \
			else
			    fslmaths ${ThrFolder}/${i}/${j}/fdt_paths_thresh_`printf %02d $th_val`.nii.gz -bin ${ThrFolder}/${i}/${j}/fdt_paths_thresh_`printf %02d $th_val`_bin.nii.gz
			fi
		    fi
		done
		cd ..
	    done
	    #(b) threshold Stanford tracts
	    mkdir -p  /mnt/tpp/risktaking/roopa/MScThesis/lib/StanfordTracts/thr_tracts/{LAI2LNAcc,RAI2RNAcc}
	    if [ ! -e /mnt/tpp/risktaking/roopa/MScThesis/lib/StanfordTracts/thr_tracts/LAI2LNAcc/avgtract_ring0_thr1_00_thr2_`printf %02d $th_val`.nii.gz ]
	    then
		maxpaths=`fslstats /mnt/tpp/risktaking/roopa/MScThesis/lib/StanfordTracts/lh_ains_nacc_stdspc.nii.gz -R | awk '{print $2}'`; \
		minthresh=`echo "${maxpaths}*$th" | bc`; \
		fslmaths /mnt/tpp/risktaking/roopa/MScThesis/lib/StanfordTracts/lh_ains_nacc_stdspc.nii.gz -thr ${minthresh} -bin /mnt/tpp/risktaking/roopa/MScThesis/lib/StanfordTracts/thr_tracts/LAI2LNAcc/avgtract_ring0_thr1_00_thr2_`printf %02d $th_val`.nii.gz; \
	    fi
	    if [ ! -e /mnt/tpp/risktaking/roopa/MScThesis/lib/StanfordTracts/thr_tracts/RAI2RNAcc/avgtract_ring0_thr1_00_thr2_`printf %02d $th_val`.nii.gz ]
	    then
		maxpaths=`fslstats /mnt/tpp/risktaking/roopa/MScThesis/lib/StanfordTracts/rh_ains_nacc_stdspc.nii.gz -R | awk '{print $2}'`; \
		minthresh=`echo "${maxpaths}*$th" | bc`; \
		fslmaths /mnt/tpp/risktaking/roopa/MScThesis/lib/StanfordTracts/rh_ains_nacc_stdspc.nii.gz -thr ${minthresh} -bin /mnt/tpp/risktaking/roopa/MScThesis/lib/StanfordTracts/thr_tracts/RAI2RNAcc/avgtract_ring0_thr1_00_thr2_`printf %02d $th_val`.nii.gz; \
	    fi
	done < $AvgTractFolder/thresh_vals.txt
	cd ../..
    fi
    echo Done with subject $subject
done

if [ ! -d "$AvgTractFolder/Stanford/LAI2LNAcc" ]
then
    cp -R /mnt/tpp/risktaking/roopa/MScThesis/lib/StanfordTracts/thr_tracts/LAI2LNAcc $AvgTractFolder/Stanford/LAI2LNAcc
fi
if [ ! -d "$AvgTractFolder/Stanford/RAI2RNAcc" ]
then
    cp -R /mnt/tpp/risktaking/roopa/MScThesis/lib/StanfordTracts/thr_tracts/RAI2RNAcc $AvgTractFolder/Stanford/RAI2RNAcc
fi

#Note: for Stanford tracts, I use this format of filename: avgtract_ring0_thr1_00_thr2_XX.nii.gz (because they're already average tracts)

endtime=`date +"%Y%m%d_%H%M%S"`
echo 'DONE with post-tractography script.'
echo started thresholding at $starttime and ended at $endtime
