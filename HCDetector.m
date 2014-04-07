%implement Harris corner detector
%=========================================================================
%input:
%   img:image being detected
%   theta:theta of Gaussian filter
%output:
%   O:all the feature points
%=========================================================================
function O = HCDetector(img,theta)
img = 54/256*img(:,:,1)+183/256*img(:,:,2)+19/256*img(:,:,3);
figure,imshow(uint8(img));
%%
%parameter setting
[Row,Col] = size(img);
w = fspecial('gaussian',[5,5],theta);%Gaussian function
fx = [1,0,-1;
      1,0,-1;
      1,0,-1];
fy = [1,1,1;
      0,0,0;
      -1,-1,-1];
Ix = filter2(fx,img);
Iy = filter2(fy,img);
Ix2 = filter2(w,Ix.^2);
Iy2 = filter2(w,Iy.^2);
Ixy = filter2(w,Ix.*Iy);
%%
%building R map
R = zeros(Row,Col);
k = 0.04;
threshold = 0;
for in1 = 1:Row
   for in2 = 1:Col
       M = [Ix2(in1,in2),Ixy(in1,in2);Ixy(in1,in2),Iy2(in1,in2)];
       R(in1,in2) = det(M)-k*(trace(M))^2;
       if(threshold<R(in1,in2))
           threshold = R(in1,in2);
       end
   end
end
threshold = threshold * 0.2;
disp('threshold = ');
disp(threshold);
%%
%testing thresholding
P = zeros(Row,Col);
for i = 1:Row
    for j = 1:Col
        if(R(i,j)>threshold)
            P(i,j) =1 ;
        end
    end
end
figure,imshow(P);
%%
%non-maximal suppression
O = zeros(Row,Col);
for i = 2:Row-1
    for j = 2:Col-1
        if(R(i,j)>threshold && R(i,j)>R(i,j+1) && R(i,j)>R(i+1,j+1) && R(i,j)>R(i+1,j) && R(i,j)>R(i+1,j-1) && R(i,j)>R(i,j-1) && R(i,j)>R(i-1,j-1) && R(i,j)>R(i-1,j) && R(i,j)>R(i-1,j+1))
        O(i,j) = 1;
        end
    end
end
figure,imshow(O);


