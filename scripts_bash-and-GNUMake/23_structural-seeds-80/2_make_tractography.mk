#RKPai 2018-12-08
#23_DTI: three-part AI, FMRIB
#Makefile for tractography

SHELL=/bin/bash
export SHELL

export ANTSPATH=/usr/local/ANTs-2.1.0-rc3/bin/
export PATH:=${ANTSPATH}:$(PATH)

subject=$(notdir $(shell pwd))

all: paths DTIfit_toStdSpc

###### I. Preprocessing & Bedpost: (1-5) ######
#(1) Eddy current correction
DTI_eddy.nii.gz: DTI.nii.gz
	eddy_correct $< $@ 0

#(2) isolation of the nodiff timepoint
DTI_nodiff_image.nii.gz: DTI_eddy.nii.gz
	fslroi $< $@ 0 1

#(3) Skull stripping
DTI_skullstrip.nii.gz: DTI_nodiff_image.nii.gz
	bet $< $@ -f 0.25 -R

#(4) binarize to create no_dif mask
DTI_nodiff.nii.gz: DTI_skullstrip.nii.gz
	fslmaths $< -bin $@

#(5) Diffusion tensor model fitting
DTI_fit_FA.nii.gz: DTI_eddy.nii.gz DTI_nodiff.nii.gz bvecs.txt bvals.txt
	dtifit -k $< -o DTI_fit -m $(word 2,$^) -r $(word 3,$^) -b $(word 4,$^)

#(6) Running bedpostx
bedpostx.bedpostX/merged_f1samples.nii.gz: DTI_eddy.nii.gz DTI_nodiff.nii.gz bvecs.txt bvals.txt
	mkdir -p bedpostx ;\
	cp $< bedpostx/data.nii.gz ;\
	cp $(word 2,$^) bedpostx/nodif_brain_mask.nii.gz ;\
	cp $(word 3,$^) bedpostx/bvecs ;\
	cp $(word 4,$^) bedpostx/bvals ;\
	bedpostx bedpostx/

###### II. Tractography ######

#(1) Bias field correction
# bias corrects the (by FreeSurfer) motion-corrected t1
T1_bias_correct.nii.gz: t1.nii.gz
	bet $< $@ -B

#(2) Cross-space Registrations
#(2a) DTI to T1
DTItoT11Warp.nii.gz: T1_bias_correct.nii.gz DTI_fit_FA.nii.gz
	antsRegistrationSyN.sh -d 3 -f $< -m $(word 2,$^) -o DTItoT1 -t s

#(2b) T1 to standard space
T1toStdSpc1Warp.nii.gz: /mnt/tpp/risktaking/lib/MNI152_T1_1mm_brain.nii.gz T1_bias_correct.nii.gz
	antsRegistrationSyN.sh -d 3 -f $< -m $(word 2,$^) -o T1toStdSpc -t s

#(3) Make white matter mask for probabilistic tractography
FSwmtoDTIWarped_bin.nii.gz: /mnt/tpp/risktaking/roopa/MScThesis/raw_data/freesurfer/$(subject)/mri/T1.mgz /mnt/tpp/risktaking/roopa/MScThesis/raw_data/freesurfer/$(subject)/mri/wm.mgz
	mri_convert --out_orientation RAS -rt nearest --reslice_like $< $(word 2,$^) wm_1.nii.gz ;\
	fslreorient2std wm_1.nii.gz wm.nii.gz ;\
	antsRegistrationSyN.sh -d 3 -f DTI_fit_FA.nii.gz -m wm.nii.gz -o FSwmtoDTI -t s ;\
	fslmaths FSwmtoDTIWarped.nii.gz -bin $@

stop.txt: /mnt/tpp/risktaking/roopa/MScThesis/raw_data/freesurfer/$(subject)/surf/lh.white /mnt/tpp/risktaking/roopa/MScThesis/raw_data/freesurfer/$(subject)/surf/rh.white
	mris_convert $< lh.white.asc ;\
	mris_convert $(word 2,$^) rh.white.asc ;\
	surf2surf -i lh.white.asc -o lh.white.surf.gii ;\
	surf2surf -i rh.white.asc -o rh.white.surf.gii ;\
	echo lh.white.surf.gii > $@ ;\
	echo rh.white.surf.gii >> $@ ;\

#(4) Convert the brain.mgz file into .nii
brain.nii.gz: /mnt/tpp/risktaking/roopa/MScThesis/raw_data/freesurfer/$(subject)/mri/brain.mgz /mnt/tpp/risktaking/roopa/MScThesis/raw_data/freesurfer/$(subject)/mri/T1.mgz
	mri_convert --out_orientation RAS -rt nearest --reslice_like $(word 2,$^) $< brain_1.nii.gz ;\
	fslreorient2std brain_1.nii.gz $@

#(5a) Registration from our motion & bias corrected, brain extracted T1 to Freesurfer's motion corrected, brain extracted, intensity normalized (= bias corrected?) T1 using FLIRT (rigid body)
T1toFS.mat: T1_bias_correct.nii.gz brain.nii.gz
	 flirt -dof 6 -in $< -ref $(word 2,$^) -out T1toFS.nii.gz -omat $@

#(5b) Convert T1toFS from FSL to ITK (ANTS) format
T1toFS.txt: brain.nii.gz T1_bias_correct.nii.gz T1toFS.mat
	c3d_affine_tool -ref $< -src $(word 2,$^) $(word 3,$^) -fsl2ras -oitk $@

#(6) convert atlas from native FreeSurfer space to native DTI space (prep for thresholding out seeds in next step)
#use brain2T1_bias_corr before T1_bias_corr2DTI (assumption: brain and T1 not same; probably because another recon-all step, some sort of intensity normalization, is carried out in the middle)
aparc.a2009s+aseg_DTI.nii.gz: /mnt/tpp/risktaking/roopa/MScThesis/raw_data/freesurfer/$(subject)/mri/aparc.a2009s+aseg.mgz DTI_fit_FA.nii.gz DTItoT11Warp.nii.gz T1toFS.txt
	mri_convert $< aparc.a2009s+aseg_1.nii.gz ;\
	fslreorient2std aparc.a2009s+aseg_1.nii.gz aparc.a2009s+aseg.nii.gz ;\
	DTItoT1=`basename $(word 3, $^) 1Warp.nii.gz` ;\
	WarpImageMultiTransform 3 aparc.a2009s+aseg.nii.gz $@ -R $(word 2,$^) --use-NN -i $(word 4,$^) -i $${DTItoT1}0GenericAffine.mat $${DTItoT1}1InverseWarp.nii.gz

