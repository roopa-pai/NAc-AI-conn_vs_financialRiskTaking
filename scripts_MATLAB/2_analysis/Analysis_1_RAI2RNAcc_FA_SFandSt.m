% RKPai
% December 18th, 2018
% Steps:
% (1) import excel file: columns of subjID vs FA/MD/AxD/RD for each ring(0,1) and each degree of thresholding({1,2}/{0:5:50})
% (2) average tracts
% (3) individual tracts
% (4) Stanford tract
% Each of (2,3,4) have:
% (a)Pearson correlation: FA with (i)RSf (ii)RTI (iii)ROI
% (b) two-sample t-test between AST's and NST's FA values

%ANSWERS:
% Workspace variables holding p-vals for:
% (1) S_avg/{RSf,RTI,ROI}: graph_p_FA_S_avg_{RSf,RTI,ROI}
%     [*Note: for thr1_25_thr2_25, check matrix(6,6)]
% (2) F_avg/{RSf,RTI,ROI}: graph_p_FA_F_avg_{RSf,RTI,ROI}
% (3) t-test avg S: p_AST_S_avg
% (4) t-test avg F: p_AST_F_avg
% (5) S_self/{RSf,RTI,ROI}: p_FA_S_self_{RSf,RTI,ROI}
% (6) F_self/{RSf,RTI,ROI}: p_FA_F_self_{RSf,RTI,ROI}
% (7) t-test self S: p_AST_S_self
% (8) t-test self F: p_AST_F_self
% (9) Stanford: p_FA_Stanford_{RSf,RTI,ROI}
% (10) t-test Stanford: p_AST_Stanford
% (10) macrostructure: [p_MacS_{RSf,RTI,ROI}, p_AST_MacS, p_MacF_{RSf,RTI,ROI}, p_AST_MacF]
% (11) FreeSurfer vars: [p_Mac_FS_{RSf,RTI,ROI}, p_AST_NAcc_vol_lh, (...)]

% SCRIPT START %
clearvars
%---------------FINAL STUFF: SAVING IMAGES & RUN INFO----------------
folder = '7_FA_RAI2RNAcc_CST';
imgFolder = fullfile('C:\Users\roopa\Dropbox\Thesis\Thesis images\19.01.09',folder);
mkdir (imgFolder);
%--------------------------------------------------------------------
color_map='jet';

%(1) import (a) Risk vars (b) FA files (c) FS parcellation stats
%risk data
[~, ~, risk_dataset] = xlsread('C:\Users\roopa\Dropbox\3.Risk-taking_dti\2.Analysis\relevant_risk_vars_181121.xlsx','168_subjects');
data_risk_dataset=cell2mat(risk_dataset(2:end,:));

%Stanford
[~, ~, RAI2RNAcc_FA_Stanford] = xlsread('C:\Users\roopa\Documents\3_Risktaking_DTI\23_DTI\tabulated_vals\joined\Stanford\Stanford_RAI2RNAcc_FA_ring0.xlsx');
data_RAI2RNAcc_FA_Stanford=cell2mat(RAI2RNAcc_FA_Stanford(2:end,:));
data_RAI2RNAcc_FA_Stanford(data_RAI2RNAcc_FA_Stanford==0) = NaN;
%structural
[~, ~, RAI2RNAcc_FA_Struct_avg] = xlsread('C:\Users\roopa\Documents\3_Risktaking_DTI\23_DTI\tabulated_vals\joined\Roopa\23_DTI_Roopa_RAI2RNAcc_FA_ring1.xlsx');
data_RAI2RNAcc_FA_Struct_avg=cell2mat(RAI2RNAcc_FA_Struct_avg(2:end,:));
data_RAI2RNAcc_FA_Struct_avg(data_RAI2RNAcc_FA_Struct_avg==0) = NaN;

[~, ~, RAI2RNAcc_FA_Struct_self]=xlsread('C:\Users\roopa\Documents\3_Risktaking_DTI\23_DTI\tabulated_vals_self\joined\Roopa\23_DTI_Roopa_RAI2RNAcc_FA_ring1.xlsx');
data_RAI2RNAcc_FA_Struct_self=cell2mat(RAI2RNAcc_FA_Struct_self(2:end,:));
data_RAI2RNAcc_FA_Struct_self(data_RAI2RNAcc_FA_Struct_self==0) = NaN;

