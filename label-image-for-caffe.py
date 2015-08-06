# -*- coding: utf-8 -*-
# This file is for you to make your own dataset, you can very easy to label the dataset, and then finish the train.txt and val.txt file
# enjoy it 
import os
import argparse as ap

# Get the path of the training set
parser = ap.ArgumentParser()
parser.add_argument("-t", "--imagesSet", help="Path to images Set", required="True")
args = vars(parser.parse_args())

# Get the training classes names and store them in a list
imagesDir = args["imagesSet"]

#imagesDir = "/Users/willard/Pictures/first1000"


images_names = os.listdir(imagesDir)

f = open(''+str(imagesDir)+'.txt', "w")
for ind, str_each_file in enumerate(images_names):
    image_full_path = ' '.join([str_each_file, imagesDir])
    print 'wirte %s' % (image_full_path)
    f.writelines('%s\n' % image_full_path)
f.close