#(7a)Exclusion Mask: hemisphere (FS brain T1 to our (FS+bet) T1 to DTI)
exmask_hemisphere_FST1.nii.gz: brain.nii.gz DTI_fit_FA.nii.gz DTItoT11Warp.nii.gz T1toFS.txt
	fslmaths brain.nii.gz -bin -roi 127 0 -1 -1 -1 -1 -1 -1 exmask_temp_FST1.nii.gz ;\
	DTItoT1=`basename $(word 3, $^) 1Warp.nii.gz` ;\
	WarpImageMultiTransform 3 exmask_temp_FST1.nii.gz $@ -R $(word 2,$^) -i $(word 4,$^) -i $${DTItoT1}0GenericAffine.mat $${DTItoT1}1InverseWarp.nii.gz ;\
	fslmaths $@ -bin $@

#(7b)Exclusion Mask: hemisphere (stdspc to T1 to DTI)
exmask_hemisphere_MNIT1.nii.gz: /mnt/tpp/risktaking/roopa/MScThesis/lib/MNI152_T1_1mm_brain.nii.gz DTI_fit_FA.nii.gz DTItoT11Warp.nii.gz T1toStdSpc1Warp.nii.gz
	fslmaths /mnt/tpp/risktaking/roopa/MScThesis/lib/MNI152_T1_1mm_brain.nii.gz -bin -roi 90 0 -1 -1 -1 -1 -1 -1 exmask_hemisphere_MNI.nii.gz ;\
	fslmaths exmask_hemisphere_MNI.nii.gz -bin $@ ;\
	DTItoT1=`basename $(word 3, $^) 1Warp.nii.gz` ;\
	T1toStdSpc=`basename $(word 4, $^) 1Warp.nii.gz` ;\
	WarpImageMultiTransform 3 exmask_hemisphere_MNI.nii.gz $@ -R $(word 2,$^) -i $${T1toStdSpc}0GenericAffine.mat $${T1toStdSpc}1InverseWarp.nii.gz -i $${DTItoT1}0GenericAffine.mat $${DTItoT1}1InverseWarp.nii.gz

# (7c)Exclusion Mask: hemisphere (created in DTI space itself)
exmask_hemisphere_DTI.nii.gz: DTI_fit_FA.nii.gz
	fslhd -x $< > DTI_hdinfo ;\
	fslcreatehd DTI_hdinfo exmask_temp1.nii.gz ;\
	fslmaths exmask_temp1.nii.gz -add 1 exmask_temp2.nii.gz ;\
	fslmaths exmask_temp2.nii.gz -roi 64 0 -1 -1 -1 -1 -1 -1 $@

# Creating structural seeds from atlases, waypoint files

#(8) create seed masks in DTI space
#(8a) ring0 ("real") ROIs
ROIs/LNAcc_ring0.nii.gz: aparc.a2009s+aseg_DTI.nii.gz
	mkdir -p ROIs ;\
	fslmaths $< -thr 26 -uthr 26 -bin $@

ROIs/RNAcc_ring0.nii.gz: aparc.a2009s+aseg_DTI.nii.gz
	mkdir -p ROIs ;\
	fslmaths $< -thr 58 -uthr 58 -bin $@

ROIs/LAI_ring0.nii.gz: aparc.a2009s+aseg_DTI.nii.gz
	mkdir -p ROIs ;\
	fslmaths $< -thr 11148 -uthr 11148 -bin ROIs/LAI_a.nii.gz ;\
	fslmaths $< -thr 11118 -uthr 11118 -bin ROIs/LAI_b.nii.gz ;\
	fslmaths $< -thr 11150 -uthr 11150 -bin ROIs/LAI_c.nii.gz ;\
	fslmaths ROIs/LAI_a.nii.gz -add ROIs/LAI_b.nii.gz -add ROIs/LAI_c.nii.gz -bin $@

ROIs/RAI_ring0.nii.gz: aparc.a2009s+aseg_DTI.nii.gz
	mkdir -p ROIs ;\
	fslmaths $< -thr 12148 -uthr 12148 -bin ROIs/RAI_a.nii.gz ;\
	fslmaths $< -thr 12118 -uthr 12118 -bin ROIs/RAI_b.nii.gz ;\
	fslmaths $< -thr 12150 -uthr 12150 -bin ROIs/RAI_c.nii.gz ;\
	fslmaths ROIs/RAI_a.nii.gz -add ROIs/RAI_b.nii.gz -add ROIs/RAI_c.nii.gz -bin $@

ROIs/LAMYG_ring0.nii.gz: aparc.a2009s+aseg_DTI.nii.gz
	mkdir -p ROIs ;\
	fslmaths $< -thr 18 -uthr 18 ROIs/LAMYG.nii.gz ;\
	fslmaths ROIs/LAMYG.nii.gz -bin $@

ROIs/RAMYG_ring0.nii.gz: aparc.a2009s+aseg_DTI.nii.gz
	mkdir -p ROIs ;\
	fslmaths $< -thr 54 -uthr 54 ROIs/RAMYG.nii.gz ;\
	fslmaths ROIs/RAMYG.nii.gz -bin $@

# CST control tract ROIs
ROIs/RPCG_ring0.nii.gz: /mnt/tpp/risktaking/roopa/MScThesis/lib/PT_ROIs/Precentral_thr_bin_R.nii.gz DTI_fit_FA.nii.gz T1toStdSpc1Warp.nii.gz DTItoT11Warp.nii.gz
	T1toStdSpc=`basename $(word 3, $^) 1Warp.nii.gz` ;\
	DTItoT1=`basename $(word 4, $^) 1Warp.nii.gz` ;\
	WarpImageMultiTransform 3 $< ROIs/RPCG.nii.gz -R $(word 2,$^) -i $${T1toStdSpc}0GenericAffine.mat $${T1toStdSpc}1InverseWarp.nii.gz -i $${DTItoT1}0GenericAffine.mat $${DTItoT1}1InverseWarp.nii.gz ;\
	fslmaths ROIs/RPCG.nii.gz -bin $@