[~,~,RAI2RNAcc_MacS]=xlsread('C:\Users\roopa\Documents\3_Risktaking_DTI\23_DTI\macrostructure\tracts\23_DTI_vol_ring1_RAI2RNAcc_thresh_25.xlsx');
data_RAI2RNAcc_MacS=cell2mat(RAI2RNAcc_MacS(:,3));
data_RAI2RNAcc_MacS(data_RAI2RNAcc_MacS==0) = NaN;

%functional
[~, ~, RAI2RNAcc_FA_Funct_avg] = xlsread('C:\Users\roopa\Documents\3_Risktaking_DTI\24_DTI\tabulated_vals\joined\Roopa\24_DTI_Roopa_RAI2RNAcc_FA_ring1.xlsx');
data_RAI2RNAcc_FA_Funct_avg=cell2mat(RAI2RNAcc_FA_Funct_avg(2:end,:));
data_RAI2RNAcc_FA_Funct_avg(data_RAI2RNAcc_FA_Funct_avg==0) = NaN;

[~, ~, RAI2RNAcc_FA_Funct_self] = xlsread('C:\Users\roopa\Documents\3_Risktaking_DTI\24_DTI\tabulated_vals_self\joined\Roopa\24_DTI_Roopa_RAI2RNAcc_FA_ring1.xlsx');
data_RAI2RNAcc_FA_Funct_self=cell2mat(RAI2RNAcc_FA_Funct_self(2:end,:));
data_RAI2RNAcc_FA_Funct_self(data_RAI2RNAcc_FA_Funct_self==0) = NaN;


[~,~,RAI2RNAcc_MacF]=xlsread('C:\Users\roopa\Documents\3_Risktaking_DTI\24_DTI\macrostructure\tracts\24_DTI_vol_ring1_RAI2RNAcc_thresh_25.xlsx');
data_RAI2RNAcc_MacF=cell2mat(RAI2RNAcc_MacF(:,3));
data_RAI2RNAcc_MacF(data_RAI2RNAcc_MacF==0) = NaN;


%FS
[~,~,FSstats]=xlsread('C:\Users\roopa\Dropbox\3.Risk-taking_dti\3.Results\2.Freesurfer\FS_stats\18.09.21\FS_stats.xlsx','AI_NAcc');
data_FSstats=cell2mat(FSstats(2:end,:));
data_FSstats(data_FSstats==0) = NaN;


%(2) average tracts
%(2.1) tesst for normality
%(2.1.1) Risk
%calc percent AST/NST
AST=logical(data_risk_dataset(:,10));
NST=logical(~AST);
percent_AST=mean(AST);
%calc normality of Risk measures (Anderson-Darling test for normality)
Risk_matrix=horzcat(data_risk_dataset(:,34),data_risk_dataset(:,63),data_risk_dataset(:,65));
[N_R1,p_R1]=adtest(data_risk_dataset(:,34));
[N_R2,p_R2]=adtest(data_risk_dataset(:,63));
[N_R3,p_R3]=adtest(data_risk_dataset(:,65));
figure ('Visible','off'); %fig1
[R_r,p_r] = corrplot(Risk_matrix,'type','Pearson','rows','pairwise','tail','right','varNames',{'RSf','RTI','ROI'});
imgExtension = '1_risk_matrix_corrplot';
saveas(gcf,fullfile(imgFolder, imgExtension), 'bmp');

%(2.1.2) FA: structural tract
X_SFA_avg=horzcat(data_RAI2RNAcc_FA_Struct_avg(:,1),data_RAI2RNAcc_FA_Struct_avg(:,61),data_RAI2RNAcc_FA_Struct_avg(:,121));
[N_SFA1_avg,p_SFA1_avg]=adtest(data_RAI2RNAcc_FA_Struct_avg(:,1));
[N_SFA2_avg,p_SFA2_avg]=adtest(data_RAI2RNAcc_FA_Struct_avg(:,61));
[N_SFA3_avg,p_SFA3_avg]=adtest(data_RAI2RNAcc_FA_Struct_avg(:,121));
figure ('Visible','off'); %fig2
[R_SFA_avg,p_SFA_avg] = corrplot(X_SFA_avg,'type','Pearson','rows','pairwise','tail','right','varNames',{'00,00','25,25','50,50'});
imgExtension = '2_struct_0000_2525_5050_corrplot';
saveas(gcf,fullfile(imgFolder, imgExtension), 'bmp');

