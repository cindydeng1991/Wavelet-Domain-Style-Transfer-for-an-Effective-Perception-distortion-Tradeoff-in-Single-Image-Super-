clear
addpath('utils')
directory1 = 'ImageAp'; % direction to Images with high perceptual quality
directory2 = 'ImageAo';  %direction to Images with high objective quality
pattern = '*.png';

Ap_path = glob(directory1, pattern );
Ap_cell = load_images_3channel( Ap_path );

Ao_path = glob(directory2, pattern );
Ao_cell = load_images_3channel( Ao_path );
para=[]; % store the normalization paramters
filter='haar'; % wavelet filter

for img_dex=1:length(Ap_cell)

Ap=Ap_cell{img_dex};
Ao=Ao_cell{img_dex};

[gac,ghc,gvc,gdc]=swt2(Ap,2,filter); 
[gae,ghe,gve,gde]=swt2(Ao,2,filter);

% LL sub-band
LL=gae(:,:,:,2); 
para(1,1)=min(min(min(LL)));
LL=LL-para(1,1);
para(1,2)=max(max(max(LL)));
LL=LL./para(1,2);
imwrite(LL,[num2str(img_dex+100,'%d') '_LL.png']);  clear LL; 
% % gh level1
ghc_l1=ghc(:,:,:,1); ghe_l1=ghe(:,:,:,1); 
para(2,1)=find_minimum(ghc_l1,ghe_l1);
ghc_l1=ghc_l1-para(2,1);
ghe_l1=ghe_l1-para(2,1);
para(2,2)=find_maximum(ghc_l1,ghe_l1);
ghc_l1=ghc_l1./para(2,2);
ghe_l1=ghe_l1./para(2,2);
imwrite(ghc_l1,[num2str(img_dex+100,'%d') '_style_gh_level1.png']);  clear ghc_l1 
imwrite(ghe_l1,[num2str(img_dex+100,'%d') '_content_gh_level1.png']);  clear   ghe_l1
% % gv level1
gvc_l1=gvc(:,:,:,1); gve_l1=gve(:,:,:,1); 
para(3,1)=find_minimum(gvc_l1,gve_l1);
gvc_l1=gvc_l1-para(3,1);
gve_l1=gve_l1-para(3,1);
para(3,2)=find_maximum(gvc_l1,gve_l1);
gvc_l1=gvc_l1./para(3,2);
gve_l1=gve_l1./para(3,2);
imwrite(gvc_l1,[num2str(img_dex+100,'%d') '_style_gv_level1.png']);  clear gvc_l1  
imwrite(gve_l1,[num2str(img_dex+100,'%d') '_content_gv_level1.png']); clear   gve_l1
% % gd level1
gdc_l1=gdc(:,:,:,1); gde_l1=gde(:,:,:,1); 
para(4,1)=find_minimum(gdc_l1,gde_l1);
gdc_l1=gdc_l1-para(4,1);
gde_l1=gde_l1-para(4,1);
para(4,2)=find_maximum(gdc_l1,gde_l1);
gdc_l1=gdc_l1./para(4,2);
gde_l1=gde_l1./para(4,2);
imwrite(gdc_l1,[num2str(img_dex+100,'%d') '_style_gd_level1.png']);  clear gdc_l1  
imwrite(gde_l1,[num2str(img_dex+100,'%d') '_content_gd_level1.png']); clear   gde_l1
% % gh level2
ghc_l2=ghc(:,:,:,2); ghe_l2=ghe(:,:,:,2); 
para(5,1)=find_minimum(ghc_l2,ghe_l2);
ghc_l2=ghc_l2-para(5,1);
ghe_l2=ghe_l2-para(5,1);
para(5,2)=find_maximum(ghc_l2,ghe_l2);
ghc_l2=ghc_l2./para(5,2);
ghe_l2=ghe_l2./para(5,2);
imwrite(ghc_l2,[num2str(img_dex+100,'%d') '_style_gh_level2.png']); 
imwrite(ghe_l2,[num2str(img_dex+100,'%d') '_content_gh_level2.png']); 
% % gv level2
gvc_l2=gvc(:,:,:,2); gve_l2=gve(:,:,:,2); 
para(6,1)=find_minimum(gvc_l2,gve_l2);
gvc_l2=gvc_l2-para(6,1);
gve_l2=gve_l2-para(6,1);
para(6,2)=find_maximum(gvc_l2,gve_l2);
gvc_l2=gvc_l2./para(6,2);
gve_l2=gve_l2./para(6,2);
imwrite(gvc_l2,[num2str(img_dex+100,'%d') '_style_gv_level2.png']); 
imwrite(gve_l2,[num2str(img_dex+100,'%d') '_content_gv_level2.png']); 
% % gd level2
gdc_l2=gdc(:,:,:,2); gde_l2=gde(:,:,:,2); 
para(7,1)=find_minimum(gdc_l2,gde_l2);
gdc_l2=gdc_l2-para(7,1);
gde_l2=gde_l2-para(7,1);
para(7,2)=find_maximum(gdc_l2,gde_l2);
gdc_l2=gdc_l2./para(7,2);
gde_l2=gde_l2./para(7,2);
imwrite(gdc_l2,[num2str(img_dex+100,'%d') '_style_gd_level2.png']); 
imwrite(gde_l2,[num2str(img_dex+100,'%d') '_content_gd_level2.png']);
% 
 para_all{img_dex}=para; clear para
end
save  para_all para_all


