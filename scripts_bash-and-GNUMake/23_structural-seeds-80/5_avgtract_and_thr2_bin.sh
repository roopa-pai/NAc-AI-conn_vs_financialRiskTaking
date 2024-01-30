#!/bin/bash
#RKPai 2018-11-17
echo 'Objective:
(1)create average tracts from FDT_THRESH_XX_DTItoMNI.nii.gz
(2)second (thr2) thresholding (i.e. post averaging thresholding).'

SubjectsFolder=/mnt/tpp/risktaking/roopa/MScThesis/2_subjects
AvgTractFolder=/mnt/tpp/risktaking/roopa/MScThesis/results/average_tracts
ResultsFolder=/mnt/tpp/risktaking/roopa/MScThesis/results
mkdir -p $AvgTractFolder/{Roopa,Stanford}
sample_size=`cat $SubjectsFolder/subjects | wc -l`
starttime=`date +"%Y%m%d_%H%M%S"`

echo '(1) Now creating avgtracts out of individual thresholded (thr1) tracts registered to standard space (MNI152_bin StdSpc).'

#(1) create sum (over 168 subjects) tract
cd $SubjectsFolder
num_thrs=`cat $AvgTractFolder/thresh_vals.txt | wc -l`
for i in * #subjects
do
    if [ -d $i ]
    then
	echo starting with $i
	cd $i/probtrackx2_results
	for j in * #ring:0,1,2
	do
	    cd $j
	    for k in * #tract, e.g. LNAcc2LAI
	    do
		if [[ "$k" = "LAI2LNAcc" || "$k" = "RAI2RNAcc" ]]
		then
		    cd $k
		    for l in * #fdt*, FDT* files
		    do
			if [[ -n `echo $l | grep -P FDT_THRESH_[0-9]{2}_DTItoMNI_bin.nii.gz` ]]
			then
			    th_val=`basename $l | awk -F '[_.]' '{print $3}'` #should give 05, for example
			    if [[ -f $AvgTractFolder/Roopa/$k/sumtract_${j}_thr1_${th_val}.nii.gz ]] #tract/sumtract_ringX_th1_XX.nii.gz
			    then
				fslmaths $AvgTractFolder/Roopa/$k/sumtract_${j}_thr1_${th_val}.nii.gz -add $l $AvgTractFolder/Roopa/$k/sumtract_${j}_thr1_${th_val}.nii.gz
			    else
				mkdir -p $AvgTractFolder/Roopa/$k
				cp $l $AvgTractFolder/Roopa/$k/sumtract_${j}_thr1_${th_val}.nii.gz
			    fi
			fi
		    done
		    cd ..
		fi
	    done  
	    cd ..
	done	
	cd ../..
	echo done with $i
    fi
done

#(2) create average tract
cd $AvgTractFolder/Roopa
for i in * #tracts, e.g. LNAcc2LAI
do
    cd $i
    for j in * #sumtract_*
    do
	if [[ -n `echo $j | grep -P sumtract_ring[0-2]_thr1_[0-9]{2}.nii.gz` ]]
	then
	    fslmaths $j -div $sample_size `basename avg${j/sum}` #gives, e.g. avgtract_ring1_thr1_05.nii.gz
	fi
    done
    cd ..
done

echo 'Done creating avgtracts. Now doing post-average-thresholding'

#(3) post-average-thresholding
cd $AvgTractFolder/Roopa #just in case. should already be there.
for i in * #tracts, e.g. LNAcc2LAI
do
    cd $i
    for j in * #3 rings{0,1,2}*sumtract(11 files;0:5:50), 3 rings*avgtract files(11 files;0:5:50) [thr2=0 for all, so only 3*11 of each thus far]
    do
	if [[ -n `echo $j | grep -P avgtract_ring[0-2]_thr1_[0-9]{2}.nii.gz` ]] #e.g. avgtract_ring0_thr1_05.nii.gz
	then
	    while read post_th_val
	    do
		pth=$(bc <<<"scale=2; $post_th_val / 100" )
		maxpaths=`fslstats $AvgTractFolder/Roopa/${i}/${j} -R | awk '{print $2}'`; \
		minthresh=`echo "${maxpaths}*$pth" | bc`; \
		fslmaths $AvgTractFolder/Roopa/${i}/${j} -thr ${minthresh} -bin $AvgTractFolder/Roopa/${i}/${j/.nii.gz/}_thr2_${post_th_val}.nii.gz
	    done < $AvgTractFolder/thresh_vals.txt
	fi
    done
    cd ..
done
#Note: at the end of this step, the Roopa/LAI2LNAcc dir has: (33 sum files), (363 avg files: 3 rings *11 thr1 * 11 thr2)

echo 'Done with post-average-thresholding. Now creating directory tree to put extracted subject values in'

#(4) create folders in results directory for value extraction (done in next scripts)

cd $AvgTractFolder/Roopa
for i in * #tracts, e.g. LNAcc2LAI
do
    while read thresh1
    do
	while read thresh2
	do
	    if [[ "$i" = "LAI2LNAcc" || "$i" = "RAI2RNAcc" ]]
	    then
		mkdir -p $ResultsFolder/extr_vals/Roopa/{FA,MD,AxD,RD}/${i}/{ring0,ring1,ring2}/thr1_${thresh1}_thr2_${thresh2}
		mkdir -p $ResultsFolder/extr_vals/Stanford/{FA,MD,AxD,RD}/${i}/ring0/thr1_00_thr2_${thresh2}
	    else
		mkdir -p $ResultsFolder/extr_vals/Roopa/{FA,MD,AxD,RD}/${i}/{ring0,ring1,ring2}/thr1_${thresh1}_thr2_${thresh2}
	    fi
	done < $AvgTractFolder/thresh_vals.txt
    done < $AvgTractFolder/thresh_vals.txt
done

echo 'done making directory tree. Now moving single thresholded average tracts (and sumtracts) to a subdirectory.'

#(5) move sumtracts and avgtracts to a subdirectory
cd $AvgTractFolder/Roopa
for i in * #tracts, e.g. LAI2LNAcc
do
    cd $i
    mkdir -p thr1_only
    for j in * # sumtract, avgtract single-thresholded, avgtract double-thresholded files
    do
	if [ -f $j ]
	then
	    if [[ -n `echo $j | grep sumtract` || -n `echo $j | grep -P avgtract_ring[0-2]_thr1_[0-9]{2}.nii.gz` ]]
	    then
		mv $j thr1_only
	    fi
	fi
    done
    rm -r thr1_only
    cd ..
done

endtime=`date +"%Y%m%d_%H%M%S"`

echo 'DONE with post-tractography process: created double-thresholded average tracts at various degrees of thresholding. Run value extraction script next.'

echo Script started at $starttime and ended at $endtime