%(2.1.3) FA: functional tract
X_FFA_avg=horzcat(data_RAI2RNAcc_FA_Funct_avg(:,1),data_RAI2RNAcc_FA_Funct_avg(:,61),data_RAI2RNAcc_FA_Funct_avg(:,121));
[N_FFA1_avg,p_FFA1_avg]=adtest(data_RAI2RNAcc_FA_Funct_avg(:,1));
[N_FFA2_avg,p_FFA2_avg]=adtest(data_RAI2RNAcc_FA_Funct_avg(:,61));
[N_FFA3_avg,p_FFA3_avg]=adtest(data_RAI2RNAcc_FA_Funct_avg(:,121));
figure ('Visible','off'); %fig3
[R_FFA_avg,p_FFA_avg] = corrplot(X_FFA_avg,'type','Pearson','rows','pairwise','tail','right','varNames',{'00,00','25,25','50,50'});
imgExtension = '3_funct_0000_2525_5050_corrplot';
saveas(gcf,fullfile(imgFolder, imgExtension), 'bmp');

%(2.2) Pearson correlation: FA (all thresholds) vs Risk measures
%(2.2.1) structural
% CALC
X_TvSS_avg=horzcat(Risk_matrix,data_RAI2RNAcc_FA_Struct_avg);%size: 124x124
[R_TvSS_avg,p_TvSS_avg] = corr(X_TvSS_avg,'type','Pearson','Rows','pairwise','tail','left');
%'left': Test the alternative hypothesis that the correlation is less than
%0. (i.e. a negative number, i.e. the more the FA the less the risk score)

%need to ignore correlations between items 1,2 and 3 (the risk measures)
%because they are obviously right-tailed correlations. can only enter one,
%so I'm entering left (correlation between each individual risk measure and
%the FA value)
R_FA_S_avg_RSf=R_TvSS_avg(1,4:end);
p_FA_S_avg_RSf=p_TvSS_avg(1,4:end);
R_FA_S_avg_RTI=R_TvSS_avg(2,4:end);
p_FA_S_avg_RTI=p_TvSS_avg(2,4:end);
R_FA_S_avg_ROI=R_TvSS_avg(3,4:end);
p_FA_S_avg_ROI=p_TvSS_avg(3,4:end);
graph_p_FA_S_avg_RSf = reshape(p_FA_S_avg_RSf,[11,11]);
graph_p_FA_S_avg_RTI = reshape(p_FA_S_avg_RTI,[11,11]);
graph_p_FA_S_avg_ROI = reshape(p_FA_S_avg_ROI,[11,11]);

% PLOT: FA;structural;RAI2RNAcc(p-val)
figure ('Visible','off'); %fig4
Vec_Thr1=0:5:50;
Vec_Thr2=0:5:50;
sc_x = Vec_Thr1;
sc_y = Vec_Thr2;
imagesc(sc_x, sc_y, graph_p_FA_S_avg_RSf)
set(gca,'YDir','normal')
caxis([0 1])
colormap(color_map)
colorbar;
% title('S, rh: RSf vs FA')
xlabel ('Thr1 (%)')
ylabel ('Thr2 (%)')
imgExtension = '4_struct_FA_RSf';
saveas(gcf,fullfile(imgFolder, imgExtension), 'bmp');

figure ('Visible','off'); %fig5
Vec_Thr1=0:5:50;
Vec_Thr2=0:5:50;
sc_x = Vec_Thr1;
sc_y = Vec_Thr2;
imagesc(sc_x, sc_y, graph_p_FA_S_avg_RTI)
set(gca,'YDir','normal')
caxis([0 1])
colormap(color_map)
colorbar;
% title('S, rh: RTI vs FA')
xlabel ('Thr1 (%)')
ylabel ('Thr2 (%)')
imgExtension = '5_struct_FA_RTI';
saveas(gcf,fullfile(imgFolder, imgExtension), 'bmp');

figure ('Visible','off'); %fig6
Vec_Thr1=0:5:50;
Vec_Thr2=0:5:50;
sc_x = Vec_Thr1;
sc_y = Vec_Thr2;
imagesc(sc_x, sc_y, graph_p_FA_S_avg_ROI)
set(gca,'YDir','normal')
caxis([0 1])
colormap(color_map)
colorbar;
% title('S, rh: ROI vs FA')
xlabel ('Thr1 (%)')
ylabel ('Thr2 (%)')
imgExtension = '6_struct_FA_ROI';
saveas(gcf,fullfile(imgFolder, imgExtension), 'bmp');

