# RKPai 18.11.24
#requires new mkdir script to create val_extraction directory structure
#just for Roopa script
# 17_DTI (functional, but with self-extraction)
# Objectives: extract mean FA, MD, AxD & RD values for our tracts

SHELL=/bin/bash
export SHELL

subject=$(notdir $(shell pwd))

all: Extraction_Roopa

#II. value extraction using masks I made: bil. AI2NAcc & controls

#/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/FA/LAI2LNAcc/ring0/thr1_%/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/FA/RAI2RNAcc/ring0/thr1_%/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/MD/LAI2LNAcc/ring0/thr1_%/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/MD/RAI2RNAcc/ring0/thr1_%/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/AxD/LAI2LNAcc/ring0/thr1_%/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/AxD/RAI2RNAcc/ring0/thr1_%/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/RD/LAI2LNAcc/ring0/thr1_%/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/RD/RAI2RNAcc/ring0/thr1_%/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/FA/LAI2LNAcc/ring1/thr1_%/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/FA/RAI2RNAcc/ring1/thr1_%/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/MD/LAI2LNAcc/ring1/thr1_%/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/MD/RAI2RNAcc/ring1/thr1_%/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/AxD/LAI2LNAcc/ring1/thr1_%/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/AxD/RAI2RNAcc/ring1/thr1_%/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/RD/LAI2LNAcc/ring1/thr1_%/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/RD/RAI2RNAcc/ring1/thr1_%/$(subject)

#A. ring0
#(1) FA
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/FA/LAI2LNAcc/ring0/thr1_%/$(subject): DTI_fit_FA.nii.gz probtrackx2_results/ring0/LAI2LNAcc/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/FA/RAI2RNAcc/ring0/thr1_%/$(subject): DTI_fit_FA.nii.gz probtrackx2_results/ring0/RAI2RNAcc/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/FA/LNAcc2LAI/ring0/thr1_%/$(subject): DTI_fit_FA.nii.gz probtrackx2_results/ring0/LNAcc2LAI/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/FA/RNAcc2RAI/ring0/thr1_%/$(subject): DTI_fit_FA.nii.gz probtrackx2_results/ring0/RNAcc2RAI/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/FA/LAMYG2LNAcc/ring0/thr1_%/$(subject): DTI_fit_FA.nii.gz probtrackx2_results/ring0/LAMYG2LNAcc/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/FA/RAMYG2RNAcc/ring0/thr1_%/$(subject): DTI_fit_FA.nii.gz probtrackx2_results/ring0/RAMYG2RNAcc/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/FA/LPCG2LCrCe/ring0/thr1_%/$(subject): DTI_fit_FA.nii.gz probtrackx2_results/ring0/LPCG2LCrCe/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/FA/RPCG2RCrCe/ring0/thr1_%/$(subject): DTI_fit_FA.nii.gz probtrackx2_results/ring0/RPCG2RCrCe/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@

#(2) MD
#test
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/MD/LAI2LNAcc/ring0/thr1_%/$(subject): DTI_fit_MD.nii.gz probtrackx2_results/ring0/LAI2LNAcc/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/MD/RAI2RNAcc/ring0/thr1_%/$(subject): DTI_fit_MD.nii.gz probtrackx2_results/ring0/RAI2RNAcc/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/MD/LNAcc2LAI/ring0/thr1_%/$(subject): DTI_fit_MD.nii.gz probtrackx2_results/ring0/LNAcc2LAI/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/MD/RNAcc2RAI/ring0/thr1_%/$(subject): DTI_fit_MD.nii.gz probtrackx2_results/ring0/RNAcc2RAI/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/MD/LAMYG2LNAcc/ring0/thr1_%/$(subject): DTI_fit_MD.nii.gz probtrackx2_results/ring0/LAMYG2LNAcc/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/MD/RAMYG2RNAcc/ring0/thr1_%/$(subject): DTI_fit_MD.nii.gz probtrackx2_results/ring0/RAMYG2RNAcc/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/MD/LPCG2LCrCe/ring0/thr1_%/$(subject): DTI_fit_MD.nii.gz probtrackx2_results/ring0/LPCG2LCrCe/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/MD/RPCG2RCrCe/ring0/thr1_%/$(subject): DTI_fit_MD.nii.gz probtrackx2_results/ring0/RPCG2RCrCe/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@

