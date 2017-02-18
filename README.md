# Two-Tier Tissue Decomposition for Histopathological Image Representation and Classification
In this work, aim is to design a classification system for histopathological images. Towards this end, we present a new model for effective representation of these images that will be used by the classification system. The contributions of this model are twofold. First, it introduces a new two-tier tissue decomposition method for defining a set of multityped objects in an image. Different than the previous studies, these objects are defined combining texture, shape, and size information and they may correspond to individual histological tissue components as well as local tissue subregions of different characteristics. As its second contribution, it defines a new metric, which we call dominant blob scale, to characterize the shape and size of an object with a single scalar value. Our experiments on colon tissue images reveal that this new object definition and characterization provides distinguishing representation of normal and cancerous histopathological images, which is effective to obtain more accurate classification results compared to its counterparts.

NOTE: The following source codes are provided for research purposes only. The authors have no responsibility for any consequences of use of these source codes. If you use any part of the codes, please cite the following paper.

T. Gultekin, C. Koyuncu, C. Sokmensuer, and C. Gunduz-Demir, "Two-tier tissue decomposition for histopathological image representation and classification," IEEE Trans. Med. Imag., vol.34, no.1, pp.275–283, Jan. 2015.

Model parameters to be adjusted ():
K        : cluster number
sizeThr  : area threshold
cPercent : covered pixel percentage
edgeThr  : edge threshold
C        : SVM optimization parameter

Before run this program, create two txt files containing filenames of images together with their class labels, for the training and test sets. 
After that, assign the name of the created filenames to the variables trainFilename and testFilename in lines 59 and 60.
 
To improve the efficiency, the "for" loop in line 5 of "src/getDataset.m" can be executed in parallel using "parfor".
 
Each line should have the following format:
 - [image_file_name_with_its_path] [class_label]
 
For further questions feel free to email me at canfkoyuncu@gmail.com
