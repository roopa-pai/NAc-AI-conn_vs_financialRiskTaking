#RKPai 2018-11-15
#Makefile for tractography: registration of binarized thr1_XX tracts to MNI152 StdSpc in one step

SHELL=/bin/bash
export SHELL

export ANTSPATH=/usr/local/ANTs-2.1.0-rc3/bin/
export PATH:=${ANTSPATH}:$(PATH)

subject=$(notdir $(shell pwd))

all: thr_tracts

#probtrackx2_results/ring0/LAI2LNAcc/FDT_THRESH_%_DTItoMNI_bin.nii.gz probtrackx2_results/ring0/RAI2RNAcc/FDT_THRESH_%_DTItoMNI_bin.nii.gz probtrackx2_results/ring1/LAI2LNAcc/FDT_THRESH_%_DTItoMNI_bin.nii.gz probtrackx2_results/ring1/RAI2RNAcc/FDT_THRESH_%_DTItoMNI_bin.nii.gz

thr_tracts: probtrackx2_results/ring0/LAI2LNAcc/FDT_THRESH_00_DTItoMNI_bin.nii.gz probtrackx2_results/ring0/LAI2LNAcc/FDT_THRESH_05_DTItoMNI_bin.nii.gz probtrackx2_results/ring0/LAI2LNAcc/FDT_THRESH_10_DTItoMNI_bin.nii.gz probtrackx2_results/ring0/LAI2LNAcc/FDT_THRESH_15_DTItoMNI_bin.nii.gz probtrackx2_results/ring0/LAI2LNAcc/FDT_THRESH_20_DTItoMNI_bin.nii.gz probtrackx2_results/ring0/LAI2LNAcc/FDT_THRESH_25_DTItoMNI_bin.nii.gz probtrackx2_results/ring0/LAI2LNAcc/FDT_THRESH_30_DTItoMNI_bin.nii.gz probtrackx2_results/ring0/LAI2LNAcc/FDT_THRESH_35_DTItoMNI_bin.nii.gz probtrackx2_results/ring0/LAI2LNAcc/FDT_THRESH_40_DTItoMNI_bin.nii.gz probtrackx2_results/ring0/LAI2LNAcc/FDT_THRESH_45_DTItoMNI_bin.nii.gz probtrackx2_results/ring0/LAI2LNAcc/FDT_THRESH_50_DTItoMNI_bin.nii.gz probtrackx2_results/ring0/RAI2RNAcc/FDT_THRESH_00_DTItoMNI_bin.nii.gz probtrackx2_results/ring0/RAI2RNAcc/FDT_THRESH_05_DTItoMNI_bin.nii.gz probtrackx2_results/ring0/RAI2RNAcc/FDT_THRESH_10_DTItoMNI_bin.nii.gz probtrackx2_results/ring0/RAI2RNAcc/FDT_THRESH_15_DTItoMNI_bin.nii.gz probtrackx2_results/ring0/RAI2RNAcc/FDT_THRESH_20_DTItoMNI_bin.nii.gz probtrackx2_results/ring0/RAI2RNAcc/FDT_THRESH_25_DTItoMNI_bin.nii.gz probtrackx2_results/ring0/RAI2RNAcc/FDT_THRESH_30_DTItoMNI_bin.nii.gz probtrackx2_results/ring0/RAI2RNAcc/FDT_THRESH_35_DTItoMNI_bin.nii.gz probtrackx2_results/ring0/RAI2RNAcc/FDT_THRESH_40_DTItoMNI_bin.nii.gz probtrackx2_results/ring0/RAI2RNAcc/FDT_THRESH_45_DTItoMNI_bin.nii.gz probtrackx2_results/ring0/RAI2RNAcc/FDT_THRESH_50_DTItoMNI_bin.nii.gz probtrackx2_results/ring1/LAI2LNAcc/FDT_THRESH_00_DTItoMNI_bin.nii.gz probtrackx2_results/ring1/LAI2LNAcc/FDT_THRESH_05_DTItoMNI_bin.nii.gz probtrackx2_results/ring1/LAI2LNAcc/FDT_THRESH_10_DTItoMNI_bin.nii.gz probtrackx2_results/ring1/LAI2LNAcc/FDT_THRESH_15_DTItoMNI_bin.nii.gz probtrackx2_results/ring1/LAI2LNAcc/FDT_THRESH_20_DTItoMNI_bin.nii.gz probtrackx2_results/ring1/LAI2LNAcc/FDT_THRESH_25_DTItoMNI_bin.nii.gz probtrackx2_results/ring1/LAI2LNAcc/FDT_THRESH_30_DTItoMNI_bin.nii.gz probtrackx2_results/ring1/LAI2LNAcc/FDT_THRESH_35_DTItoMNI_bin.nii.gz probtrackx2_results/ring1/LAI2LNAcc/FDT_THRESH_40_DTItoMNI_bin.nii.gz probtrackx2_results/ring1/LAI2LNAcc/FDT_THRESH_45_DTItoMNI_bin.nii.gz probtrackx2_results/ring1/LAI2LNAcc/FDT_THRESH_50_DTItoMNI_bin.nii.gz probtrackx2_results/ring1/RAI2RNAcc/FDT_THRESH_00_DTItoMNI_bin.nii.gz probtrackx2_results/ring1/RAI2RNAcc/FDT_THRESH_05_DTItoMNI_bin.nii.gz probtrackx2_results/ring1/RAI2RNAcc/FDT_THRESH_10_DTItoMNI_bin.nii.gz probtrackx2_results/ring1/RAI2RNAcc/FDT_THRESH_15_DTItoMNI_bin.nii.gz probtrackx2_results/ring1/RAI2RNAcc/FDT_THRESH_20_DTItoMNI_bin.nii.gz probtrackx2_results/ring1/RAI2RNAcc/FDT_THRESH_25_DTItoMNI_bin.nii.gz probtrackx2_results/ring1/RAI2RNAcc/FDT_THRESH_30_DTItoMNI_bin.nii.gz probtrackx2_results/ring1/RAI2RNAcc/FDT_THRESH_35_DTItoMNI_bin.nii.gz probtrackx2_results/ring1/RAI2RNAcc/FDT_THRESH_40_DTItoMNI_bin.nii.gz probtrackx2_results/ring1/RAI2RNAcc/FDT_THRESH_45_DTItoMNI_bin.nii.gz probtrackx2_results/ring1/RAI2RNAcc/FDT_THRESH_50_DTItoMNI_bin.nii.gz

