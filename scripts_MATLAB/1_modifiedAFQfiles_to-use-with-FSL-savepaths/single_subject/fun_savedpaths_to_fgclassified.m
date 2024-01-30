function[struct_output]=fun_savedpaths_to_fgclassified(filename)
% convert output of FSL's probabilistic tractography (probtrackx2), saved
% as 'saved_paths.txt' to the format used as input by AFQ for tract cleaning
% (based off of fg_classified). Script tested for probtrackx2 tractography
% between a single seed and a single target.
    text_ring = fileread(filename);
    new_streamline = '\n';
    splitStr_ring = regexp(text_ring,new_streamline,'split');
    n_streamlines = size(find(~cellfun(@isempty,regexp(splitStr_ring,'#'))),2);

    stml_vec=find(~cellfun(@isempty,regexp(splitStr_ring,'#')));
    Cs = cell(size(stml_vec,2),1);
    struct_savepaths = struct('steps',cell(1,n_streamlines), 'coordinates',cell(1,n_streamlines));
    for i = 1:size(stml_vec,2)
        struct_savepaths(i).steps = splitStr_ring(1,stml_vec(i));
        if i == size(stml_vec,2)
            coords = splitStr_ring(1,(stml_vec(1,i)+1):end);
        else
            coords = splitStr_ring(1,(stml_vec(1,i)+1):(stml_vec(1,i+1)-1));
        end
        coords_join = strtrim(strjoin(coords,' '));
        newcoord = ' ';
        splitStr_coords = regexp(coords_join,newcoord,'split');
        coordmat=str2double(splitStr_coords);
        coordmat=reshape(coordmat,3,[]);
        struct_savepaths(i).coordinates = coordmat;
        Cs{i,1} = coordmat;
    end
    struct_output = struct('name',cell(1,1),'colorRgb',cell(1,1),'thickness',cell(1,1),'visible',cell(1,1),'seeds',cell(1,1),'seedRadius',cell(1,1),'seedVoxelOffsets',cell(1,1),'params',cell(1,1),'fibers',cell(1,1),'query_id',cell(1,1));
    struct_output(1).name = 'RAI2RNAcc';
    struct_output(1).colorRgb = [20,90,200];
    struct_output(1).thickness = -0.5000;
    struct_output(1).visible = 1;
    struct_output(1).seeds = [];
    struct_output(1).seedRadius = 0;
    struct_output(1).seedVoxelOffsets = [];
    struct_output(1).params = [];
    struct_output(1).fibers = Cs;
    struct_output(1).query_id = -1;
    return
end