#RKPai 2018-12-09
#Makefile for tractography: registration of binarized thr1_XX tracts to FMRIB StdSpc (goal: thr2 by % of subjects with that voxel)
#23_DTI

SHELL=/bin/bash
export SHELL

export ANTSPATH=/usr/local/ANTs-2.1.0-rc3/bin/
export PATH:=${ANTSPATH}:$(PATH)

subject=$(notdir $(shell pwd))

all: thr_tracts

#probtrackx2_results/ring0/LAI2LNAcc/FDT_THRESH_%_DTItoFMRIB_bin.nii.gz probtrackx2_results/ring0/RAI2RNAcc/FDT_THRESH_%_DTItoFMRIB_bin.nii.gz probtrackx2_results/ring1/LAI2LNAcc/FDT_THRESH_%_DTItoFMRIB_bin.nii.gz probtrackx2_results/ring1/RAI2RNAcc/FDT_THRESH_%_DTItoFMRIB_bin.nii.gz

thr_tracts: probtrackx2_results/ring0/LAI2LNAcc/FDT_THRESH_00_DTItoFMRIB_bin.nii.gz probtrackx2_results/ring0/LAI2LNAcc/FDT_THRESH_05_DTItoFMRIB_bin.nii.gz probtrackx2_results/ring0/LAI2LNAcc/FDT_THRESH_10_DTItoFMRIB_bin.nii.gz probtrackx2_results/ring0/LAI2LNAcc/FDT_THRESH_15_DTItoFMRIB_bin.nii.gz probtrackx2_results/ring0/LAI2LNAcc/FDT_THRESH_20_DTItoFMRIB_bin.nii.gz probtrackx2_results/ring0/LAI2LNAcc/FDT_THRESH_25_DTItoFMRIB_bin.nii.gz probtrackx2_results/ring0/LAI2LNAcc/FDT_THRESH_30_DTItoFMRIB_bin.nii.gz probtrackx2_results/ring0/LAI2LNAcc/FDT_THRESH_35_DTItoFMRIB_bin.nii.gz probtrackx2_results/ring0/LAI2LNAcc/FDT_THRESH_40_DTItoFMRIB_bin.nii.gz probtrackx2_results/ring0/LAI2LNAcc/FDT_THRESH_45_DTItoFMRIB_bin.nii.gz probtrackx2_results/ring0/LAI2LNAcc/FDT_THRESH_50_DTItoFMRIB_bin.nii.gz probtrackx2_results/ring0/RAI2RNAcc/FDT_THRESH_00_DTItoFMRIB_bin.nii.gz probtrackx2_results/ring0/RAI2RNAcc/FDT_THRESH_05_DTItoFMRIB_bin.nii.gz probtrackx2_results/ring0/RAI2RNAcc/FDT_THRESH_10_DTItoFMRIB_bin.nii.gz probtrackx2_results/ring0/RAI2RNAcc/FDT_THRESH_15_DTItoFMRIB_bin.nii.gz probtrackx2_results/ring0/RAI2RNAcc/FDT_THRESH_20_DTItoFMRIB_bin.nii.gz probtrackx2_results/ring0/RAI2RNAcc/FDT_THRESH_25_DTItoFMRIB_bin.nii.gz probtrackx2_results/ring0/RAI2RNAcc/FDT_THRESH_30_DTItoFMRIB_bin.nii.gz probtrackx2_results/ring0/RAI2RNAcc/FDT_THRESH_35_DTItoFMRIB_bin.nii.gz probtrackx2_results/ring0/RAI2RNAcc/FDT_THRESH_40_DTItoFMRIB_bin.nii.gz probtrackx2_results/ring0/RAI2RNAcc/FDT_THRESH_45_DTItoFMRIB_bin.nii.gz probtrackx2_results/ring0/RAI2RNAcc/FDT_THRESH_50_DTItoFMRIB_bin.nii.gz probtrackx2_results/ring1/LAI2LNAcc/FDT_THRESH_00_DTItoFMRIB_bin.nii.gz probtrackx2_results/ring1/LAI2LNAcc/FDT_THRESH_05_DTItoFMRIB_bin.nii.gz probtrackx2_results/ring1/LAI2LNAcc/FDT_THRESH_10_DTItoFMRIB_bin.nii.gz probtrackx2_results/ring1/LAI2LNAcc/FDT_THRESH_15_DTItoFMRIB_bin.nii.gz probtrackx2_results/ring1/LAI2LNAcc/FDT_THRESH_20_DTItoFMRIB_bin.nii.gz probtrackx2_results/ring1/LAI2LNAcc/FDT_THRESH_25_DTItoFMRIB_bin.nii.gz probtrackx2_results/ring1/LAI2LNAcc/FDT_THRESH_30_DTItoFMRIB_bin.nii.gz probtrackx2_results/ring1/LAI2LNAcc/FDT_THRESH_35_DTItoFMRIB_bin.nii.gz probtrackx2_results/ring1/LAI2LNAcc/FDT_THRESH_40_DTItoFMRIB_bin.nii.gz probtrackx2_results/ring1/LAI2LNAcc/FDT_THRESH_45_DTItoFMRIB_bin.nii.gz probtrackx2_results/ring1/LAI2LNAcc/FDT_THRESH_50_DTItoFMRIB_bin.nii.gz probtrackx2_results/ring1/RAI2RNAcc/FDT_THRESH_00_DTItoFMRIB_bin.nii.gz probtrackx2_results/ring1/RAI2RNAcc/FDT_THRESH_05_DTItoFMRIB_bin.nii.gz probtrackx2_results/ring1/RAI2RNAcc/FDT_THRESH_10_DTItoFMRIB_bin.nii.gz probtrackx2_results/ring1/RAI2RNAcc/FDT_THRESH_15_DTItoFMRIB_bin.nii.gz probtrackx2_results/ring1/RAI2RNAcc/FDT_THRESH_20_DTItoFMRIB_bin.nii.gz probtrackx2_results/ring1/RAI2RNAcc/FDT_THRESH_25_DTItoFMRIB_bin.nii.gz probtrackx2_results/ring1/RAI2RNAcc/FDT_THRESH_30_DTItoFMRIB_bin.nii.gz probtrackx2_results/ring1/RAI2RNAcc/FDT_THRESH_35_DTItoFMRIB_bin.nii.gz probtrackx2_results/ring1/RAI2RNAcc/FDT_THRESH_40_DTItoFMRIB_bin.nii.gz probtrackx2_results/ring1/RAI2RNAcc/FDT_THRESH_45_DTItoFMRIB_bin.nii.gz probtrackx2_results/ring1/RAI2RNAcc/FDT_THRESH_50_DTItoFMRIB_bin.nii.gz