%(2.2.2) functional
% CALC
X_TvSF_avg=horzcat(Risk_matrix,data_RAI2RNAcc_FA_Funct_avg);%size: 124x124
[R_TvSF_avg,p_TvSF_avg] = corr(X_TvSF_avg,'type','Pearson','Rows','pairwise','tail','left');
%'left': Test the alternative hypothesis that the correlation is less than
%0. (i.e. a negative number, i.e. the more the FA the less the risk score)

%need to ignore correlations between items 1,2 and 3 (the risk measures)
%because they are obviously right-tailed correlations. can only enter one,
%so I'm entering left (correlation between each individual risk measure and
%the FA value)
R_FA_F_avg_RSf=R_TvSF_avg(1,4:end);
p_FA_F_avg_RSf=p_TvSF_avg(1,4:end);
R_FA_F_avg_RTI=R_TvSF_avg(2,4:end);
p_FA_F_avg_RTI=p_TvSF_avg(2,4:end);
R_FA_F_avg_ROI=R_TvSF_avg(3,4:end);
p_FA_F_avg_ROI=p_TvSF_avg(3,4:end);
graph_p_FA_F_avg_RSf = reshape(p_FA_F_avg_RSf,[11,11]);
graph_p_FA_F_avg_RTI = reshape(p_FA_F_avg_RTI,[11,11]);
graph_p_FA_F_avg_ROI = reshape(p_FA_F_avg_ROI,[11,11]);

% PLOT: FA;functional;RAI2RNAcc(p-val)
figure ('Visible','off'); %fig7
Vec_Thr1=0:5:50;
Vec_Thr2=0:5:50;
sc_x = Vec_Thr1;
sc_y = Vec_Thr2;
imagesc(sc_x, sc_y, graph_p_FA_F_avg_RSf)
set(gca,'YDir','normal')
caxis([0 1])
colormap(color_map)
colorbar;
% title('F, rh: RSf vs FA')
xlabel ('Thr1 (%)')
ylabel ('Thr2 (%)')
imgExtension = '7_funct_FA_RSf';
saveas(gcf,fullfile(imgFolder, imgExtension), 'bmp');

figure ('Visible','off'); %fig8
Vec_Thr1=0:5:50;
Vec_Thr2=0:5:50;
sc_x = Vec_Thr1;
sc_y = Vec_Thr2;
imagesc(sc_x, sc_y, graph_p_FA_F_avg_RTI)
set(gca,'YDir','normal')
caxis([0 1])
colormap(color_map)
colorbar;
% title('F, rh: RTI vs FA')
xlabel ('Thr1 (%)')
ylabel ('Thr2 (%)')
imgExtension = '8_funct_FA_RTI';
saveas(gcf,fullfile(imgFolder, imgExtension), 'bmp');

figure ('Visible','off'); %fig9
Vec_Thr1=0:5:50;
Vec_Thr2=0:5:50;
sc_x = Vec_Thr1;
sc_y = Vec_Thr2;
imagesc(sc_x, sc_y, graph_p_FA_F_avg_ROI)
set(gca,'YDir','normal')
caxis([0 1])
colormap(color_map)
colorbar;
% title('F, rh: ROI vs FA')
xlabel ('Thr1 (%)')
ylabel ('Thr2 (%)')
imgExtension = '9_funct_FA_ROI';
saveas(gcf,fullfile(imgFolder, imgExtension), 'bmp');

%(2.3) two-sample t-test: FA(25_25) for AST vs NST
% TEST USED: Two-sample t-test
%h = ttest2(x,y) returns a test decision for the null hypothesis that the
% data in vectors x and y comes from independent random samples from
% normal distributions with equal means and equal but unknown variances, 
% using the two-sample t-test. The alternative hypothesis is that the data 
% in x and y comes from populations with unequal means. The result h is 1 
% if the test rejects the null hypothesis at the 5% significance level, 
% and 0 otherwise.

%(2.3.1) structural
%get FA vals into two vectors using 1vs0 from AST (&NST resp.) vec as index
Struct_fin_avg=data_RAI2RNAcc_FA_Struct_avg(:,61);
FA_S_avg_AST=Struct_fin_avg(AST);
FA_S_avg_NST=Struct_fin_avg(NST);
[h_AST_S_avg,p_AST_S_avg,ci_AST_S_avg,stats_AST_S_avg]=ttest2(FA_S_avg_AST,FA_S_avg_NST,'Tail','left');
%left-tailed t-test: Test the alternative hypothesis that the population mean of x is less than the population mean of y.