ROIs/RCrCe_ring0.nii.gz: /mnt/tpp/risktaking/roopa/MScThesis/lib/PT_ROIs/Crus_cerebri_right.nii.gz DTI_fit_FA.nii.gz T1toStdSpc1Warp.nii.gz DTItoT11Warp.nii.gz
	T1toStdSpc=`basename $(word 3, $^) 1Warp.nii.gz` ;\
	DTItoT1=`basename $(word 4, $^) 1Warp.nii.gz` ;\
	WarpImageMultiTransform 3 $< ROIs/RCrCe.nii.gz -R $(word 2,$^) -i $${T1toStdSpc}0GenericAffine.mat $${T1toStdSpc}1InverseWarp.nii.gz -i $${DTItoT1}0GenericAffine.mat $${DTItoT1}1InverseWarp.nii.gz ;\
	fslmaths ROIs/RCrCe.nii.gz -bin $@

ROIs/RIC_ring0.nii.gz: /mnt/tpp/risktaking/roopa/MScThesis/lib/PT_ROIs/IC_right.nii.gz DTI_fit_FA.nii.gz T1toStdSpc1Warp.nii.gz DTItoT11Warp.nii.gz
	T1toStdSpc=`basename $(word 3, $^) 1Warp.nii.gz` ;\
	DTItoT1=`basename $(word 4, $^) 1Warp.nii.gz` ;\
	WarpImageMultiTransform 3 $< ROIs/RIC.nii.gz -R $(word 2,$^) -i $${T1toStdSpc}0GenericAffine.mat $${T1toStdSpc}1InverseWarp.nii.gz -i $${DTItoT1}0GenericAffine.mat $${DTItoT1}1InverseWarp.nii.gz ;\
	fslmaths ROIs/RIC.nii.gz -bin $@

ROIs/LPCG_ring0.nii.gz: /mnt/tpp/risktaking/roopa/MScThesis/lib/PT_ROIs/Precentral_thr_bin_L.nii.gz DTI_fit_FA.nii.gz T1toStdSpc1Warp.nii.gz DTItoT11Warp.nii.gz
	T1toStdSpc=`basename $(word 3, $^) 1Warp.nii.gz` ;\
	DTItoT1=`basename $(word 4, $^) 1Warp.nii.gz` ;\
	WarpImageMultiTransform 3 $< ROIs/LPCG.nii.gz -R $(word 2,$^) -i $${T1toStdSpc}0GenericAffine.mat $${T1toStdSpc}1InverseWarp.nii.gz -i $${DTItoT1}0GenericAffine.mat $${DTItoT1}1InverseWarp.nii.gz ;\
	fslmaths ROIs/LPCG.nii.gz -bin $@

ROIs/LCrCe_ring0.nii.gz: /mnt/tpp/risktaking/roopa/MScThesis/lib/PT_ROIs/Crus_cerebri_left.nii.gz DTI_fit_FA.nii.gz T1toStdSpc1Warp.nii.gz DTItoT11Warp.nii.gz
	T1toStdSpc=`basename $(word 3, $^) 1Warp.nii.gz` ;\
	DTItoT1=`basename $(word 4, $^) 1Warp.nii.gz` ;\
	WarpImageMultiTransform 3 $< ROIs/LCrCe.nii.gz -R $(word 2,$^) -i $${T1toStdSpc}0GenericAffine.mat $${T1toStdSpc}1InverseWarp.nii.gz -i $${DTItoT1}0GenericAffine.mat $${DTItoT1}1InverseWarp.nii.gz ;\
	fslmaths ROIs/LCrCe.nii.gz -bin $@

ROIs/LIC_ring0.nii.gz: /mnt/tpp/risktaking/roopa/MScThesis/lib/PT_ROIs/IC_left.nii.gz DTI_fit_FA.nii.gz T1toStdSpc1Warp.nii.gz DTItoT11Warp.nii.gz
	T1toStdSpc=`basename $(word 3, $^) 1Warp.nii.gz` ;\
	DTItoT1=`basename $(word 4, $^) 1Warp.nii.gz` ;\
	WarpImageMultiTransform 3 $< ROIs/LIC.nii.gz -R $(word 2,$^) -i $${T1toStdSpc}0GenericAffine.mat $${T1toStdSpc}1InverseWarp.nii.gz -i $${DTItoT1}0GenericAffine.mat $${DTItoT1}1InverseWarp.nii.gz ;\
	fslmaths ROIs/LIC.nii.gz -bin $@

#(8b) create 'ring1' ROIs
ROIs/LAI_ring1.nii.gz: ROIs/LAI_ring0.nii.gz
	fslmaths $< -dilD ROIs/LAI_dil.nii.gz ;\
	fslmaths ROIs/LAI_dil.nii.gz -sub $< $@

ROIs/RAI_ring1.nii.gz: ROIs/RAI_ring0.nii.gz
	fslmaths $< -dilD ROIs/RAI_dil.nii.gz ;\
	fslmaths ROIs/RAI_dil.nii.gz -sub $< $@

ROIs/LPI_ring1.nii.gz: ROIs/LPI_ring0.nii.gz
	fslmaths $< -dilD ROIs/LPI_dil.nii.gz ;\
	fslmaths ROIs/LPI_dil.nii.gz -sub $< $@

ROIs/RPI_ring1.nii.gz: ROIs/RPI_ring0.nii.gz
	fslmaths $< -dilD ROIs/RPI_dil.nii.gz ;\
	fslmaths ROIs/RPI_dil.nii.gz -sub $< $@

ROIs/LNAcc_ring1.nii.gz: ROIs/LNAcc_ring0.nii.gz
	fslmaths $< -dilD ROIs/LNAcc_dil.nii.gz ;\
	fslmaths ROIs/LNAcc_dil.nii.gz -sub $< $@