#(3) AxD
#test
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/AxD/LAI2LNAcc/ring0/thr1_%/$(subject): DTI_fit_L1.nii.gz probtrackx2_results/ring0/LAI2LNAcc/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/AxD/RAI2RNAcc/ring0/thr1_%/$(subject): DTI_fit_L1.nii.gz probtrackx2_results/ring0/RAI2RNAcc/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/AxD/LNAcc2LAI/ring0/thr1_%/$(subject): DTI_fit_L1.nii.gz probtrackx2_results/ring0/LNAcc2LAI/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/AxD/RNAcc2RAI/ring0/thr1_%/$(subject): DTI_fit_L1.nii.gz probtrackx2_results/ring0/RNAcc2RAI/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@

/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/AxD/LAMYG2LNAcc/ring0/thr1_%/$(subject): DTI_fit_L1.nii.gz probtrackx2_results/ring0/LAMYG2LNAcc/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/AxD/RAMYG2RNAcc/ring0/thr1_%/$(subject): DTI_fit_L1.nii.gz probtrackx2_results/ring0/RAMYG2RNAcc/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/AxD/LPCG2LCrCe/ring0/thr1_%/$(subject): DTI_fit_L1.nii.gz probtrackx2_results/ring0/LPCG2LCrCe/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/AxD/RPCG2RCrCe/ring0/thr1_%/$(subject): DTI_fit_L1.nii.gz probtrackx2_results/ring0/RPCG2RCrCe/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@
#(4) RD
#test
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/RD/LAI2LNAcc/ring0/thr1_%/$(subject): DTI_fit_RD.nii.gz probtrackx2_results/ring0/LAI2LNAcc/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/RD/RAI2RNAcc/ring0/thr1_%/$(subject): DTI_fit_RD.nii.gz probtrackx2_results/ring0/RAI2RNAcc/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/RD/LNAcc2LAI/ring0/thr1_%/$(subject): DTI_fit_RD.nii.gz probtrackx2_results/ring0/LNAcc2LAI/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/RD/RNAcc2RAI/ring0/thr1_%/$(subject): DTI_fit_RD.nii.gz probtrackx2_results/ring0/RNAcc2RAI/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@

/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/RD/LAMYG2LNAcc/ring0/thr1_%/$(subject): DTI_fit_RD.nii.gz probtrackx2_results/ring0/LAMYG2LNAcc/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/RD/RAMYG2RNAcc/ring0/thr1_%/$(subject): DTI_fit_RD.nii.gz probtrackx2_results/ring0/RAMYG2RNAcc/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/RD/LPCG2LCrCe/ring0/thr1_%/$(subject): DTI_fit_RD.nii.gz probtrackx2_results/ring0/LPCG2LCrCe/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/RD/RPCG2RCrCe/ring0/thr1_%/$(subject): DTI_fit_RD.nii.gz probtrackx2_results/ring0/RPCG2RCrCe/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@

#B. ring1
#(1) FA
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/FA/LAI2LNAcc/ring1/thr1_%/$(subject): DTI_fit_FA.nii.gz probtrackx2_results/ring1/LAI2LNAcc/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/FA/RAI2RNAcc/ring1/thr1_%/$(subject): DTI_fit_FA.nii.gz probtrackx2_results/ring1/RAI2RNAcc/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/FA/LNAcc2LAI/ring1/thr1_%/$(subject): DTI_fit_FA.nii.gz probtrackx2_results/ring1/LNAcc2LAI/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/FA/RNAcc2RAI/ring1/thr1_%/$(subject): DTI_fit_FA.nii.gz probtrackx2_results/ring1/RNAcc2RAI/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/FA/LAMYG2LNAcc/ring1/thr1_%/$(subject): DTI_fit_FA.nii.gz probtrackx2_results/ring1/LAMYG2LNAcc/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/FA/RAMYG2RNAcc/ring1/thr1_%/$(subject): DTI_fit_FA.nii.gz probtrackx2_results/ring1/RAMYG2RNAcc/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/FA/LPCG2LCrCe/ring1/thr1_%/$(subject): DTI_fit_FA.nii.gz probtrackx2_results/ring1/LPCG2LCrCe/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/FA/RPCG2RCrCe/ring1/thr1_%/$(subject): DTI_fit_FA.nii.gz probtrackx2_results/ring1/RPCG2RCrCe/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@

