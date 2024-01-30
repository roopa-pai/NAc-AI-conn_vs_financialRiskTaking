%RKPai 20-02-2019

%Objective: visualize distribution of startpoints of retained streamlines.
%step#1: convert savedpaths file to structure format
%step#2: (commented out) clean the tract using AFQ toolbox
%step#3: create nifti file showing distribution of startpoints
% (every time a startpoint begins in a voxel, increase the intensity of the
% voxel by 1).

%NOTE: requires the function "fun_savedpaths_to_fgclassified.m";
%separate file.


%(0) create variable: full path of "saved_paths.txt" file obtained from
%FSL's probtrackx2

filename = ;%insert full filepath here

%(1) convert 'saved_paths.txt' file to format usable with AFQ
fg_classified=fun_savedpaths_to_fgclassified(filename);
tract_raw = fg_classified(1);
save(fullfile(SubjectsDir_old,subID,'tract_raw.mat'),'tract_raw');

% %(2) clean tract with AFQ code (AFQ_example.m)

% maxDist = 3; % Remove fibers more than maxDist standard deviations from the tract core
% maxLen = 2; % Remove fibers more than maxLen standard deviations above the mean length
% numNodes = 100; % Sample each fiber to numNodes points
% M = 'mean'; % Compute the tract core with the function M
% maxIter = 1; % Maximum number of iterations
% count = true; % Display the number of fibers removed in each iteration
% tract_cleaned = AFQ_removeFiberOutliers(tract_raw,maxDist,maxLen,numNodes,M,count,maxIter);
% save(fullfile(SubjectsDir_old,subID,'tract_cleaned.mat'),'tract_cleaned');

%(3) convert cleaned tract to nifti
NIfTIImage = zeros(128, 128, 72, 'double');
tract_array=tract_raw.fibers; %all streamlines in DTI coordinates
for ct_i=1:size(tract_array,1) % for each streamline
    ct_streamline=tract_array{ct_i,1};
    for ct_j=1:size(ct_streamline,2) % for each point the streamline passes through
        i_x=round(ct_streamline(1,ct_j)); %...these are the x,y&z coordinates in DTI space
        i_y=round(ct_streamline(2,ct_j));
        i_z=round(ct_streamline(3,ct_j));
        %note: technically, the "floor" may be better, but I used round
        %to get a more accurate idea of where the points are.
        if (i_x < 0)
        % in cases where the jitter made the startpoint start
        % outside the image in the negative
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

niftiwrite(NIfTIImage,fullfile(SubjectsDir,subID,strcat(subID,'_cleaned.nii')),'Compressed',true); 