%(2.3.2) functional
%get FA vals into two vectors using 1vs0 from AST (&NST resp.) vec as index
Funct_fin_avg=data_RAI2RNAcc_FA_Funct_avg(:,61);
FA_F_avg_AST=Funct_fin_avg(AST);
FA_F_avg_NST=Funct_fin_avg(NST);
[h_AST_F_avg,p_AST_F_avg,ci_AST_F_avg,stats_AST_F_avg]=ttest2(FA_F_avg_AST,FA_F_avg_NST,'Tail','left');
%left-tailed t-test: Test the alternative hypothesis that the population mean of x is less than the population mean of y.

%(3) self tracts
%(3.1) test for normality
% %(3.1.1) Risk
% % done above

%(3.1.2) FA: structural tract
X_SFA_self=horzcat(data_RAI2RNAcc_FA_Struct_self(:,1),data_RAI2RNAcc_FA_Struct_self(:,6),data_RAI2RNAcc_FA_Struct_self(:,11));
[N_SFA1_self,p_SFA1_self]=adtest(data_RAI2RNAcc_FA_Struct_self(:,1));
[N_SFA2_self,p_SFA2_self]=adtest(data_RAI2RNAcc_FA_Struct_self(:,6));
[N_SFA3_self,p_SFA3_self]=adtest(data_RAI2RNAcc_FA_Struct_self(:,11));
figure ('Visible','off'); %fig10
[R_SFA_self,p_SFA_self] = corrplot(X_SFA_self,'type','Pearson','rows','pairwise','tail','right','varNames',{'0','25','50'});
imgExtension = '10_struct_self';
saveas(gcf,fullfile(imgFolder, imgExtension), 'bmp');

%(3.1.3) FA: functional tract
X_FFA_self=horzcat(data_RAI2RNAcc_FA_Funct_self(:,1),data_RAI2RNAcc_FA_Funct_self(:,6),data_RAI2RNAcc_FA_Funct_self(:,11));
[N_FFA1_self,p_FFA1_self]=adtest(data_RAI2RNAcc_FA_Funct_self(:,1));
[N_FFA2_self,p_FFA2_self]=adtest(data_RAI2RNAcc_FA_Funct_self(:,6));
[N_FFA3_self,p_FFA3_self]=adtest(data_RAI2RNAcc_FA_Funct_self(:,11));
figure ('Visible','off'); %fig11
[R_FFA_self,p_FFA_self] = corrplot(X_FFA_self,'type','Pearson','rows','pairwise','tail','right','varNames',{'0','25','50'});
imgExtension = '11_funct_self';
saveas(gcf,fullfile(imgFolder, imgExtension), 'bmp');

%(3.2) Pearson correlation: FA (all thresholds) vs Risk measures
%(3.2.1) structural
% CALC
X_TvSS_self=horzcat(Risk_matrix,data_RAI2RNAcc_FA_Struct_self);%size: 14x14
[R_TvSS_self,p_TvSS_self] = corr(X_TvSS_self,'type','Pearson','Rows','pairwise','tail','left');
%'left': Test the alternative hypothesis that the correlation is less than
%0. (i.e. a negative number, i.e. the more the FA the less the risk score)

%need to ignore correlations between items 1,2 and 3 (the risk measures)
%because they are obviously right-tailed correlations. can only enter one,
%so I'm entering left (correlation between each individual risk measure and
%the FA value)
R_FA_S_self_RSf=R_TvSS_self(1,4:end);
p_FA_S_self_RSf=p_TvSS_self(1,4:end);
R_FA_S_self_RTI=R_TvSS_self(2,4:end);
p_FA_S_self_RTI=p_TvSS_self(2,4:end);
R_FA_S_self_ROI=R_TvSS_self(3,4:end);
p_FA_S_self_ROI=p_TvSS_self(3,4:end);

%(3.2.2) functional
% CALC
X_TvSF_self=horzcat(Risk_matrix,data_RAI2RNAcc_FA_Funct_self);%size: 14x14
[R_TvSF_self,p_TvSF_self] = corr(X_TvSF_self,'type','Pearson','Rows','pairwise','tail','left');
%'left': Test the alternative hypothesis that the correlation is less than
%0. (i.e. a negative number, i.e. the more the FA the less the risk score)