#(2) MD
#test
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/MD/LAI2LNAcc/ring1/thr1_%/$(subject): DTI_fit_MD.nii.gz probtrackx2_results/ring1/LAI2LNAcc/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/MD/RAI2RNAcc/ring1/thr1_%/$(subject): DTI_fit_MD.nii.gz probtrackx2_results/ring1/RAI2RNAcc/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/MD/LNAcc2LAI/ring1/thr1_%/$(subject): DTI_fit_MD.nii.gz probtrackx2_results/ring1/LNAcc2LAI/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/MD/RNAcc2RAI/ring1/thr1_%/$(subject): DTI_fit_MD.nii.gz probtrackx2_results/ring1/RNAcc2RAI/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/MD/LAMYG2LNAcc/ring1/thr1_%/$(subject): DTI_fit_MD.nii.gz probtrackx2_results/ring1/LAMYG2LNAcc/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/MD/RAMYG2RNAcc/ring1/thr1_%/$(subject): DTI_fit_MD.nii.gz probtrackx2_results/ring1/RAMYG2RNAcc/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/MD/LPCG2LCrCe/ring1/thr1_%/$(subject): DTI_fit_MD.nii.gz probtrackx2_results/ring1/LPCG2LCrCe/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/MD/RPCG2RCrCe/ring1/thr1_%/$(subject): DTI_fit_MD.nii.gz probtrackx2_results/ring1/RPCG2RCrCe/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@

#(3) AxD
#test
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/AxD/LAI2LNAcc/ring1/thr1_%/$(subject): DTI_fit_L1.nii.gz probtrackx2_results/ring1/LAI2LNAcc/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/AxD/RAI2RNAcc/ring1/thr1_%/$(subject): DTI_fit_L1.nii.gz probtrackx2_results/ring1/RAI2RNAcc/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/AxD/LNAcc2LAI/ring1/thr1_%/$(subject): DTI_fit_L1.nii.gz probtrackx2_results/ring1/LNAcc2LAI/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/AxD/RNAcc2RAI/ring1/thr1_%/$(subject): DTI_fit_L1.nii.gz probtrackx2_results/ring1/RNAcc2RAI/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@

/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/AxD/LAMYG2LNAcc/ring1/thr1_%/$(subject): DTI_fit_L1.nii.gz probtrackx2_results/ring1/LAMYG2LNAcc/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/AxD/RAMYG2RNAcc/ring1/thr1_%/$(subject): DTI_fit_L1.nii.gz probtrackx2_results/ring1/RAMYG2RNAcc/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/AxD/LPCG2LCrCe/ring1/thr1_%/$(subject): DTI_fit_L1.nii.gz probtrackx2_results/ring1/LPCG2LCrCe/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/AxD/RPCG2RCrCe/ring1/thr1_%/$(subject): DTI_fit_L1.nii.gz probtrackx2_results/ring1/RPCG2RCrCe/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@
#(4) RD
#test
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/RD/LAI2LNAcc/ring1/thr1_%/$(subject): DTI_fit_RD.nii.gz probtrackx2_results/ring1/LAI2LNAcc/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/RD/RAI2RNAcc/ring1/thr1_%/$(subject): DTI_fit_RD.nii.gz probtrackx2_results/ring1/RAI2RNAcc/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/RD/LNAcc2LAI/ring1/thr1_%/$(subject): DTI_fit_RD.nii.gz probtrackx2_results/ring1/LNAcc2LAI/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/RD/RNAcc2RAI/ring1/thr1_%/$(subject): DTI_fit_RD.nii.gz probtrackx2_results/ring1/RNAcc2RAI/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@

/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/RD/LAMYG2LNAcc/ring1/thr1_%/$(subject): DTI_fit_RD.nii.gz probtrackx2_results/ring1/LAMYG2LNAcc/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/RD/RAMYG2RNAcc/ring1/thr1_%/$(subject): DTI_fit_RD.nii.gz probtrackx2_results/ring1/RAMYG2RNAcc/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/RD/LPCG2LCrCe/ring1/thr1_%/$(subject): DTI_fit_RD.nii.gz probtrackx2_results/ring1/LPCG2LCrCe/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/RD/RPCG2RCrCe/ring1/thr1_%/$(subject): DTI_fit_RD.nii.gz probtrackx2_results/ring1/RPCG2RCrCe/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@

