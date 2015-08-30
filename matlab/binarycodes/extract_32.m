function [scores ,list_im] = extract_32(y_ft_list_im)



%% input images
root_path = 'E:/FTP/';
fs = textread([root_path 'all_imgs.txt'], '%s');
N = length(fs);





if ischar(y_ft_list_im)
    %Assume it is a file contaning the list of images
    filename = y_ft_list_im;
    y_ft_list_im = read_cell(filename);
end
% Adjust the batch size and dim to match with models/bvlc_reference_caffenet/deploy.prototxt
batch_size = 10;
dim = 32;
disp(y_ft_list_im)
if mod(length(y_ft_list_im),batch_size)
    warning(['Assuming batches of ' num2str(batch_size) ' images rest will be filled with zeros'])
end

% init caffe network (spews logging info)
caffe.set_mode_cpu();
model_def_file = 'D:\CaffeNet\deploy_caffe.prototxt';
model_file = 'D:\CaffeNet\KevinNet_CIFAR10_48_iter_20000.caffemodel';
phase = 'test';
net=caffe.Net(model_def_file, model_file, phase);


d = load('ilsvrc_2012_mean.mat');
IMAGE_MEAN = d.image_mean;

% prepare input

num_images = length(y_ft_list_im);
y_ft_scores = zeros(dim,num_images,'single');
num_batches = ceil(length(y_ft_list_im)/batch_size)
initic=tic;
for bb = 1 : num_batches
    batchtic = tic;
    range = 1+batch_size*(bb-1):min(num_images,batch_size * bb);
    tic
    input_data = prepare_batch(y_ft_list_im(range),IMAGE_MEAN,batch_size);
    toc, tic
    fprintf('Batch %d out of %d %.2f%% Complete ETA %.2f seconds\n',...
        bb,num_batches,bb/num_batches*100,toc(initic)/bb*(num_batches-bb));
    %output_data = net('forward', {input_data});
    output_data = net.forward(input_data);
    toc
    output_data = squeeze(output_data{1});
    y_ft_scores(:,range) = output_data(:,mod(range-1,batch_size)+1);
    toc(batchtic)
end
toc(initic);
list_im = y_ft_list_im;
scores = y_ft_scores;
if exist('filename', 'var')
    save([filename '_KevinCIFAR32.probs.mat'],'list_im','scores','-v7.3');
end