#(1) ring0
probtrackx2_results/ring0/LAI2LNAcc/FDT_THRESH_%_DTItoFMRIB_bin.nii.gz: probtrackx2_results/ring0/LAI2LNAcc/fdt_paths_thresh_%_bin.nii.gz /mnt/tpp/risktaking/roopa/MScThesis/lib/FMRIB58_FA_1mm.nii.gz
	WarpImageMultiTransform 3 $< $@ -R $(word 2,$^) DTI_FA_to_FMRIB_1mm_1Warp.nii.gz DTI_FA_to_FMRIB_1mm_0GenericAffine.mat ;\
	fslmaths $@ -bin $@

probtrackx2_results/ring0/LNAcc2LAI/FDT_THRESH_%_DTItoFMRIB_bin.nii.gz: probtrackx2_results/ring0/LNAcc2LAI/fdt_paths_thresh_%_bin.nii.gz /mnt/tpp/risktaking/roopa/MScThesis/lib/FMRIB58_FA_1mm.nii.gz
	WarpImageMultiTransform 3 $< $@ -R $(word 2,$^) DTI_FA_to_FMRIB_1mm_1Warp.nii.gz DTI_FA_to_FMRIB_1mm_0GenericAffine.mat ;\
	fslmaths $@ -bin $@

probtrackx2_results/ring0/RAI2RNAcc/FDT_THRESH_%_DTItoFMRIB_bin.nii.gz: probtrackx2_results/ring0/RAI2RNAcc/fdt_paths_thresh_%_bin.nii.gz /mnt/tpp/risktaking/roopa/MScThesis/lib/FMRIB58_FA_1mm.nii.gz
	WarpImageMultiTransform 3 $< $@ -R $(word 2,$^) DTI_FA_to_FMRIB_1mm_1Warp.nii.gz DTI_FA_to_FMRIB_1mm_0GenericAffine.mat ;\
	fslmaths $@ -bin $@

