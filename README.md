# Wavelet-Domain-Style-Transfer-for-an-Effective-Perception-distortion-Tradeoff-in-Single-Image-Super-
ICCV 2019 oral presentation
The results of different datasets can be downloaded from the following link: https://drive.google.com/file/d/1GXNNLoepD_Lx5Fz_O_lM9rusEhvxuT2r/view?usp=sharing

This is the implementation for the ICCV paper 'Wavelet Domain Style Transfer for an Effective Perception-distortion Tradeoff in Single Image Super-Resolution'. 

In the first step, you need to run the SWT.m to generate the LL sub-band, and six high-frequency sub-bands.

In the second step, please copy the high-frequency sub-bands generated above to the Content and Style files seperately, and then run the command.sh to perform wavelet domain style transfer. The VGG file can be downloaded from https://drive.google.com/file/d/1rCHPX-rgyplBWuM4n7Bk5-pZwqYKkeQx/view?usp=sharing, and then put it in the pre-trained_model file.

In the third step, the LL sub-band generated in the first step is further enhanced by VDSR network. Note that the network needs to be re-trained for different wavelet filters. The model provided is trained for haar filter only. 

In the fourth step, the generated LL and high-frequency sub-bands are re-combined into an image using inverse SWT by running ISWT.m.

The style transfer software code is modified based on https://github.com/hwalsuklee/tensorflow-style-transfer.
The NRQM score is calculated using the matlab code provided by PIRM challenge https://www.pirm2018.org/PIRM-SR.html. 