ROIs/RNAcc_ring1.nii.gz: ROIs/RNAcc_ring0.nii.gz
	fslmaths $< -dilD ROIs/RNAcc_dil.nii.gz ;\
	fslmaths ROIs/RNAcc_dil.nii.gz -sub $< $@

ROIs/LAMYG_ring1.nii.gz: ROIs/LAMYG_ring0.nii.gz
	fslmaths $< -dilD ROIs/LAMYG_dil.nii.gz ;\
	fslmaths ROIs/LAMYG_dil.nii.gz -sub $< $@

ROIs/RAMYG_ring1.nii.gz: ROIs/RAMYG_ring0.nii.gz
	fslmaths $< -dilD ROIs/RAMYG_dil.nii.gz ;\
	fslmaths ROIs/RAMYG_dil.nii.gz -sub $< $@

## CST controls ##
ROIs/RPCG_ring1.nii.gz: ROIs/RPCG_ring0.nii.gz
	fslmaths $< -dilD ROIs/RPCG_dil.nii.gz ;\
	fslmaths ROIs/RPCG_dil.nii.gz -sub $< $@
ROIs/RCrCe_ring1.nii.gz: ROIs/RCrCe_ring0.nii.gz
	fslmaths $< -dilD ROIs/RCrCe_dil.nii.gz ;\
	fslmaths ROIs/RCrCe_dil.nii.gz -sub $< $@
ROIs/LPCG_ring1.nii.gz: ROIs/LPCG_ring0.nii.gz
	fslmaths $< -dilD ROIs/LPCG_dil.nii.gz ;\
	fslmaths ROIs/LPCG_dil.nii.gz -sub $< $@
ROIs/LCrCe_ring1.nii.gz: ROIs/LCrCe_ring0.nii.gz
	fslmaths $< -dilD ROIs/LCrCe_dil.nii.gz ;\
	fslmaths ROIs/LCrCe_dil.nii.gz -sub $< $@

#(8c) create 'ring2' ROIs
ROIs/LAI_ring2.nii.gz: ROIs/LAI_ring0.nii.gz ROIs/LAI_ring1.nii.gz
	fslmaths $< -ero ROIs/LAI_ero.nii.gz ;\
	fslmaths ROIs/LAI_dil.nii.gz -sub ROIs/LAI_ero.nii.gz $@

ROIs/RAI_ring2.nii.gz: ROIs/RAI_ring0.nii.gz ROIs/RAI_ring1.nii.gz
	fslmaths $< -ero ROIs/RAI_ero.nii.gz ;\
	fslmaths ROIs/RAI_dil.nii.gz -sub ROIs/RAI_ero.nii.gz $@

ROIs/LPI_ring2.nii.gz: ROIs/LPI_ring0.nii.gz ROIs/LPI_ring1.nii.gz
	fslmaths $< -ero ROIs/LPI_ero.nii.gz ;\
	fslmaths ROIs/LPI_dil.nii.gz -sub ROIs/LPI_ero.nii.gz $@

ROIs/RPI_ring2.nii.gz: ROIs/RPI_ring0.nii.gz ROIs/RPI_ring1.nii.gz
	fslmaths $< -ero ROIs/RPI_ero.nii.gz ;\
	fslmaths ROIs/RPI_dil.nii.gz -sub ROIs/RPI_ero.nii.gz $@

ROIs/LNAcc_ring2.nii.gz: ROIs/LNAcc_ring0.nii.gz ROIs/LNAcc_ring1.nii.gz
	fslmaths $< -ero ROIs/LNAcc_ero.nii.gz ;\
	fslmaths ROIs/LNAcc_dil.nii.gz -sub ROIs/LNAcc_ero.nii.gz $@

ROIs/RNAcc_ring2.nii.gz: ROIs/RNAcc_ring0.nii.gz ROIs/RNAcc_ring1.nii.gz
	fslmaths $< -ero ROIs/RNAcc_ero.nii.gz ;\
	fslmaths ROIs/RNAcc_dil.nii.gz -sub ROIs/RNAcc_ero.nii.gz $@

ROIs/LAMYG_ring2.nii.gz: ROIs/LAMYG_ring0.nii.gz ROIs/LAMYG_ring1.nii.gz
	fslmaths $< -ero ROIs/LAMYG_ero.nii.gz ;\
	fslmaths ROIs/LAMYG_dil.nii.gz -sub ROIs/LAMYG_ero.nii.gz $@

ROIs/RAMYG_ring2.nii.gz: ROIs/RAMYG_ring0.nii.gz ROIs/RAMYG_ring1.nii.gz
	fslmaths $< -ero ROIs/RAMYG_ero.nii.gz ;\
	fslmaths ROIs/RAMYG_dil.nii.gz -sub ROIs/RAMYG_ero.nii.gz $@

## controls ##
ROIs/RPCG_ring2.nii.gz: ROIs/RPCG_ring0.nii.gz ROIs/RPCG_ring1.nii.gz
	fslmaths $< -ero ROIs/RPCG_ero.nii.gz ;\
	fslmaths ROIs/RPCG_dil.nii.gz -sub ROIs/RPCG_ero.nii.gz $@
ROIs/RCrCe_ring2.nii.gz: ROIs/RCrCe_ring0.nii.gz ROIs/RCrCe_ring1.nii.gz
	fslmaths $< -ero ROIs/RCrCe_ero.nii.gz ;\
	fslmaths ROIs/RCrCe_dil.nii.gz -sub ROIs/RCrCe_ero.nii.gz $@
ROIs/LPCG_ring2.nii.gz: ROIs/LPCG_ring0.nii.gz ROIs/LPCG_ring1.nii.gz
	fslmaths $< -ero ROIs/LPCG_ero.nii.gz ;\
	fslmaths ROIs/LPCG_dil.nii.gz -sub ROIs/LPCG_ero.nii.gz $@
ROIs/LCrCe_ring2.nii.gz: ROIs/LCrCe_ring0.nii.gz ROIs/LCrCe_ring1.nii.gz
	fslmaths $< -ero ROIs/LCrCe_ero.nii.gz ;\
	fslmaths ROIs/LCrCe_dil.nii.gz -sub ROIs/LCrCe_ero.nii.gz $@