#(1) ring0
probtrackx2_results/ring0/LAI2LNAcc/FDT_THRESH_%_DTItoMNI_bin.nii.gz: probtrackx2_results/ring0/LAI2LNAcc/fdt_paths_thresh_%_bin.nii.gz /mnt/tpp/risktaking/roopa/MScThesis/lib/MNI152_T1_1mm_brain.nii.gz
	WarpImageMultiTransform 3 $< $@ -R $(word 2,$^) DTItoT11Warp.nii.gz DTItoT10GenericAffine.mat T1toStdSpc1Warp.nii.gz T1toStdSpc0GenericAffine.mat ;\
	fslmaths $@ -bin $@

probtrackx2_results/ring0/LNAcc2LAI/FDT_THRESH_%_DTItoMNI_bin.nii.gz: probtrackx2_results/ring0/LNAcc2LAI/fdt_paths_thresh_%_bin.nii.gz /mnt/tpp/risktaking/roopa/MScThesis/lib/MNI152_T1_1mm_brain.nii.gz
	WarpImageMultiTransform 3 $< $@ -R $(word 2,$^) DTItoT11Warp.nii.gz DTItoT10GenericAffine.mat T1toStdSpc1Warp.nii.gz T1toStdSpc0GenericAffine.mat ;\
	fslmaths $@ -bin $@

probtrackx2_results/ring0/RAI2RNAcc/FDT_THRESH_%_DTItoMNI_bin.nii.gz: probtrackx2_results/ring0/RAI2RNAcc/fdt_paths_thresh_%_bin.nii.gz /mnt/tpp/risktaking/roopa/MScThesis/lib/MNI152_T1_1mm_brain.nii.gz
	WarpImageMultiTransform 3 $< $@ -R $(word 2,$^) DTItoT11Warp.nii.gz DTItoT10GenericAffine.mat T1toStdSpc1Warp.nii.gz T1toStdSpc0GenericAffine.mat ;\
	fslmaths $@ -bin $@

probtrackx2_results/ring0/RNAcc2RAI/FDT_THRESH_%_DTItoMNI_bin.nii.gz: probtrackx2_results/ring0/RNAcc2RAI/fdt_paths_thresh_%_bin.nii.gz /mnt/tpp/risktaking/roopa/MScThesis/lib/MNI152_T1_1mm_brain.nii.gz
	WarpImageMultiTransform 3 $< $@ -R $(word 2,$^) DTItoT11Warp.nii.gz DTItoT10GenericAffine.mat T1toStdSpc1Warp.nii.gz T1toStdSpc0GenericAffine.mat ;\
	fslmaths $@ -bin $@