#C. ring2
#(1) FA
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/FA/LAI2LNAcc/ring2/thr1_%/$(subject): DTI_fit_FA.nii.gz probtrackx2_results/ring2/LAI2LNAcc/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/FA/RAI2RNAcc/ring2/thr1_%/$(subject): DTI_fit_FA.nii.gz probtrackx2_results/ring2/RAI2RNAcc/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/FA/LNAcc2LAI/ring2/thr1_%/$(subject): DTI_fit_FA.nii.gz probtrackx2_results/ring2/LNAcc2LAI/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/FA/RNAcc2RAI/ring2/thr1_%/$(subject): DTI_fit_FA.nii.gz probtrackx2_results/ring2/RNAcc2RAI/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/FA/LAMYG2LNAcc/ring2/thr1_%/$(subject): DTI_fit_FA.nii.gz probtrackx2_results/ring2/LAMYG2LNAcc/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/FA/RAMYG2RNAcc/ring2/thr1_%/$(subject): DTI_fit_FA.nii.gz probtrackx2_results/ring2/RAMYG2RNAcc/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/FA/LPCG2LCrCe/ring2/thr1_%/$(subject): DTI_fit_FA.nii.gz probtrackx2_results/ring2/LPCG2LCrCe/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/FA/RPCG2RCrCe/ring2/thr1_%/$(subject): DTI_fit_FA.nii.gz probtrackx2_results/ring2/RPCG2RCrCe/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@

#(2) MD
#test
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/MD/LAI2LNAcc/ring2/thr1_%/$(subject): DTI_fit_MD.nii.gz probtrackx2_results/ring2/LAI2LNAcc/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/MD/RAI2RNAcc/ring2/thr1_%/$(subject): DTI_fit_MD.nii.gz probtrackx2_results/ring2/RAI2RNAcc/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/MD/LNAcc2LAI/ring2/thr1_%/$(subject): DTI_fit_MD.nii.gz probtrackx2_results/ring2/LNAcc2LAI/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/MD/RNAcc2RAI/ring2/thr1_%/$(subject): DTI_fit_MD.nii.gz probtrackx2_results/ring2/RNAcc2RAI/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/MD/LAMYG2LNAcc/ring2/thr1_%/$(subject): DTI_fit_MD.nii.gz probtrackx2_results/ring2/LAMYG2LNAcc/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/MD/RAMYG2RNAcc/ring2/thr1_%/$(subject): DTI_fit_MD.nii.gz probtrackx2_results/ring2/RAMYG2RNAcc/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/MD/LPCG2LCrCe/ring2/thr1_%/$(subject): DTI_fit_MD.nii.gz probtrackx2_results/ring2/LPCG2LCrCe/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/MD/RPCG2RCrCe/ring2/thr1_%/$(subject): DTI_fit_MD.nii.gz probtrackx2_results/ring2/RPCG2RCrCe/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@

#(3) AxD
#test
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/AxD/LAI2LNAcc/ring2/thr1_%/$(subject): DTI_fit_L1.nii.gz probtrackx2_results/ring2/LAI2LNAcc/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/AxD/RAI2RNAcc/ring2/thr1_%/$(subject): DTI_fit_L1.nii.gz probtrackx2_results/ring2/RAI2RNAcc/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/AxD/LNAcc2LAI/ring2/thr1_%/$(subject): DTI_fit_L1.nii.gz probtrackx2_results/ring2/LNAcc2LAI/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/AxD/RNAcc2RAI/ring2/thr1_%/$(subject): DTI_fit_L1.nii.gz probtrackx2_results/ring2/RNAcc2RAI/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@