all_ROIs: ROIs/LAI_ring0.nii.gz ROIs/RAI_ring0.nii.gz ROIs/LPI_ring0.nii.gz ROIs/RPI_ring0.nii.gz ROIs/LNAcc_ring0.nii.gz ROIs/RNAcc_ring0.nii.gz ROIs/LAMYG_ring0.nii.gz ROIs/RAMYG_ring0.nii.gz ROIs/RPCG_ring0.nii.gz ROIs/RCrCe_ring0.nii.gz ROIs/RIC_ring0.nii.gz ROIs/LPCG_ring0.nii.gz ROIs/LCrCe_ring0.nii.gz ROIs/LIC_ring0.nii.gz ROIs/LAI_ring1.nii.gz ROIs/RAI_ring1.nii.gz ROIs/LPI_ring1.nii.gz ROIs/RPI_ring1.nii.gz ROIs/LNAcc_ring1.nii.gz ROIs/RNAcc_ring1.nii.gz ROIs/LAMYG_ring1.nii.gz ROIs/RAMYG_ring1.nii.gz ROIs/RPCG_ring1.nii.gz ROIs/RCrCe_ring1.nii.gz ROIs/LPCG_ring1.nii.gz ROIs/LCrCe_ring1.nii.gz ROIs/LAI_ring2.nii.gz ROIs/RAI_ring2.nii.gz ROIs/LPI_ring2.nii.gz ROIs/RPI_ring2.nii.gz ROIs/LNAcc_ring2.nii.gz ROIs/RNAcc_ring2.nii.gz ROIs/LAMYG_ring2.nii.gz ROIs/RAMYG_ring2.nii.gz ROIs/RPCG_ring2.nii.gz ROIs/RCrCe_ring2.nii.gz ROIs/LPCG_ring2.nii.gz ROIs/LCrCe_ring2.nii.gz

#(9) create a folder that contains the textfiles with the paths to the waypoint masks
#(9a) ring0
waypoints_textfiles/LAI_ring0.txt: ROIs/LAI_ring0.nii.gz
	mkdir -p waypoints_textfiles ;\
	echo -n $< >> $@
waypoints_textfiles/RAI_ring0.txt: ROIs/RAI_ring0.nii.gz
	mkdir -p waypoints_textfiles ;\
	echo -n $< >> $@
waypoints_textfiles/LPI_ring0.txt: ROIs/LPI_ring0.nii.gz
	mkdir -p waypoints_textfiles ;\
	echo -n $< >> $@
waypoints_textfiles/RPI_ring0.txt: ROIs/RPI_ring0.nii.gz
	mkdir -p waypoints_textfiles ;\
	echo -n $< >> $@
waypoints_textfiles/LNAcc_ring0.txt: ROIs/LNAcc_ring0.nii.gz
	mkdir -p waypoints_textfiles ;\
	echo -n $< >> $@
waypoints_textfiles/RNAcc_ring0.txt: ROIs/RNAcc_ring0.nii.gz
	mkdir -p waypoints_textfiles ;\
	echo -n $< >> $@
waypoints_textfiles/LAMYG_ring0.txt: ROIs/LAMYG_ring0.nii.gz
	mkdir -p waypoints_textfiles ;\
	echo -n $< >> $@
waypoints_textfiles/RAMYG_ring0.txt: ROIs/RAMYG_ring0.nii.gz
	mkdir -p waypoints_textfiles ;\
	echo -n $< >> $@
waypoints_textfiles/RPCG_ring0.txt: ROIs/RPCG_ring0.nii.gz
	mkdir -p waypoints_textfiles ;\
	echo -n $< >> $@
waypoints_textfiles/RIC_ring0.txt: ROIs/RIC_ring0.nii.gz
	mkdir -p waypoints_textfiles ;\
	echo -n $< >> $@
waypoints_textfiles/RCrCe_ring0.txt: ROIs/RCrCe_ring0.nii.gz
	mkdir -p waypoints_textfiles ;\
	echo -n $< >> $@
waypoints_textfiles/RCST_ring0.txt: ROIs/RIC_ring0.nii.gz ROIs/RCrCe_ring0.nii.gz
	mkdir -p waypoints_textfiles ;\
	echo $< >> $@ ;\
	echo -n $(word 2,$^) >> $@
waypoints_textfiles/LPCG_ring0.txt: ROIs/LPCG_ring0.nii.gz
	mkdir -p waypoints_textfiles ;\
	echo -n $< >> $@
waypoints_textfiles/LIC_ring0.txt: ROIs/LIC_ring0.nii.gz
	mkdir -p waypoints_textfiles ;\
	echo -n $< >> $@
waypoints_textfiles/LCrCe_ring0.txt: ROIs/LCrCe_ring0.nii.gz
	mkdir -p waypoints_textfiles ;\
	echo -n $< >> $@
waypoints_textfiles/LCST_ring0.txt: ROIs/LIC_ring0.nii.gz ROIs/LCrCe_ring0.nii.gz
	mkdir -p waypoints_textfiles ;\
	echo $< >> $@ ;\
	echo -n $(word 2,$^) >> $@

#(9b) ring1
waypoints_textfiles/LAI_ring1.txt: ROIs/LAI_ring1.nii.gz
	mkdir -p waypoints_textfiles ;\
	echo -n $< >> $@
waypoints_textfiles/RAI_ring1.txt: ROIs/RAI_ring1.nii.gz
	mkdir -p waypoints_textfiles ;\
	echo -n $< >> $@
waypoints_textfiles/LPI_ring1.txt: ROIs/LPI_ring1.nii.gz
	mkdir -p waypoints_textfiles ;\
	echo -n $< >> $@
waypoints_textfiles/RPI_ring1.txt: ROIs/RPI_ring1.nii.gz
	mkdir -p waypoints_textfiles ;\
	echo -n $< >> $@
waypoints_textfiles/LNAcc_ring1.txt: ROIs/LNAcc_ring1.nii.gz
	mkdir -p waypoints_textfiles ;\
	echo -n $< >> $@
