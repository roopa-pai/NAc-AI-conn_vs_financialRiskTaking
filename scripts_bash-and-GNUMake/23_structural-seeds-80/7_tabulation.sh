#!/bin/bash
#RKPai
#2018-11-17
#Objective: tabulate and save results in .xls format

ResultsFolder=/mnt/tpp/risktaking/roopa/MScThesis/results

echo 'Starting tabulation script'

cd $ResultsFolder/extr_vals
for i in * #Stanford/Roopa
do
    echo $i
    mkdir -p $ResultsFolder/tabulated_vals/{separate,joined}/$i
    cd $i
    for j in * #FA, MD, AxD, RD
    do
	echo $j
	cd $j
	for k in * #tracts
	do
	    echo $k
	    cd $k
	    for l in * #ring:0,1,2
	    do
		mkdir -p $ResultsFolder/tabulated_vals/separate/${i}/${k}/${j}/${l} #Roopa/LAI2LNAcc/FA/ring0
		cd $l
		for m in * #th1_00_th2_00...th1_XX_th2_XX directories
		do
		    echo $m >> $ResultsFolder/tabulated_vals/separate/${i}/${k}/${j}/${l}/${m}.xls
		    cd $m
		    for n in * #file titled <subject ID> containing mean variable (FA, MD, etc) value for that subject
		    do
			cat $n >> $ResultsFolder/tabulated_vals/separate/$i/${k}/${j}/${l}/${m}.xls
		    done
		    cd ..
		done
		cd ..
	    done
	    cd ..
	done
	cd ..
    done
    cd ..
done

echo 'Made a file for each tract_diffmeasure_ringX_thr1_XX_th2_XX individually. Now combining all the different thresholdings per tract_diffmeasure_ringX into one single file.'

cd $ResultsFolder/tabulated_vals/separate
for i in * #Stanford/Roopa
do
    echo $i
    cd $i
    for j in * #tracts
    do
	echo $j
	cd $j
	for k in * #FA, MD, AxD, RD
	do
	    echo $k
	    cd $k
	    for l in * #ring:0,1,2
	    do
		cd $l
		for m in * # thr1_XX_thr2_XX data column
		do
		    if [ -e $ResultsFolder/tabulated_vals/joined/$i/${j}_${k}_${l}.xls ] #e.g.: Roopa/LAI2LNAcc_FA_ring0.xls
		    then
			paste $ResultsFolder/tabulated_vals/joined/$i/${j}_${k}_${l}.xls $m > temp
			mv temp $ResultsFolder/tabulated_vals/joined/$i/${j}_${k}_${l}.xls
		    else
			cp $m $ResultsFolder/tabulated_vals/joined/$i/${j}_${k}_${l}.xls
		    fi
		done
		cd ..
	    done
	    cd ..
	done
	cd ..
    done
    cd ..
done

echo 'DONE with tabulation script'
