function [images] = read_img(src_path)
    files = dir([src_path, '\*.jpg']);

    % get images info to initialize images
    NumberOfImage = numel(files);
    filename = [src_path, '\', files(1).name];
   
    img_info = imfinfo(filename); % need complete path
    channel = img_info.NumberOfSamples;
    width = img_info.Width;
    height = img_info.Height;
    
    images = zeros(height, width, channel, NumberOfImage);

    for i = 1:NumberOfImage
        filename = [src_path, '\', files(i).name];
        images(:, :, :, i) = imread(filename);
    end
    
end