waypoints_textfiles/RNAcc_ring1.txt: ROIs/RNAcc_ring1.nii.gz
	mkdir -p waypoints_textfiles ;\
	echo -n $< >> $@
waypoints_textfiles/LAMYG_ring1.txt: ROIs/LAMYG_ring1.nii.gz
	mkdir -p waypoints_textfiles ;\
	echo -n $< >> $@
waypoints_textfiles/RAMYG_ring1.txt: ROIs/RAMYG_ring1.nii.gz
	mkdir -p waypoints_textfiles ;\
	echo -n $< >> $@
waypoints_textfiles/RPCG_ring1.txt: ROIs/RPCG_ring1.nii.gz
	mkdir -p waypoints_textfiles ;\
	echo -n $< >> $@
waypoints_textfiles/RCrCe_ring1.txt: ROIs/RCrCe_ring1.nii.gz
	mkdir -p waypoints_textfiles ;\
	echo -n $< >> $@
waypoints_textfiles/RCST_ring1.txt: ROIs/RIC_ring0.nii.gz ROIs/RCrCe_ring1.nii.gz
	mkdir -p waypoints_textfiles ;\
	echo $< >> $@ ;\
	echo -n $(word 2,$^) >> $@
waypoints_textfiles/LPCG_ring1.txt: ROIs/LPCG_ring1.nii.gz
	mkdir -p waypoints_textfiles ;\
	echo -n $< >> $@
waypoints_textfiles/LCrCe_ring1.txt: ROIs/LCrCe_ring1.nii.gz
	mkdir -p waypoints_textfiles ;\
	echo -n $< >> $@
waypoints_textfiles/LCST_ring1.txt: ROIs/LIC_ring0.nii.gz ROIs/LCrCe_ring1.nii.gz
	mkdir -p waypoints_textfiles ;\
	echo $< >> $@ ;\
	echo -n $(word 2,$^) >> $@

#(9c) ring2
waypoints_textfiles/LAI_ring2.txt: ROIs/LAI_ring2.nii.gz
	mkdir -p waypoints_textfiles ;\
	echo -n $< >> $@
waypoints_textfiles/RAI_ring2.txt: ROIs/RAI_ring2.nii.gz
	mkdir -p waypoints_textfiles ;\
	echo -n $< >> $@
waypoints_textfiles/LPI_ring2.txt: ROIs/LPI_ring2.nii.gz
	mkdir -p waypoints_textfiles ;\
	echo -n $< >> $@
waypoints_textfiles/RPI_ring2.txt: ROIs/RPI_ring2.nii.gz
	mkdir -p waypoints_textfiles ;\
	echo -n $< >> $@
waypoints_textfiles/LNAcc_ring2.txt: ROIs/LNAcc_ring2.nii.gz
	mkdir -p waypoints_textfiles ;\
	echo -n $< >> $@
waypoints_textfiles/RNAcc_ring2.txt: ROIs/RNAcc_ring2.nii.gz
	mkdir -p waypoints_textfiles ;\
	echo -n $< >> $@
waypoints_textfiles/LAMYG_ring2.txt: ROIs/LAMYG_ring2.nii.gz
	mkdir -p waypoints_textfiles ;\
	echo -n $< >> $@
waypoints_textfiles/RAMYG_ring2.txt: ROIs/RAMYG_ring2.nii.gz
	mkdir -p waypoints_textfiles ;\
	echo -n $< >> $@
waypoints_textfiles/RPCG_ring2.txt: ROIs/RPCG_ring2.nii.gz
	mkdir -p waypoints_textfiles ;\
	echo -n $< >> $@
waypoints_textfiles/RCrCe_ring2.txt: ROIs/RCrCe_ring2.nii.gz
	mkdir -p waypoints_textfiles ;\
	echo -n $< >> $@
waypoints_textfiles/RCST_ring2.txt: ROIs/RIC_ring0.nii.gz ROIs/RCrCe_ring2.nii.gz
	mkdir -p waypoints_textfiles ;\
	echo $< >> $@ ;\echo -n $(word 2,$^) >> $@
waypoints_textfiles/LPCG_ring2.txt: ROIs/LPCG_ring2.nii.gz
	mkdir -p waypoints_textfiles ;\
	echo -n $< >> $@
waypoints_textfiles/LCrCe_ring2.txt: ROIs/LCrCe_ring2.nii.gz
	mkdir -p waypoints_textfiles ;\
	echo -n $< >> $@
waypoints_textfiles/LCST_ring2.txt: ROIs/LIC_ring0.nii.gz ROIs/LCrCe_ring2.nii.gz
	mkdir -p waypoints_textfiles ;\
	echo $< >> $@ ;\
	echo -n $(word 2,$^) >> $@

waypoints: waypoints_textfiles/LAI_ring0.txt waypoints_textfiles/RAI_ring0.txt waypoints_textfiles/LPI_ring0.txt waypoints_textfiles/RPI_ring0.txt waypoints_textfiles/LNAcc_ring0.txt waypoints_textfiles/RNAcc_ring0.txt waypoints_textfiles/LAMYG_ring0.txt waypoints_textfiles/RAMYG_ring0.txt waypoints_textfiles/RPCG_ring0.txt waypoints_textfiles/RIC_ring0.txt waypoints_textfiles/RCrCe_ring0.txt waypoints_textfiles/RCST_ring0.txt waypoints_textfiles/LPCG_ring0.txt waypoints_textfiles/LIC_ring0.txt waypoints_textfiles/LCrCe_ring0.txt waypoints_textfiles/LCST_ring0.txt waypoints_textfiles/LAI_ring1.txt waypoints_textfiles/RAI_ring1.txt waypoints_textfiles/LPI_ring1.txt waypoints_textfiles/RPI_ring1.txt waypoints_textfiles/LNAcc_ring1.txt waypoints_textfiles/RNAcc_ring1.txt waypoints_textfiles/LAMYG_ring1.txt waypoints_textfiles/RAMYG_ring1.txt waypoints_textfiles/RPCG_ring1.txt waypoints_textfiles/RCrCe_ring1.txt waypoints_textfiles/RCST_ring1.txt waypoints_textfiles/LPCG_ring1.txt waypoints_textfiles/LCrCe_ring1.txt waypoints_textfiles/LCST_ring1.txt waypoints_textfiles/LAI_ring2.txt waypoints_textfiles/RAI_ring2.txt waypoints_textfiles/LPI_ring2.txt waypoints_textfiles/RPI_ring2.txt waypoints_textfiles/LNAcc_ring2.txt waypoints_textfiles/RNAcc_ring2.txt waypoints_textfiles/LAMYG_ring2.txt waypoints_textfiles/RAMYG_ring2.txt waypoints_textfiles/RPCG_ring2.txt waypoints_textfiles/RCrCe_ring2.txt waypoints_textfiles/RCST_ring2.txt waypoints_textfiles/LPCG_ring2.txt waypoints_textfiles/LCrCe_ring2.txt waypoints_textfiles/LCST_ring2.txt