probtrackx2_results/ring0/RNAcc2RAI/FDT_THRESH_%_DTItoFMRIB_bin.nii.gz: probtrackx2_results/ring0/RNAcc2RAI/fdt_paths_thresh_%_bin.nii.gz /mnt/tpp/risktaking/roopa/MScThesis/lib/FMRIB58_FA_1mm.nii.gz
	WarpImageMultiTransform 3 $< $@ -R $(word 2,$^) DTI_FA_to_FMRIB_1mm_1Warp.nii.gz DTI_FA_to_FMRIB_1mm_0GenericAffine.mat ;\
	fslmaths $@ -bin $@
probtrackx2_results/ring0/LAMYG2LNAcc/FDT_THRESH_%_DTItoFMRIB_bin.nii.gz: probtrackx2_results/ring0/LAMYG2LNAcc/fdt_paths_thresh_%_bin.nii.gz /mnt/tpp/risktaking/roopa/MScThesis/lib/FMRIB58_FA_1mm.nii.gz
	WarpImageMultiTransform 3 $< $@ -R $(word 2,$^) DTI_FA_to_FMRIB_1mm_1Warp.nii.gz DTI_FA_to_FMRIB_1mm_0GenericAffine.mat ;\
	fslmaths $@ -bin $@

probtrackx2_results/ring0/RAMYG2RNAcc/FDT_THRESH_%_DTItoFMRIB_bin.nii.gz: probtrackx2_results/ring0/RAMYG2RNAcc/fdt_paths_thresh_%_bin.nii.gz /mnt/tpp/risktaking/roopa/MScThesis/lib/FMRIB58_FA_1mm.nii.gz
	WarpImageMultiTransform 3 $< $@ -R $(word 2,$^) DTI_FA_to_FMRIB_1mm_1Warp.nii.gz DTI_FA_to_FMRIB_1mm_0GenericAffine.mat ;\
	fslmaths $@ -bin $@

probtrackx2_results/ring0/LPCG2LCrCe/FDT_THRESH_%_DTItoFMRIB_bin.nii.gz: probtrackx2_results/ring0/LPCG2LCrCe/fdt_paths_thresh_%_bin.nii.gz /mnt/tpp/risktaking/roopa/MScThesis/lib/FMRIB58_FA_1mm.nii.gz
	WarpImageMultiTransform 3 $< $@ -R $(word 2,$^) DTI_FA_to_FMRIB_1mm_1Warp.nii.gz DTI_FA_to_FMRIB_1mm_0GenericAffine.mat ;\
	fslmaths $@ -bin $@

probtrackx2_results/ring0/RPCG2RCrCe/FDT_THRESH_%_DTItoFMRIB_bin.nii.gz: probtrackx2_results/ring0/RPCG2RCrCe/fdt_paths_thresh_%_bin.nii.gz /mnt/tpp/risktaking/roopa/MScThesis/lib/FMRIB58_FA_1mm.nii.gz
	WarpImageMultiTransform 3 $< $@ -R $(word 2,$^) DTI_FA_to_FMRIB_1mm_1Warp.nii.gz DTI_FA_to_FMRIB_1mm_0GenericAffine.mat ;\
	fslmaths $@ -bin $@

#(2) ring1
probtrackx2_results/ring1/LAI2LNAcc/FDT_THRESH_%_DTItoFMRIB_bin.nii.gz: probtrackx2_results/ring1/LAI2LNAcc/fdt_paths_thresh_%_bin.nii.gz /mnt/tpp/risktaking/roopa/MScThesis/lib/FMRIB58_FA_1mm.nii.gz
	WarpImageMultiTransform 3 $< $@ -R $(word 2,$^) DTI_FA_to_FMRIB_1mm_1Warp.nii.gz DTI_FA_to_FMRIB_1mm_0GenericAffine.mat ;\
	fslmaths $@ -bin $@

probtrackx2_results/ring1/LNAcc2LAI/FDT_THRESH_%_DTItoFMRIB_bin.nii.gz: probtrackx2_results/ring1/LNAcc2LAI/fdt_paths_thresh_%_bin.nii.gz /mnt/tpp/risktaking/roopa/MScThesis/lib/FMRIB58_FA_1mm.nii.gz
	WarpImageMultiTransform 3 $< $@ -R $(word 2,$^) DTI_FA_to_FMRIB_1mm_1Warp.nii.gz DTI_FA_to_FMRIB_1mm_0GenericAffine.mat ;\
	fslmaths $@ -bin $@