probtrackx2_results/ring0/LAMYG2LNAcc/FDT_THRESH_%_DTItoMNI_bin.nii.gz: probtrackx2_results/ring0/LAMYG2LNAcc/fdt_paths_thresh_%_bin.nii.gz /mnt/tpp/risktaking/roopa/MScThesis/lib/MNI152_T1_1mm_brain.nii.gz
	WarpImageMultiTransform 3 $< $@ -R $(word 2,$^) DTItoT11Warp.nii.gz DTItoT10GenericAffine.mat T1toStdSpc1Warp.nii.gz T1toStdSpc0GenericAffine.mat ;\
	fslmaths $@ -bin $@

probtrackx2_results/ring0/RAMYG2RNAcc/FDT_THRESH_%_DTItoMNI_bin.nii.gz: probtrackx2_results/ring0/RAMYG2RNAcc/fdt_paths_thresh_%_bin.nii.gz /mnt/tpp/risktaking/roopa/MScThesis/lib/MNI152_T1_1mm_brain.nii.gz
	WarpImageMultiTransform 3 $< $@ -R $(word 2,$^) DTItoT11Warp.nii.gz DTItoT10GenericAffine.mat T1toStdSpc1Warp.nii.gz T1toStdSpc0GenericAffine.mat ;\
	fslmaths $@ -bin $@

probtrackx2_results/ring0/LPCG2LCrCe/FDT_THRESH_%_DTItoMNI_bin.nii.gz: probtrackx2_results/ring0/LPCG2LCrCe/fdt_paths_thresh_%_bin.nii.gz /mnt/tpp/risktaking/roopa/MScThesis/lib/MNI152_T1_1mm_brain.nii.gz
	WarpImageMultiTransform 3 $< $@ -R $(word 2,$^) DTItoT11Warp.nii.gz DTItoT10GenericAffine.mat T1toStdSpc1Warp.nii.gz T1toStdSpc0GenericAffine.mat ;\
	fslmaths $@ -bin $@

probtrackx2_results/ring0/RPCG2RCrCe/FDT_THRESH_%_DTItoMNI_bin.nii.gz: probtrackx2_results/ring0/RPCG2RCrCe/fdt_paths_thresh_%_bin.nii.gz /mnt/tpp/risktaking/roopa/MScThesis/lib/MNI152_T1_1mm_brain.nii.gz
	WarpImageMultiTransform 3 $< $@ -R $(word 2,$^) DTItoT11Warp.nii.gz DTItoT10GenericAffine.mat T1toStdSpc1Warp.nii.gz T1toStdSpc0GenericAffine.mat ;\
	fslmaths $@ -bin $@

#(2) ring1
probtrackx2_results/ring1/LAI2LNAcc/FDT_THRESH_%_DTItoMNI_bin.nii.gz: probtrackx2_results/ring1/LAI2LNAcc/fdt_paths_thresh_%_bin.nii.gz /mnt/tpp/risktaking/roopa/MScThesis/lib/MNI152_T1_1mm_brain.nii.gz
	WarpImageMultiTransform 3 $< $@ -R $(word 2,$^) DTItoT11Warp.nii.gz DTItoT10GenericAffine.mat T1toStdSpc1Warp.nii.gz T1toStdSpc0GenericAffine.mat ;\
	fslmaths $@ -bin $@

probtrackx2_results/ring1/LNAcc2LAI/FDT_THRESH_%_DTItoMNI_bin.nii.gz: probtrackx2_results/ring1/LNAcc2LAI/fdt_paths_thresh_%_bin.nii.gz /mnt/tpp/risktaking/roopa/MScThesis/lib/MNI152_T1_1mm_brain.nii.gz
	WarpImageMultiTransform 3 $< $@ -R $(word 2,$^) DTItoT11Warp.nii.gz DTItoT10GenericAffine.mat T1toStdSpc1Warp.nii.gz T1toStdSpc0GenericAffine.mat ;\
	fslmaths $@ -bin $@