%need to ignore correlations between items 1,2 and 3 (the risk measures)
%because they are obviously right-tailed correlations. can only enter one,
%so I'm entering left (correlation between each individual risk measure and
%the FA value)
R_FA_F_self_RSf=R_TvSF_self(1,4:end);
p_FA_F_self_RSf=p_TvSF_self(1,4:end);
R_FA_F_self_RTI=R_TvSF_self(2,4:end);
p_FA_F_self_RTI=p_TvSF_self(2,4:end);
R_FA_F_self_ROI=R_TvSF_self(3,4:end);
p_FA_F_self_ROI=p_TvSF_self(3,4:end);

%(3.3) two-sample t-test: FA(25) for AST vs NST
% TEST USED: Two-sample t-test
%h = ttest2(x,y) returns a test decision for the null hypothesis that the
% data in vectors x and y comes from independent random samples from
% normal distributions with equal means and equal but unknown variances, 
% using the two-sample t-test. The alternative hypothesis is that the data 
% in x and y comes from populations with unequal means. The result h is 1 
% if the test rejects the null hypothesis at the 5% significance level, 
% and 0 otherwise.

%(3.3.1) structural
%get FA vals into two vectors using 1vs0 from AST (&NST resp.) vec as index
Struct_fin_self=data_RAI2RNAcc_FA_Struct_self(:,6);
FA_S_self_AST=Struct_fin_self(AST);
FA_S_self_NST=Struct_fin_self(NST);
[h_AST_S_self,p_AST_S_self,ci_AST_S_self,stats_AST_S_self]=ttest2(FA_S_self_AST,FA_S_self_NST,'Tail','left');
%left-tailed t-test: Test the alternative hypothesis that the population mean of x is less than the population mean of y.

%(3.3.2) functional
%get FA vals into two vectors using 1vs0 from AST (&NST resp.) vec as index
Funct_fin_self=data_RAI2RNAcc_FA_Funct_self(:,6);
FA_F_self_AST=Funct_fin_self(AST);
FA_F_self_NST=Funct_fin_self(NST);
[h_AST_F_self,p_AST_F_self,ci_AST_F_self,stats_AST_F_self]=ttest2(FA_F_self_AST,FA_F_self_NST,'Tail','left');
%left-tailed t-test: Test the alternative hypothesis that the population mean of x is less than the population mean of y.

%(4) Stanford
%(4.1) test for normality, FA: Stanford
X_StanfordFA=horzcat(data_RAI2RNAcc_FA_Stanford(:,1),data_RAI2RNAcc_FA_Stanford(:,6),data_RAI2RNAcc_FA_Stanford(:,11));
[N_StanfordFA1,p_StanfordFA1]=adtest(data_RAI2RNAcc_FA_Stanford(:,1));
[N_StanfordFA2,p_StanfordFA2]=adtest(data_RAI2RNAcc_FA_Stanford(:,6));
[N_StanfordFA3,p_StanfordFA3]=adtest(data_RAI2RNAcc_FA_Stanford(:,11));
figure ('Visible','off'); %fig12
[R_StanfordFA,p_StanfordFA] = corrplot(X_StanfordFA,'type','Pearson','rows','pairwise','tail','right','varNames',{'00','25','50'});
imgExtension = '12_Stanford_0000_0025_0050_corrplot';
saveas(gcf,fullfile(imgFolder, imgExtension), 'bmp');

%(4.2) Pearson correlation: FA (all thresholds) vs Risk measures
% CALC
X_TvSStanford=horzcat(Risk_matrix,data_RAI2RNAcc_FA_Stanford);%size: 14x14
[R_TvSStanford,p_TvSStanford] = corr(X_TvSStanford,'type','Pearson','Rows','pairwise','tail','left');
%'left': Test the alternative hypothesis that the correlation is less than
%0. (i.e. a negative number, i.e. the more the FA the less the risk score)

%need to ignore correlations between items 1,2 and 3 (the risk measures)
%because they are obviously right-tailed correlations. can only enter one,
%so I'm entering left (correlation between each individual risk measure and
%the FA value)
R_FA_Stanford_RSf=R_TvSStanford(1,4:end);
p_FA_Stanford_RSf=p_TvSStanford(1,4:end);
R_FA_Stanford_RTI=R_TvSStanford(2,4:end);
p_FA_Stanford_RTI=p_TvSStanford(2,4:end);
R_FA_Stanford_ROI=R_TvSStanford(3,4:end);
p_FA_Stanford_ROI=p_TvSStanford(3,4:end);