# Probabilistic Tractography, Register tracts to standard space #

#(10) Probabilistic tractography
#(10.1)ring0
#(10.1.1) to LNAcc
probtrackx2_results/ring0/%2LNAcc/fdt_paths.nii.gz: ROIs/%_ring0.nii.gz FSwmtoDTIWarped_bin.nii.gz waypoints_textfiles/LNAcc_ring0.txt exmask_hemisphere_MNIT1.nii.gz
	mkdir -p probtrackx2_results/ring0/$*2LNAcc ;\
	probtrackx2 -x $< -l -c 0.01 --distthresh=10.0 -S 400 --steplength=0.2 -P 5000 --opd -s bedpostx.bedpostX/merged -m $(word 2,$^) --avoid=exmask_hemisphere_MNIT1.nii.gz --dir=probtrackx2_results/ring0/$*2LNAcc --forcedir --waypoints=$(word 3,$^) --stop=$(word 3,$^) --onewaycondition --savepaths
#(10.1.2) to RNAcc
probtrackx2_results/ring0/%2RNAcc/fdt_paths.nii.gz: ROIs/%_ring0.nii.gz FSwmtoDTIWarped_bin.nii.gz waypoints_textfiles/RNAcc_ring0.txt exmask_hemisphere_MNIT1.nii.gz
	mkdir -p probtrackx2_results/ring0/$*2RNAcc ;\
	probtrackx2 -x $< -l -c 0.01 --distthresh=10.0 -S 400 --steplength=0.2 -P 5000 --opd -s bedpostx.bedpostX/merged -m $(word 2,$^) --avoid=exmask_hemisphere_MNIT1.nii.gz --dir=probtrackx2_results/ring0/$*2RNAcc --forcedir --waypoints=$(word 3,$^) --stop=$(word 3,$^) --onewaycondition --savepaths

#(10.1.3) to RCrCe
probtrackx2_results/ring0/%2RCrCe/fdt_paths.nii.gz: ROIs/%_ring0.nii.gz FSwmtoDTIWarped_bin.nii.gz waypoints_textfiles/RCST_ring0.txt exmask_hemisphere_MNIT1.nii.gz
	mkdir -p probtrackx2_results/ring0/$*2RCrCe ;\
	probtrackx2 -x $< -l -c 0.2 --distthresh=0.0 -S 2000 --steplength=0.5 -P 5000 --opd -s bedpostx.bedpostX/merged -m $(word 2,$^) --avoid=exmask_hemisphere_MNIT1.nii.gz --dir=probtrackx2_results/ring0/$*2RCrCe --forcedir --waypoints=$(word 3,$^) --onewaycondition --savepaths
#--meshspace=freesurfer --stop=stop.txt
#(10.1.4) to LCrCe
probtrackx2_results/ring0/%2LCrCe/fdt_paths.nii.gz: ROIs/%_ring0.nii.gz FSwmtoDTIWarped_bin.nii.gz waypoints_textfiles/LCST_ring0.txt exmask_hemisphere_MNIT1.nii.gz
	mkdir -p probtrackx2_results/ring0/$*2LCrCe ;\
	probtrackx2 -x $< -l -c 0.2 --distthresh=0.0 -S 2000 --steplength=0.5 -P 5000 --opd -s bedpostx.bedpostX/merged -m $(word 2,$^) --avoid=exmask_hemisphere_MNIT1.nii.gz --dir=probtrackx2_results/ring0/$*2LCrCe --forcedir --waypoints=$(word 3,$^) --onewaycondition --savepaths
#--meshspace=freesurfer --stop=stop.txt

#(10.2)ring1
#(10.2.1) to LNAcc
probtrackx2_results/ring1/%2LNAcc/fdt_paths.nii.gz: ROIs/%_ring1.nii.gz FSwmtoDTIWarped_bin.nii.gz waypoints_textfiles/LNAcc_ring1.txt exmask_hemisphere_MNIT1.nii.gz
	mkdir -p probtrackx2_results/ring1/$*2LNAcc ;\
	probtrackx2 -x $< -l -c 0.01 --distthresh=10.0 -S 400 --steplength=0.2 -P 5000 --opd -s bedpostx.bedpostX/merged -m $(word 2,$^) --avoid=exmask_hemisphere_MNIT1.nii.gz --dir=probtrackx2_results/ring1/$*2LNAcc --forcedir --waypoints=$(word 3,$^) --stop=$(word 3,$^) --onewaycondition --savepaths
#(10.2.2) to RNAcc
probtrackx2_results/ring1/%2RNAcc/fdt_paths.nii.gz: ROIs/%_ring1.nii.gz FSwmtoDTIWarped_bin.nii.gz waypoints_textfiles/RNAcc_ring1.txt exmask_hemisphere_MNIT1.nii.gz
	mkdir -p probtrackx2_results/ring1/$*2RNAcc ;\
	probtrackx2 -x $< -l -c 0.01 --distthresh=10.0 -S 400 --steplength=0.2 -P 5000 --opd -s bedpostx.bedpostX/merged -m $(word 2,$^) --avoid=exmask_hemisphere_MNIT1.nii.gz --dir=probtrackx2_results/ring1/$*2RNAcc --forcedir --waypoints=$(word 3,$^) --stop=$(word 3,$^) --onewaycondition --savepaths
