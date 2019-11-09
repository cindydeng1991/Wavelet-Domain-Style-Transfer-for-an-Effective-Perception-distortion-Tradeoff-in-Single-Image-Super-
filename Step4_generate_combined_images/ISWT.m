clear
load para_all.mat
addpath('utils')

directory_gh_l1 = 'gh_level1'; 
directory_gv_l1 = 'gv_level1';
directory_gd_l1 = 'gd_level1';
directory_gh_l2 = 'gh_level2';
directory_gv_l2 = 'gv_level2';
directory_gd_l2 = 'gd_level2';
directory_LL    = 'LL';

pattern = '*.png';
filter='haar';

LL_path = glob(directory_LL, pattern );
LL_path_cell = load_images_3channel( LL_path );

gh_level1_path = glob(directory_gh_l1, pattern );
gh_level1_cell = load_images_3channel( gh_level1_path );

gv_level1_path = glob(directory_gv_l1, pattern );
gv_level1_cell = load_images_3channel( gv_level1_path );

gd_level1_path = glob(directory_gd_l1, pattern );
gd_level1_cell = load_images_3channel( gd_level1_path );

gh_level2_path = glob(directory_gh_l2, pattern );
gh_level2_cell = load_images_3channel( gh_level2_path );

gv_level2_path = glob(directory_gv_l2, pattern );
gv_level2_cell = load_images_3channel( gv_level2_path );

gd_level2_path = glob(directory_gd_l2, pattern );
gd_level2_cell = load_images_3channel( gd_level2_path );

%edsr_path = glob(directory_edsr, pattern );
%edsr_cell = load_images_3channel( edsr_path );



for i=1:length(gh_level1_cell)
para=para_all{i};

LL=LL_path_cell{i};
gh_l1=gh_level1_cell{i};
gv_l1=gv_level1_cell{i};
gd_l1=gd_level1_cell{i};
gh_l2=gh_level2_cell{i};
gv_l2=gv_level2_cell{i};
gd_l2=gd_level2_cell{i};

LL=LL.*para(1,2)+para(1,1);
gh_l1=gh_l1.*para(2,2)+para(2,1);
gh_l1=gh_l1.*para(2,2)+para(2,1);
gv_l1=gv_l1.*para(3,2)+para(3,1);
gd_l1=gd_l1.*para(4,2)+para(4,1);
gh_l2=gh_l2.*para(5,2)+para(5,1);
gv_l2=gv_l2.*para(6,2)+para(6,1);
gd_l2=gd_l2.*para(7,2)+para(7,1);


da(:,:,:,2)=LL; 

dh(:,:,:,1)=gh_l1; dh(:,:,:,2)=gh_l2;
dv(:,:,:,1)=gv_l1; dv(:,:,:,2)=gv_l2;
dd(:,:,:,1)=gd_l1; dd(:,:,:,2)=gd_l2;
[h,w,~]=size(LL);
LL=reshape(LL,[h,w,1,3]);
gh_l2=reshape(gh_l2,[h,w,1,3]);
gv_l2=reshape(gv_l2,[h,w,1,3]);
gd_l2=reshape(gd_l2,[h,w,1,3]);
da(:,:,:,1)=iswt2(LL,gh_l2,gv_l2,gd_l2,filter);
Img = iswt2(da,dh,dv,dd,filter);
imwrite(Img,[num2str(i+100,'%d') '.png']);
clear da dh dv dd LL para Img
end
