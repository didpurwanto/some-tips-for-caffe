This file will tell you how to use your own dataset to train with Caffe
1、create train and val folder, which contains train and test images
    for example:
	data/train/
	data/test/
	
2、use the label-image-for-caffe.py file to create train.txt and val.txt
   usage of label-image-for-caffe
   cmd python label-image-for-caffe.py -t 001/  001 is the class folder for the images

3、convert_imageset
   use the convert_imageset.exe to convert the images
   usage of convert_imageset.exe
   cmd convert_imageset --resize_height=256 --resize_width=256 --shuffle --backend=leveldb data/train/ data/train.txt data/trainldb
   
4、compute_image_mean
   use the compute_image_mean.exe to compute the mean file
   usage of compute_image_mean.exe
   cmd compute_image_mean --backend=leveldb data/trainldb mean.binaryproto
   
5、some warnings
   the train.txt and val.txt cannot contains empty lines in it! The convert_imageset.exe may cannot work!!!
    