/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/AxD/LAMYG2LNAcc/ring2/thr1_%/$(subject): DTI_fit_L1.nii.gz probtrackx2_results/ring2/LAMYG2LNAcc/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/AxD/RAMYG2RNAcc/ring2/thr1_%/$(subject): DTI_fit_L1.nii.gz probtrackx2_results/ring2/RAMYG2RNAcc/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/AxD/LPCG2LCrCe/ring2/thr1_%/$(subject): DTI_fit_L1.nii.gz probtrackx2_results/ring2/LPCG2LCrCe/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/AxD/RPCG2RCrCe/ring2/thr1_%/$(subject): DTI_fit_L1.nii.gz probtrackx2_results/ring2/RPCG2RCrCe/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@
#(4) RD
#test
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/RD/LAI2LNAcc/ring2/thr1_%/$(subject): DTI_fit_RD.nii.gz probtrackx2_results/ring2/LAI2LNAcc/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/RD/RAI2RNAcc/ring2/thr1_%/$(subject): DTI_fit_RD.nii.gz probtrackx2_results/ring2/RAI2RNAcc/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/RD/LNAcc2LAI/ring2/thr1_%/$(subject): DTI_fit_RD.nii.gz probtrackx2_results/ring2/LNAcc2LAI/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/RD/RNAcc2RAI/ring2/thr1_%/$(subject): DTI_fit_RD.nii.gz probtrackx2_results/ring2/RNAcc2RAI/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@

/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/RD/LAMYG2LNAcc/ring2/thr1_%/$(subject): DTI_fit_RD.nii.gz probtrackx2_results/ring2/LAMYG2LNAcc/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/RD/RAMYG2RNAcc/ring2/thr1_%/$(subject): DTI_fit_RD.nii.gz probtrackx2_results/ring2/RAMYG2RNAcc/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/RD/LPCG2LCrCe/ring2/thr1_%/$(subject): DTI_fit_RD.nii.gz probtrackx2_results/ring2/LPCG2LCrCe/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@
/mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/RD/RPCG2RCrCe/ring2/thr1_%/$(subject): DTI_fit_RD.nii.gz probtrackx2_results/ring2/RPCG2RCrCe/fdt_paths_thresh_%_bin.nii.gz
	fslstats $< -k $(word 2,$^) -M > $@