probtrackx2_results/ring1/RAI2RNAcc/FDT_THRESH_%_DTItoMNI_bin.nii.gz: probtrackx2_results/ring1/RAI2RNAcc/fdt_paths_thresh_%_bin.nii.gz /mnt/tpp/risktaking/roopa/MScThesis/lib/MNI152_T1_1mm_brain.nii.gz
	WarpImageMultiTransform 3 $< $@ -R $(word 2,$^) DTItoT11Warp.nii.gz DTItoT10GenericAffine.mat T1toStdSpc1Warp.nii.gz T1toStdSpc0GenericAffine.mat ;\
	fslmaths $@ -bin $@

probtrackx2_results/ring1/RNAcc2RAI/FDT_THRESH_%_DTItoMNI_bin.nii.gz: probtrackx2_results/ring1/RNAcc2RAI/fdt_paths_thresh_%_bin.nii.gz /mnt/tpp/risktaking/roopa/MScThesis/lib/MNI152_T1_1mm_brain.nii.gz
	WarpImageMultiTransform 3 $< $@ -R $(word 2,$^) DTItoT11Warp.nii.gz DTItoT10GenericAffine.mat T1toStdSpc1Warp.nii.gz T1toStdSpc0GenericAffine.mat ;\
	fslmaths $@ -bin $@

probtrackx2_results/ring1/LAMYG2LNAcc/FDT_THRESH_%_DTItoMNI_bin.nii.gz: probtrackx2_results/ring1/LAMYG2LNAcc/fdt_paths_thresh_%_bin.nii.gz /mnt/tpp/risktaking/roopa/MScThesis/lib/MNI152_T1_1mm_brain.nii.gz
	WarpImageMultiTransform 3 $< $@ -R $(word 2,$^) DTItoT11Warp.nii.gz DTItoT10GenericAffine.mat T1toStdSpc1Warp.nii.gz T1toStdSpc0GenericAffine.mat ;\
	fslmaths $@ -bin $@

probtrackx2_results/ring1/RAMYG2RNAcc/FDT_THRESH_%_DTItoMNI_bin.nii.gz: probtrackx2_results/ring1/RAMYG2RNAcc/fdt_paths_thresh_%_bin.nii.gz /mnt/tpp/risktaking/roopa/MScThesis/lib/MNI152_T1_1mm_brain.nii.gz
	WarpImageMultiTransform 3 $< $@ -R $(word 2,$^) DTItoT11Warp.nii.gz DTItoT10GenericAffine.mat T1toStdSpc1Warp.nii.gz T1toStdSpc0GenericAffine.mat ;\
	fslmaths $@ -bin $@

probtrackx2_results/ring1/LPCG2LCrCe/FDT_THRESH_%_DTItoMNI_bin.nii.gz: probtrackx2_results/ring1/LPCG2LCrCe/fdt_paths_thresh_%_bin.nii.gz /mnt/tpp/risktaking/roopa/MScThesis/lib/MNI152_T1_1mm_brain.nii.gz
	WarpImageMultiTransform 3 $< $@ -R $(word 2,$^) DTItoT11Warp.nii.gz DTItoT10GenericAffine.mat T1toStdSpc1Warp.nii.gz T1toStdSpc0GenericAffine.mat ;\
	fslmaths $@ -bin $@

probtrackx2_results/ring1/RPCG2RCrCe/FDT_THRESH_%_DTItoMNI_bin.nii.gz: probtrackx2_results/ring1/RPCG2RCrCe/fdt_paths_thresh_%_bin.nii.gz /mnt/tpp/risktaking/roopa/MScThesis/lib/MNI152_T1_1mm_brain.nii.gz
	WarpImageMultiTransform 3 $< $@ -R $(word 2,$^) DTItoT11Warp.nii.gz DTItoT10GenericAffine.mat T1toStdSpc1Warp.nii.gz T1toStdSpc0GenericAffine.mat ;\
	fslmaths $@ -bin $@

#(3) ring2
probtrackx2_results/ring2/LAI2LNAcc/FDT_THRESH_%_DTItoMNI_bin.nii.gz: probtrackx2_results/ring2/LAI2LNAcc/fdt_paths_thresh_%_bin.nii.gz /mnt/tpp/risktaking/roopa/MScThesis/lib/MNI152_T1_1mm_brain.nii.gz
	WarpImageMultiTransform 3 $< $@ -R $(word 2,$^) DTItoT11Warp.nii.gz DTItoT10GenericAffine.mat T1toStdSpc1Warp.nii.gz T1toStdSpc0GenericAffine.mat ;\
	fslmaths $@ -bin $@