probtrackx2_results/ring1/RAI2RNAcc/FDT_THRESH_%_DTItoFMRIB_bin.nii.gz: probtrackx2_results/ring1/RAI2RNAcc/fdt_paths_thresh_%_bin.nii.gz /mnt/tpp/risktaking/roopa/MScThesis/lib/FMRIB58_FA_1mm.nii.gz
	WarpImageMultiTransform 3 $< $@ -R $(word 2,$^) DTI_FA_to_FMRIB_1mm_1Warp.nii.gz DTI_FA_to_FMRIB_1mm_0GenericAffine.mat ;\
	fslmaths $@ -bin $@

probtrackx2_results/ring1/RNAcc2RAI/FDT_THRESH_%_DTItoFMRIB_bin.nii.gz: probtrackx2_results/ring1/RNAcc2RAI/fdt_paths_thresh_%_bin.nii.gz /mnt/tpp/risktaking/roopa/MScThesis/lib/FMRIB58_FA_1mm.nii.gz
	WarpImageMultiTransform 3 $< $@ -R $(word 2,$^) DTI_FA_to_FMRIB_1mm_1Warp.nii.gz DTI_FA_to_FMRIB_1mm_0GenericAffine.mat ;\
	fslmaths $@ -bin $@

probtrackx2_results/ring1/LAMYG2LNAcc/FDT_THRESH_%_DTItoFMRIB_bin.nii.gz: probtrackx2_results/ring1/LAMYG2LNAcc/fdt_paths_thresh_%_bin.nii.gz /mnt/tpp/risktaking/roopa/MScThesis/lib/FMRIB58_FA_1mm.nii.gz
	WarpImageMultiTransform 3 $< $@ -R $(word 2,$^) DTI_FA_to_FMRIB_1mm_1Warp.nii.gz DTI_FA_to_FMRIB_1mm_0GenericAffine.mat ;\
	fslmaths $@ -bin $@

probtrackx2_results/ring1/RAMYG2RNAcc/FDT_THRESH_%_DTItoFMRIB_bin.nii.gz: probtrackx2_results/ring1/RAMYG2RNAcc/fdt_paths_thresh_%_bin.nii.gz /mnt/tpp/risktaking/roopa/MScThesis/lib/FMRIB58_FA_1mm.nii.gz
	WarpImageMultiTransform 3 $< $@ -R $(word 2,$^) DTI_FA_to_FMRIB_1mm_1Warp.nii.gz DTI_FA_to_FMRIB_1mm_0GenericAffine.mat ;\
	fslmaths $@ -bin $@

probtrackx2_results/ring1/LPCG2LCrCe/FDT_THRESH_%_DTItoFMRIB_bin.nii.gz: probtrackx2_results/ring1/LPCG2LCrCe/fdt_paths_thresh_%_bin.nii.gz /mnt/tpp/risktaking/roopa/MScThesis/lib/FMRIB58_FA_1mm.nii.gz
	WarpImageMultiTransform 3 $< $@ -R $(word 2,$^) DTI_FA_to_FMRIB_1mm_1Warp.nii.gz DTI_FA_to_FMRIB_1mm_0GenericAffine.mat ;\
	fslmaths $@ -bin $@

probtrackx2_results/ring1/RPCG2RCrCe/FDT_THRESH_%_DTItoFMRIB_bin.nii.gz: probtrackx2_results/ring1/RPCG2RCrCe/fdt_paths_thresh_%_bin.nii.gz /mnt/tpp/risktaking/roopa/MScThesis/lib/FMRIB58_FA_1mm.nii.gz
	WarpImageMultiTransform 3 $< $@ -R $(word 2,$^) DTI_FA_to_FMRIB_1mm_1Warp.nii.gz DTI_FA_to_FMRIB_1mm_0GenericAffine.mat ;\
	fslmaths $@ -bin $@

#(3) ring2
probtrackx2_results/ring2/LAI2LNAcc/FDT_THRESH_%_DTItoFMRIB_bin.nii.gz: probtrackx2_results/ring2/LAI2LNAcc/fdt_paths_thresh_%_bin.nii.gz /mnt/tpp/risktaking/roopa/MScThesis/lib/FMRIB58_FA_1mm.nii.gz
	WarpImageMultiTransform 3 $< $@ -R $(word 2,$^) DTI_FA_to_FMRIB_1mm_1Warp.nii.gz DTI_FA_to_FMRIB_1mm_0GenericAffine.mat ;\
	fslmaths $@ -bin $@

