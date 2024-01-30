dirName_SPs='C:\Users\roopa\Documents\3_Risktaking_DTI\29_DTI\SPs\ring1';
SubjectsDir_old='C:\Users\roopa\Documents\3_Risktaking_DTI\31_DTI\4_subjects';
SubjectsDir='C:\Users\roopa\Documents\3_Risktaking_DTI\31_DTI\5_subjects';

SP_files=dir(fullfile(dirName_SPs,'*.txt'));
[~]=mkdir(dirName_SPs,'cleaned');
[~]=mkdir(SubjectsDir);
FR=zeros(size(SP_files,1),2);

for file_i=1:size(SP_files) 
    filename=fullfile(dirName_SPs,SP_files(file_i).name);
    subID=erase(SP_files(file_i).name,'_saved_paths.txt');
    fprintf('starting %s.\n',subID);
    [~]=mkdir(SubjectsDir,subID);
    if isfile(fullfile(SubjectsDir_old,subID,'tract_raw.mat'))
        disp('tract_raw.mat already exists');
        cd (fullfile(SubjectsDir_old,subID));
        tract_raw=load('tract_raw.mat');
        tract_raw=tract_raw.tract_raw;
        if isfile(fullfile(SubjectsDir_old,subID,'tract_cleaned.mat'))
            disp('tract_cleaned.mat already exists');
            tract_cleaned=load('tract_cleaned.mat');
            tract_cleaned=tract_cleaned.tract_cleaned;
        else
            maxDist = 3; % Remove fibers more than maxDist standard deviations from the tract core
            maxLen = 2; % Remove fibers more than maxLen standard deviations above the mean length
            numNodes = 100; % Sample each fiber to numNodes points
            M = 'mean'; % Compute the tract core with the function M
            maxIter = 1; % Maximum number of iterations
            count = true; % Display the number of fibers removed in each iteration
            tract_cleaned = AFQ_removeFiberOutliers(tract_raw,maxDist,maxLen,numNodes,M,count,maxIter);
            save(fullfile(SubjectsDir_old,subID,'tract_cleaned.mat'),'tract_cleaned');
        end
    else
        %(1) convert 'saved_paths.txt' file to format usable with AFQ
        fg_classified=fun_savedpaths_to_fgclassified(filename);
        %(2) clean tract with AFQ code (AFQ_example.m)
        tract_raw = fg_classified(1);
        maxDist = 3; % Remove fibers more than maxDist standard deviations from the tract core
        maxLen = 2; % Remove fibers more than maxLen standard deviations above the mean length
        numNodes = 100; % Sample each fiber to numNodes points
        M = 'mean'; % Compute the tract core with the function M
        maxIter = 1; % Maximum number of iterations
        count = true; % Display the number of fibers removed in each iteration
        tract_cleaned = AFQ_removeFiberOutliers(tract_raw,maxDist,maxLen,numNodes,M,count,maxIter);
        save(fullfile(SubjectsDir_old,subID,'tract_raw.mat'),'tract_raw');
        save(fullfile(SubjectsDir_old,subID,'tract_cleaned.mat'),'tract_cleaned');
    end
    
%     %(3) convert cleaned tract to nifti
    NIfTIImage = zeros(128, 128, 72, 'double');
    cleanedtract=tract_cleaned.fibers; %all streamlines in DTI coordinates
    for ct_i=1:size(cleanedtract,1) % for each streamline
        ct_streamline=cleanedtract{ct_i,1};
        for ct_j=1:size(ct_streamline,2) % for each point the streamline passes through
            i_x=round(ct_streamline(1,ct_j)); %...these are the x,y&z coordinates in DTI space
            i_y=round(ct_streamline(2,ct_j));
            i_z=round(ct_streamline(3,ct_j));
            if (i_x < 0)
                i_x=0;
            end
            if (i_y < 0)
                i_y=0;
            end
            if (i_z < 0)
                i_z=0;
            end
            NIfTIImage(i_x+1,i_y+1,i_z+1)=NIfTIImage(i_x+1,i_y+1,i_z+1)+1;
            % if a streamline passes through this voxel, add one to it. as
            % matlab starts indexing at 1, matrix with dim 128 goes from
            % 1->128 here (but 0->127 in list of coordinates we're reading
            % from). so need to add one to all coordinates when saving as
            % matlab matrix titled 'nifti image'.
        end
    end
    
    %OP_dirName=strcat(dirName,'cleaned\');
    %niftiwrite(NIfTIImage,strcat(OP_dirName,OP_filename,'_cleaned.nii'),'Compressed',true);
    niftiwrite(NIfTIImage,fullfile(SubjectsDir,subID,strcat(subID,'_cleaned.nii')),'Compressed',true);

    FR(file_i,1)=size(tract_raw.fibers,1);
    FR(file_i,2)=size(tract_cleaned.fibers,1);
    FR(file_i,3)=FR(file_i,1)-FR(file_i,2);
    FR(file_i,4)=FR(file_i,3) *100 / FR(file_i,1);
end
xlswrite(fullfile(SubjectsDir,'FibersRemoved.xlsx'),FR)
FR_headings={'nFib_raw','nFib_cleaned','nFib_removed','pc_Fib_removed'};
    
% %range of raw fibers
% FR_max=max(FR(:,1));
% FR_min=min(FR(:,1));
% 
% %average % of fibers removed in cleaning
% FR_pc_avg=mean(FR(:,4));