%(4.3) two-sample t-test: FA(25) for AST vs NST
% TEST USED: Two-sample t-test
%h = ttest2(x,y) returns a test decision for the null hypothesis that the
% data in vectors x and y comes from independent random samples from
% normal distributions with equal means and equal but unknown variances, 
% using the two-sample t-test. The alternative hypothesis is that the data 
% in x and y comes from populations with unequal means. The result h is 1 
% if the test rejects the null hypothesis at the 5% significance level, 
% and 0 otherwise.

%get FA vals into two vectors using 1vs0 from AST (&NST resp.) vec as index
Stanford_fin=data_RAI2RNAcc_FA_Stanford(:,6);
FA_Stanford_AST=Stanford_fin(AST);
FA_Stanford_NST=Stanford_fin(NST);
[h_AST_Stanford,p_AST_Stanford,ci_AST_Stanford,stats_AST_Stanford]=ttest2(FA_Stanford_AST,FA_Stanford_NST,'Tail','left');
%left-tailed t-test: Test the alternative hypothesis that the population mean of x is less than the population mean of y.

%(5) Macrostructure: Tract
% (5.1) structural
%  AD test for normality
[N_MacS_avg,p_MacS_avg]=adtest(data_RAI2RNAcc_MacS);

%risk measures
X_MacS=horzcat(Risk_matrix,data_RAI2RNAcc_MacS);
[R_MacS,p_MacS] = corr(X_MacS,'type','Pearson','Rows','pairwise');
R_MacS_RSf=R_MacS(1,4:end);
p_MacS_RSf=p_MacS(1,4:end);
R_MacS_RTI=R_MacS(2,4:end);
p_MacS_RTI=p_MacS(2,4:end);
R_MacS_ROI=R_MacS(3,4:end);
p_MacS_ROI=p_MacS(3,4:end);

%AST/NST t-test
MacS_fin=data_RAI2RNAcc_MacS;
MacS_AST=MacS_fin(AST);
MacS_NST=MacS_fin(NST);
[h_AST_MacS,p_AST_MacS,ci_AST_MacS,stats_AST_MacS]=ttest2(MacS_AST,MacS_NST,'Tail','left');

% (5.2) functional
%  AD test for normality
[N_MacF_avg,p_MacF_avg]=adtest(data_RAI2RNAcc_MacF);

% risk measures
X_MacF=horzcat(Risk_matrix,data_RAI2RNAcc_MacF);
[R_MacF,p_MacF] = corr(X_MacF,'type','Pearson','Rows','pairwise');
R_MacF_RSf=R_MacF(1,4:end);
p_MacF_RSf=p_MacF(1,4:end);
R_MacF_RTI=R_MacF(2,4:end);
p_MacF_RTI=p_MacF(2,4:end);
R_MacF_ROI=R_MacF(3,4:end);
p_MacF_ROI=p_MacF(3,4:end);

%AST/NST t-test
MacF_fin=data_RAI2RNAcc_MacF;
MacF_AST=MacF_fin(AST);
MacF_NST=MacF_fin(NST);
[h_AST_MacF,p_AST_MacF,ci_AST_MacF,stats_AST_MacF]=ttest2(MacF_AST,MacF_NST,'Tail','left');

% (6) Macrostructure Seed/Target (FreeSurfer)
% (6.1) AI-NAcc vec
TICV=data_FSstats(:,1);
NAcc_vol_lh=data_FSstats(:,2);
NAcc_vol_rh=data_FSstats(:,3);
AI_vol_lh=data_FSstats(:,7);
AI_vol_rh=data_FSstats(:,11);
AI_area_lh=data_FSstats(:,15);
AI_area_rh=data_FSstats(:,19);
AI_thickness_lh=data_FSstats(:,21); %only short gyri
AI_thickness_rh=data_FSstats(:,24); %only short gyri

% AD test for normality
%  AD test for normality
[N_NAcc_vol_lh,p_NAcc_vol_lh]=adtest(NAcc_vol_lh);
[N_NAcc_vol_rh,p_NAcc_vol_rh]=adtest(NAcc_vol_rh);
[N_AI_vol_lh,p_AI_vol_lh]=adtest(AI_vol_lh);
[N_AI_vol_rh,p_AI_vol_rh]=adtest(AI_vol_rh);
[N_AI_area_lh,p_AI_area_lh]=adtest(AI_area_lh);
[N_AI_area_rh,p_AI_area_rh]=adtest(AI_area_rh);
[N_AI_thickness_lh,p_AI_thickness_lh]=adtest(AI_thickness_lh);
[N_AI_thickness_rh,p_AI_thickness_rh]=adtest(AI_thickness_rh);