#(10.2.3) to RCrCe
probtrackx2_results/ring1/%2RCrCe/fdt_paths.nii.gz: ROIs/%_ring1.nii.gz FSwmtoDTIWarped_bin.nii.gz waypoints_textfiles/RCST_ring1.txt exmask_hemisphere_MNIT1.nii.gz
	mkdir -p probtrackx2_results/ring1/$*2RCrCe ;\
	probtrackx2 -x $< -l -c 0.2 --distthresh=0.0 -S 2000 --steplength=0.5 -P 5000 --opd -s bedpostx.bedpostX/merged -m $(word 2,$^) --avoid=exmask_hemisphere_MNIT1.nii.gz --dir=probtrackx2_results/ring1/$*2RCrCe --forcedir --waypoints=$(word 3,$^) --onewaycondition --savepaths
#--meshspace=freesurfer --stop=stop.txt
#(10.2.4) to LCrCe
probtrackx2_results/ring1/%2LCrCe/fdt_paths.nii.gz: ROIs/%_ring1.nii.gz FSwmtoDTIWarped_bin.nii.gz waypoints_textfiles/LCST_ring1.txt exmask_hemisphere_MNIT1.nii.gz
	mkdir -p probtrackx2_results/ring1/$*2LCrCe ;\
	probtrackx2 -x $< -l -c 0.2 --distthresh=0.0 -S 2000 --steplength=0.5 -P 5000 --opd -s bedpostx.bedpostX/merged -m $(word 2,$^) --avoid=exmask_hemisphere_MNIT1.nii.gz --dir=probtrackx2_results/ring1/$*2LCrCe --forcedir --waypoints=$(word 3,$^) --onewaycondition --savepaths
#--meshspace=freesurfer --stop=stop.txt

paths: probtrackx2_results/ring0/LAI2LNAcc/fdt_paths.nii.gz probtrackx2_results/ring0/RAI2RNAcc/fdt_paths.nii.gz probtrackx2_results/ring1/LAI2LNAcc/fdt_paths.nii.gz probtrackx2_results/ring1/RAI2RNAcc/fdt_paths.nii.gz

# (11) Register DTI_fit output maps to standard space
DTI_FA_to_FMRIB_1mm_Warped.nii.gz: /mnt/tpp/risktaking/roopa/MScThesis/lib/FMRIB58_FA_1mm.nii.gz DTI_fit_FA.nii.gz
	antsRegistrationSyN.sh -d 3 -f $< -m $(word 2,$^) -o DTI_FA_to_FMRIB_1mm_ -t s

DTI_MD_to_FMRIB_1mm_Warped.nii.gz: /mnt/tpp/risktaking/roopa/MScThesis/lib/FMRIB58_FA_1mm.nii.gz DTI_fit_MD.nii.gz
	WarpImageMultiTransform 3 $(word 2,$^) $@ -R $< DTI_FA_to_FMRIB_1mm_1Warp.nii.gz DTI_FA_to_FMRIB_1mm_0GenericAffine.mat

DTI_AxD_to_FMRIB_1mm_Warped.nii.gz: /mnt/tpp/risktaking/roopa/MScThesis/lib/FMRIB58_FA_1mm.nii.gz DTI_fit_L1.nii.gz
	WarpImageMultiTransform 3 $(word 2,$^) $@ -R $< DTI_FA_to_FMRIB_1mm_1Warp.nii.gz DTI_FA_to_FMRIB_1mm_0GenericAffine.mat

DTI_RD_to_FMRIB_1mm_Warped.nii.gz: /mnt/tpp/risktaking/roopa/MScThesis/lib/FMRIB58_FA_1mm.nii.gz DTI_fit_L2.nii.gz DTI_fit_L3.nii.gz
	fslmaths $(word 2,$^) -add $(word 3,$^) -div 2 DTI_fit_RD.nii.gz ;\
	WarpImageMultiTransform 3 DTI_fit_RD.nii.gz $@ -R $< DTI_FA_to_FMRIB_1mm_1Warp.nii.gz DTI_FA_to_FMRIB_1mm_0GenericAffine.mat

DTIfit_toStdSpc: DTI_FA_to_FMRIB_1mm_Warped.nii.gz DTI_MD_to_FMRIB_1mm_Warped.nii.gz DTI_AxD_to_FMRIB_1mm_Warped.nii.gz DTI_RD_to_FMRIB_1mm_Warped.nii.gz

cl_temp:
	rm wm_1.nii.gz
	rm brain_1.nii.gz
	rm aparc.a2009s+aseg_1.nii.gz

clean:
	if ! [ -z $(wildcard T1_bias_correct*.nii.gz) ] ; then rm $(wildcard T1_bias_correct*.nii.gz) ; fi
	if ! [ -z $(wildcard aparc.a2009s+aseg*) ] ; then rm $(wildcard aparc.a2009s+aseg*) ; fi
	if [ -e wm.nii.gz ] ; then rm wm.nii.gz ; fi
	if [ -e brain.nii.gz ] ; then rm brain.nii.gz ; fi
	if ! [ -z $(wildcard T1toFS*) ] ; then rm $(wildcard T1toFS*) ; fi
	if ! [ -z $(wildcard exmask*) ] ; then rm $(wildcard exmask*) ; fi
	if [ -d probtrackx2_results ] ; then rm -r probtrackx2_results ; fi
	if [ -d ROIs ] ; then rm -r ROIs ; fi
	if [ -d waypoints_textfiles ] ; then rm -r waypoints_textfiles ; fi
	if [ -e DTI_hdinfo ] ; then rm DTI_hdinfo ; fi
	if ! [ -z $(wildcard *Affine.mat) ] ; then rm $(wildcard *Affine.mat) ; fi
	if ! [ -z $(wildcard *Warp.nii.gz) ] ; then rm $(wildcard *Warp.nii.gz) ; fi
	if ! [ -z $(wildcard *Warped.nii.gz) ] ; then rm $(wildcard *Warped.nii.gz) ; fi
	if [ -e FSwmtoDTIWarped_bin.nii.gz ] ; then rm FSwmtoDTIWarped_bin.nii.gz ; fi