probtrackx2_results/ring2/LNAcc2LAI/FDT_THRESH_%_DTItoMNI_bin.nii.gz: probtrackx2_results/ring2/LNAcc2LAI/fdt_paths_thresh_%_bin.nii.gz /mnt/tpp/risktaking/roopa/MScThesis/lib/MNI152_T1_1mm_brain.nii.gz
	WarpImageMultiTransform 3 $< $@ -R $(word 2,$^) DTItoT11Warp.nii.gz DTItoT10GenericAffine.mat T1toStdSpc1Warp.nii.gz T1toStdSpc0GenericAffine.mat ;\
	fslmaths $@ -bin $@

probtrackx2_results/ring2/RAI2RNAcc/FDT_THRESH_%_DTItoMNI_bin.nii.gz: probtrackx2_results/ring2/RAI2RNAcc/fdt_paths_thresh_%_bin.nii.gz /mnt/tpp/risktaking/roopa/MScThesis/lib/MNI152_T1_1mm_brain.nii.gz
	WarpImageMultiTransform 3 $< $@ -R $(word 2,$^) DTItoT11Warp.nii.gz DTItoT10GenericAffine.mat T1toStdSpc1Warp.nii.gz T1toStdSpc0GenericAffine.mat ;\
	fslmaths $@ -bin $@

probtrackx2_results/ring2/RNAcc2RAI/FDT_THRESH_%_DTItoMNI_bin.nii.gz: probtrackx2_results/ring2/RNAcc2RAI/fdt_paths_thresh_%_bin.nii.gz /mnt/tpp/risktaking/roopa/MScThesis/lib/MNI152_T1_1mm_brain.nii.gz
	WarpImageMultiTransform 3 $< $@ -R $(word 2,$^) DTItoT11Warp.nii.gz DTItoT10GenericAffine.mat T1toStdSpc1Warp.nii.gz T1toStdSpc0GenericAffine.mat ;\
	fslmaths $@ -bin $@

probtrackx2_results/ring2/LAMYG2LNAcc/FDT_THRESH_%_DTItoMNI_bin.nii.gz: probtrackx2_results/ring2/LAMYG2LNAcc/fdt_paths_thresh_%_bin.nii.gz /mnt/tpp/risktaking/roopa/MScThesis/lib/MNI152_T1_1mm_brain.nii.gz
	WarpImageMultiTransform 3 $< $@ -R $(word 2,$^) DTItoT11Warp.nii.gz DTItoT10GenericAffine.mat T1toStdSpc1Warp.nii.gz T1toStdSpc0GenericAffine.mat ;\
	fslmaths $@ -bin $@

probtrackx2_results/ring2/RAMYG2RNAcc/FDT_THRESH_%_DTItoMNI_bin.nii.gz: probtrackx2_results/ring2/RAMYG2RNAcc/fdt_paths_thresh_%_bin.nii.gz /mnt/tpp/risktaking/roopa/MScThesis/lib/MNI152_T1_1mm_brain.nii.gz
	WarpImageMultiTransform 3 $< $@ -R $(word 2,$^) DTItoT11Warp.nii.gz DTItoT10GenericAffine.mat T1toStdSpc1Warp.nii.gz T1toStdSpc0GenericAffine.mat ;\
	fslmaths $@ -bin $@

probtrackx2_results/ring2/LPCG2LCrCe/FDT_THRESH_%_DTItoMNI_bin.nii.gz: probtrackx2_results/ring2/LPCG2LCrCe/fdt_paths_thresh_%_bin.nii.gz /mnt/tpp/risktaking/roopa/MScThesis/lib/MNI152_T1_1mm_brain.nii.gz
	WarpImageMultiTransform 3 $< $@ -R $(word 2,$^) DTItoT11Warp.nii.gz DTItoT10GenericAffine.mat T1toStdSpc1Warp.nii.gz T1toStdSpc0GenericAffine.mat ;\
	fslmaths $@ -bin $@

probtrackx2_results/ring2/RPCG2RCrCe/FDT_THRESH_%_DTItoMNI_bin.nii.gz: probtrackx2_results/ring2/RPCG2RCrCe/fdt_paths_thresh_%_bin.nii.gz /mnt/tpp/risktaking/roopa/MScThesis/lib/MNI152_T1_1mm_brain.nii.gz
	WarpImageMultiTransform 3 $< $@ -R $(word 2,$^) DTItoT11Warp.nii.gz DTItoT10GenericAffine.mat T1toStdSpc1Warp.nii.gz T1toStdSpc0GenericAffine.mat ;\
	fslmaths $@ -bin $@