% (6.2) risk measures
X_Mac_FS=horzcat(Risk_matrix,NAcc_vol_lh,NAcc_vol_rh,AI_vol_lh,AI_vol_rh,AI_area_lh,AI_area_rh,AI_thickness_lh,AI_thickness_rh);
[R_Mac_FS,p_Mac_FS] = partialcorr(X_Mac_FS,TICV,'type','Pearson','Rows','pairwise');
% [R_Mac_FS,p_Mac_FS] = corr(X_Mac_FS,'type','Pearson','Rows','pairwise');
R_Mac_FS_RSf=R_Mac_FS(1,4:end);
p_Mac_FS_RSf=p_Mac_FS(1,4:end);
R_Mac_FS_RTI=R_Mac_FS(2,4:end);
p_Mac_FS_RTI=p_Mac_FS(2,4:end);
R_Mac_FS_ROI=R_Mac_FS(3,4:end);
p_Mac_FS_ROI=p_Mac_FS(3,4:end);

% (6.3) AST/NST t-test
%(NAcc_vol_lh)
NAcc_vol_lh_AST=NAcc_vol_lh(AST);
NAcc_vol_lh_NST=NAcc_vol_lh(NST);
[h_AST_NAcc_vol_lh,p_AST_NAcc_vol_lh,ci_AST_NAcc_vol_lh,stats_AST_NAcc_vol_lh]=ttest2(NAcc_vol_lh_AST,NAcc_vol_lh_NST);
%(NAcc_vol_rh)
NAcc_vol_rh_AST=NAcc_vol_rh(AST);
NAcc_vol_rh_NST=NAcc_vol_rh(NST);
[h_AST_NAcc_vol_rh,p_AST_NAcc_vol_rh,ci_AST_NAcc_vol_rh,stats_AST_NAcc_vol_rh]=ttest2(NAcc_vol_rh_AST,NAcc_vol_rh_NST);
%(AI_vol_lh)
AI_vol_lh_AST=AI_vol_lh(AST);
AI_vol_lh_NST=AI_vol_lh(NST);
[h_AST_AI_vol_lh,p_AST_AI_vol_lh,ci_AST_AI_vol_lh,stats_AST_AI_vol_lh]=ttest2(AI_vol_lh_AST,AI_vol_lh_NST);
%(AI_vol_rh)
AI_vol_rh_AST=AI_vol_rh(AST);
AI_vol_rh_NST=AI_vol_rh(NST);
[h_AST_AI_vol_rh,p_AST_AI_vol_rh,ci_AST_AI_vol_rh,stats_AST_AI_vol_rh]=ttest2(AI_vol_rh_AST,AI_vol_rh_NST);
%(AI_area_lh)
AI_area_lh_AST=AI_area_lh(AST);
AI_area_lh_NST=AI_area_lh(NST);
[h_AST_AI_area_lh,p_AST_AI_area_lh,ci_AST_AI_area_lh,stats_AST_AI_area_lh]=ttest2(AI_area_lh_AST,AI_area_lh_NST);
%(AI_area_rh)
AI_area_rh_AST=AI_area_rh(AST);
AI_area_rh_NST=AI_area_rh(NST);
[h_AST_AI_area_rh,p_AST_AI_area_rh,ci_AST_AI_area_rh,stats_AST_AI_area_rh]=ttest2(AI_area_rh_AST,AI_area_rh_NST);
%(AI_thickness_lh)
AI_thickness_lh_AST=AI_thickness_lh(AST);
AI_thickness_lh_NST=AI_thickness_lh(NST);
[h_AST_AI_thickness_lh,p_AST_AI_thickness_lh,ci_AST_AI_thickness_lh,stats_AST_AI_thickness_lh]=ttest2(AI_thickness_lh_AST,AI_thickness_lh_NST);
%(AI_thickness_rh)
AI_thickness_rh_AST=AI_thickness_rh(AST);
AI_thickness_rh_NST=AI_thickness_rh(NST);
[h_AST_AI_thickness_rh,p_AST_AI_thickness_rh,ci_AST_AI_thickness_rh,stats_AST_AI_thickness_rh]=ttest2(AI_thickness_rh_AST,AI_thickness_rh_NST);

%save workspace
save(fullfile(imgFolder,strcat('workspace_',folder)));