probtrackx2_results/ring2/LNAcc2LAI/FDT_THRESH_%_DTItoFMRIB_bin.nii.gz: probtrackx2_results/ring2/LNAcc2LAI/fdt_paths_thresh_%_bin.nii.gz /mnt/tpp/risktaking/roopa/MScThesis/lib/FMRIB58_FA_1mm.nii.gz
	WarpImageMultiTransform 3 $< $@ -R $(word 2,$^) DTI_FA_to_FMRIB_1mm_1Warp.nii.gz DTI_FA_to_FMRIB_1mm_0GenericAffine.mat ;\
	fslmaths $@ -bin $@

probtrackx2_results/ring2/RAI2RNAcc/FDT_THRESH_%_DTItoFMRIB_bin.nii.gz: probtrackx2_results/ring2/RAI2RNAcc/fdt_paths_thresh_%_bin.nii.gz /mnt/tpp/risktaking/roopa/MScThesis/lib/FMRIB58_FA_1mm.nii.gz
	WarpImageMultiTransform 3 $< $@ -R $(word 2,$^) DTI_FA_to_FMRIB_1mm_1Warp.nii.gz DTI_FA_to_FMRIB_1mm_0GenericAffine.mat ;\
	fslmaths $@ -bin $@

probtrackx2_results/ring2/RNAcc2RAI/FDT_THRESH_%_DTItoFMRIB_bin.nii.gz: probtrackx2_results/ring2/RNAcc2RAI/fdt_paths_thresh_%_bin.nii.gz /mnt/tpp/risktaking/roopa/MScThesis/lib/FMRIB58_FA_1mm.nii.gz
	WarpImageMultiTransform 3 $< $@ -R $(word 2,$^) DTI_FA_to_FMRIB_1mm_1Warp.nii.gz DTI_FA_to_FMRIB_1mm_0GenericAffine.mat ;\
	fslmaths $@ -bin $@

probtrackx2_results/ring2/LAMYG2LNAcc/FDT_THRESH_%_DTItoFMRIB_bin.nii.gz: probtrackx2_results/ring2/LAMYG2LNAcc/fdt_paths_thresh_%_bin.nii.gz /mnt/tpp/risktaking/roopa/MScThesis/lib/FMRIB58_FA_1mm.nii.gz
	WarpImageMultiTransform 3 $< $@ -R $(word 2,$^) DTI_FA_to_FMRIB_1mm_1Warp.nii.gz DTI_FA_to_FMRIB_1mm_0GenericAffine.mat ;\
	fslmaths $@ -bin $@

probtrackx2_results/ring2/RAMYG2RNAcc/FDT_THRESH_%_DTItoFMRIB_bin.nii.gz: probtrackx2_results/ring2/RAMYG2RNAcc/fdt_paths_thresh_%_bin.nii.gz /mnt/tpp/risktaking/roopa/MScThesis/lib/FMRIB58_FA_1mm.nii.gz
	WarpImageMultiTransform 3 $< $@ -R $(word 2,$^) DTI_FA_to_FMRIB_1mm_1Warp.nii.gz DTI_FA_to_FMRIB_1mm_0GenericAffine.mat ;\
	fslmaths $@ -bin $@

probtrackx2_results/ring2/LPCG2LCrCe/FDT_THRESH_%_DTItoFMRIB_bin.nii.gz: probtrackx2_results/ring2/LPCG2LCrCe/fdt_paths_thresh_%_bin.nii.gz /mnt/tpp/risktaking/roopa/MScThesis/lib/FMRIB58_FA_1mm.nii.gz
	WarpImageMultiTransform 3 $< $@ -R $(word 2,$^) DTI_FA_to_FMRIB_1mm_1Warp.nii.gz DTI_FA_to_FMRIB_1mm_0GenericAffine.mat ;\
	fslmaths $@ -bin $@

probtrackx2_results/ring2/RPCG2RCrCe/FDT_THRESH_%_DTItoFMRIB_bin.nii.gz: probtrackx2_results/ring2/RPCG2RCrCe/fdt_paths_thresh_%_bin.nii.gz /mnt/tpp/risktaking/roopa/MScThesis/lib/FMRIB58_FA_1mm.nii.gz
	WarpImageMultiTransform 3 $< $@ -R $(word 2,$^) DTI_FA_to_FMRIB_1mm_1Warp.nii.gz DTI_FA_to_FMRIB_1mm_0GenericAffine.mat ;\
	fslmaths $@ -bin $@
