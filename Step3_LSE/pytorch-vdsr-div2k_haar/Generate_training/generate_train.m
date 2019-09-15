clear;close all;

folder1 = 'Training_dataset/LR';
folder2 = 'Training_dataset/HR';

savepath = 'div2k_64.h5';
size_input = 64;
size_label = 64;
stride = 63;

%% scale factors

%% downsizing


%% initialization
data = zeros(size_input, size_input, 1, 1);
label = zeros(size_label, size_label, 1, 1);

count = 0;
margain = 0;

%% generate data
filepaths1 = [];filepaths2 = [];
filepaths1 = [filepaths1; dir(fullfile(folder1, '*.png'))];
filepaths2 = [filepaths2; dir(fullfile(folder2, '*.png'))];

for i = 1 : 99
    for flip = 1: 3
        %for degree = 1 : 4
                                              
                    image_HR = imread(fullfile(folder2,filepaths2(i).name));
                    image_LR = imread(fullfile(folder1,filepaths1(i).name));
                                       
                    
                    if flip == 1
                        image_LR = flipdim(image_LR ,1);
                        image_HR = flipdim(image_HR ,1);
                    end
                    if flip == 2
                        image_LR = flipdim(image_LR ,2);
                        image_HR = flipdim(image_HR ,2);
                    end
                    
                    %image_LR = imrotate(image_LR, 90 * (degree - 1));
                    %image_HR = imrotate(image_HR, 90 * (degree - 1));
                  
                    
                    if size(image_LR,3)==3            
                        image_LR = rgb2ycbcr(image_LR);
                        image_LR = im2double(image_LR(:, :, 1));
                        image_HR = rgb2ycbcr(image_HR);
                        image_HR = im2double(image_HR(:, :, 1));

                        im_label = image_HR;
                        [hei,wid] = size(im_label);
                        im_input = image_LR;
                        filepaths2(i).name
                        for x = 1 : stride : hei-size_input+1
                            for y = 1 :stride : wid-size_input+1

                                subim_input = im_input(x : x+size_input-1, y : y+size_input-1);
                                subim_label = im_label(x : x+size_label-1, y : y+size_label-1);
                                
                                count=count+1;

                                data(:, :, 1, count) = subim_input;
                                label(:, :, 1, count) = subim_label;
                            end
                        end
                    end
       % end    
          
    end
end

order = randperm(count);
data = data(:, :, 1, order);
label = label(:, :, 1, order); 

%% writing to HDF5
chunksz = 64;
created_flag = false;
totalct = 0;

for batchno = 1:floor(count/chunksz)
    batchno
    last_read=(batchno-1)*chunksz;
    batchdata = data(:,:,1,last_read+1:last_read+chunksz); 
    batchlabs = label(:,:,1,last_read+1:last_read+chunksz);

    startloc = struct('dat',[1,1,1,totalct+1], 'lab', [1,1,1,totalct+1]);
    curr_dat_sz = store2hdf5(savepath, batchdata, batchlabs, ~created_flag, startloc, chunksz); 
    created_flag = true;
    totalct = curr_dat_sz(end);
end

h5disp(savepath);