Extraction_Roopa: /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/FA/LAI2LNAcc/ring0/thr1_00/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/FA/LAI2LNAcc/ring0/thr1_05/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/FA/LAI2LNAcc/ring0/thr1_10/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/FA/LAI2LNAcc/ring0/thr1_15/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/FA/LAI2LNAcc/ring0/thr1_20/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/FA/LAI2LNAcc/ring0/thr1_25/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/FA/LAI2LNAcc/ring0/thr1_30/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/FA/LAI2LNAcc/ring0/thr1_35/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/FA/LAI2LNAcc/ring0/thr1_40/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/FA/LAI2LNAcc/ring0/thr1_45/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/FA/LAI2LNAcc/ring0/thr1_50/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/FA/RAI2RNAcc/ring0/thr1_00/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/FA/RAI2RNAcc/ring0/thr1_05/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/FA/RAI2RNAcc/ring0/thr1_10/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/FA/RAI2RNAcc/ring0/thr1_15/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/FA/RAI2RNAcc/ring0/thr1_20/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/FA/RAI2RNAcc/ring0/thr1_25/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/FA/RAI2RNAcc/ring0/thr1_30/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/FA/RAI2RNAcc/ring0/thr1_35/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/FA/RAI2RNAcc/ring0/thr1_40/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/FA/RAI2RNAcc/ring0/thr1_45/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/FA/RAI2RNAcc/ring0/thr1_50/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/MD/LAI2LNAcc/ring0/thr1_00/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/MD/LAI2LNAcc/ring0/thr1_05/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/MD/LAI2LNAcc/ring0/thr1_10/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/MD/LAI2LNAcc/ring0/thr1_15/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/MD/LAI2LNAcc/ring0/thr1_20/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/MD/LAI2LNAcc/ring0/thr1_25/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/MD/LAI2LNAcc/ring0/thr1_30/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/MD/LAI2LNAcc/ring0/thr1_35/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/MD/LAI2LNAcc/ring0/thr1_40/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/MD/LAI2LNAcc/ring0/thr1_45/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/MD/LAI2LNAcc/ring0/thr1_50/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/MD/RAI2RNAcc/ring0/thr1_00/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/MD/RAI2RNAcc/ring0/thr1_05/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/MD/RAI2RNAcc/ring0/thr1_10/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/MD/RAI2RNAcc/ring0/thr1_15/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/MD/RAI2RNAcc/ring0/thr1_20/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/MD/RAI2RNAcc/ring0/thr1_25/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/MD/RAI2RNAcc/ring0/thr1_30/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/MD/RAI2RNAcc/ring0/thr1_35/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/MD/RAI2RNAcc/ring0/thr1_40/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/MD/RAI2RNAcc/ring0/thr1_45/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/MD/RAI2RNAcc/ring0/thr1_50/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/AxD/LAI2LNAcc/ring0/thr1_00/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/AxD/LAI2LNAcc/ring0/thr1_05/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/AxD/LAI2LNAcc/ring0/thr1_10/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/AxD/LAI2LNAcc/ring0/thr1_15/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/AxD/LAI2LNAcc/ring0/thr1_20/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/AxD/LAI2LNAcc/ring0/thr1_25/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/AxD/LAI2LNAcc/ring0/thr1_30/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/AxD/LAI2LNAcc/ring0/thr1_35/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/AxD/LAI2LNAcc/ring0/thr1_40/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/AxD/LAI2LNAcc/ring0/thr1_45/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/AxD/LAI2LNAcc/ring0/thr1_50/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/AxD/RAI2RNAcc/ring0/thr1_00/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/AxD/RAI2RNAcc/ring0/thr1_05/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/AxD/RAI2RNAcc/ring0/thr1_10/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/AxD/RAI2RNAcc/ring0/thr1_15/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/AxD/RAI2RNAcc/ring0/thr1_20/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/AxD/RAI2RNAcc/ring0/thr1_25/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/AxD/RAI2RNAcc/ring0/thr1_30/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/AxD/RAI2RNAcc/ring0/thr1_35/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/AxD/RAI2RNAcc/ring0/thr1_40/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/AxD/RAI2RNAcc/ring0/thr1_45/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/AxD/RAI2RNAcc/ring0/thr1_50/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/RD/LAI2LNAcc/ring0/thr1_00/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/RD/LAI2LNAcc/ring0/thr1_05/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/RD/LAI2LNAcc/ring0/thr1_10/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/RD/LAI2LNAcc/ring0/thr1_15/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/RD/LAI2LNAcc/ring0/thr1_20/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/RD/LAI2LNAcc/ring0/thr1_25/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/RD/LAI2LNAcc/ring0/thr1_30/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/RD/LAI2LNAcc/ring0/thr1_35/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/RD/LAI2LNAcc/ring0/thr1_40/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/RD/LAI2LNAcc/ring0/thr1_45/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/RD/LAI2LNAcc/ring0/thr1_50/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/RD/RAI2RNAcc/ring0/thr1_00/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/RD/RAI2RNAcc/ring0/thr1_05/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/RD/RAI2RNAcc/ring0/thr1_10/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/RD/RAI2RNAcc/ring0/thr1_15/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/RD/RAI2RNAcc/ring0/thr1_20/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/RD/RAI2RNAcc/ring0/thr1_25/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/RD/RAI2RNAcc/ring0/thr1_30/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/RD/RAI2RNAcc/ring0/thr1_35/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/RD/RAI2RNAcc/ring0/thr1_40/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/RD/RAI2RNAcc/ring0/thr1_45/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/RD/RAI2RNAcc/ring0/thr1_50/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/FA/LAI2LNAcc/ring1/thr1_00/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/FA/LAI2LNAcc/ring1/thr1_05/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/FA/LAI2LNAcc/ring1/thr1_10/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/FA/LAI2LNAcc/ring1/thr1_15/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/FA/LAI2LNAcc/ring1/thr1_20/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/FA/LAI2LNAcc/ring1/thr1_25/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/FA/LAI2LNAcc/ring1/thr1_30/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/FA/LAI2LNAcc/ring1/thr1_35/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/FA/LAI2LNAcc/ring1/thr1_40/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/FA/LAI2LNAcc/ring1/thr1_45/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/FA/LAI2LNAcc/ring1/thr1_50/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/FA/RAI2RNAcc/ring1/thr1_00/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/FA/RAI2RNAcc/ring1/thr1_05/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/FA/RAI2RNAcc/ring1/thr1_10/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/FA/RAI2RNAcc/ring1/thr1_15/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/FA/RAI2RNAcc/ring1/thr1_20/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/FA/RAI2RNAcc/ring1/thr1_25/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/FA/RAI2RNAcc/ring1/thr1_30/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/FA/RAI2RNAcc/ring1/thr1_35/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/FA/RAI2RNAcc/ring1/thr1_40/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/FA/RAI2RNAcc/ring1/thr1_45/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/FA/RAI2RNAcc/ring1/thr1_50/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/MD/LAI2LNAcc/ring1/thr1_00/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/MD/LAI2LNAcc/ring1/thr1_05/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/MD/LAI2LNAcc/ring1/thr1_10/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/MD/LAI2LNAcc/ring1/thr1_15/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/MD/LAI2LNAcc/ring1/thr1_20/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/MD/LAI2LNAcc/ring1/thr1_25/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/MD/LAI2LNAcc/ring1/thr1_30/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/MD/LAI2LNAcc/ring1/thr1_35/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/MD/LAI2LNAcc/ring1/thr1_40/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/MD/LAI2LNAcc/ring1/thr1_45/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/MD/LAI2LNAcc/ring1/thr1_50/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/MD/RAI2RNAcc/ring1/thr1_00/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/MD/RAI2RNAcc/ring1/thr1_05/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/MD/RAI2RNAcc/ring1/thr1_10/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/MD/RAI2RNAcc/ring1/thr1_15/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/MD/RAI2RNAcc/ring1/thr1_20/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/MD/RAI2RNAcc/ring1/thr1_25/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/MD/RAI2RNAcc/ring1/thr1_30/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/MD/RAI2RNAcc/ring1/thr1_35/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/MD/RAI2RNAcc/ring1/thr1_40/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/MD/RAI2RNAcc/ring1/thr1_45/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/MD/RAI2RNAcc/ring1/thr1_50/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/AxD/LAI2LNAcc/ring1/thr1_00/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/AxD/LAI2LNAcc/ring1/thr1_05/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/AxD/LAI2LNAcc/ring1/thr1_10/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/AxD/LAI2LNAcc/ring1/thr1_15/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/AxD/LAI2LNAcc/ring1/thr1_20/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/AxD/LAI2LNAcc/ring1/thr1_25/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/AxD/LAI2LNAcc/ring1/thr1_30/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/AxD/LAI2LNAcc/ring1/thr1_35/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/AxD/LAI2LNAcc/ring1/thr1_40/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/AxD/LAI2LNAcc/ring1/thr1_45/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/AxD/LAI2LNAcc/ring1/thr1_50/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/AxD/RAI2RNAcc/ring1/thr1_00/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/AxD/RAI2RNAcc/ring1/thr1_05/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/AxD/RAI2RNAcc/ring1/thr1_10/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/AxD/RAI2RNAcc/ring1/thr1_15/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/AxD/RAI2RNAcc/ring1/thr1_20/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/AxD/RAI2RNAcc/ring1/thr1_25/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/AxD/RAI2RNAcc/ring1/thr1_30/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/AxD/RAI2RNAcc/ring1/thr1_35/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/AxD/RAI2RNAcc/ring1/thr1_40/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/AxD/RAI2RNAcc/ring1/thr1_45/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/AxD/RAI2RNAcc/ring1/thr1_50/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/RD/LAI2LNAcc/ring1/thr1_00/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/RD/LAI2LNAcc/ring1/thr1_05/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/RD/LAI2LNAcc/ring1/thr1_10/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/RD/LAI2LNAcc/ring1/thr1_15/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/RD/LAI2LNAcc/ring1/thr1_20/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/RD/LAI2LNAcc/ring1/thr1_25/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/RD/LAI2LNAcc/ring1/thr1_30/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/RD/LAI2LNAcc/ring1/thr1_35/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/RD/LAI2LNAcc/ring1/thr1_40/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/RD/LAI2LNAcc/ring1/thr1_45/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/RD/LAI2LNAcc/ring1/thr1_50/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/RD/RAI2RNAcc/ring1/thr1_00/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/RD/RAI2RNAcc/ring1/thr1_05/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/RD/RAI2RNAcc/ring1/thr1_10/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/RD/RAI2RNAcc/ring1/thr1_15/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/RD/RAI2RNAcc/ring1/thr1_20/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/RD/RAI2RNAcc/ring1/thr1_25/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/RD/RAI2RNAcc/ring1/thr1_30/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/RD/RAI2RNAcc/ring1/thr1_35/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/RD/RAI2RNAcc/ring1/thr1_40/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/RD/RAI2RNAcc/ring1/thr1_45/$(subject) /mnt/tpp/risktaking/roopa/MScThesis/results/extr_vals_self/Roopa/RD/RAI2RNAcc/ring1/thr1_50/$(subject)
