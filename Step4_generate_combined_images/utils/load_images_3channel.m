function imgs = load_images_3channel(paths)

imgs = cell(size(paths));
for i = 1:numel(paths)
    X = im2double(imread(paths{i}));
    imgs{i} = X;
end
