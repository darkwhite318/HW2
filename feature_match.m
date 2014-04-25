%describe the feature as its nine neibor's intensity
%set a threshold to first match the two images
%=========================================================================
%input:
%   I1,I2: origin images
%   list1,list2: candidate feature list of I1,I2
%output:
%   
%========================================================================
function O = feature_match(I1,list1,I2,list2)

Num1 = size(list1,2);%Num1: number of feature points in I1
Num2 = size(list2,2);%NUm2: number of feature points in I2
dis = ones(Num1,2);%the smallest distance between each feature point in I1 to I2
Img1 = 54/256*I1(:,:,1)+183/256*I1(:,:,2)+19/256*I1(:,:,3);
Img2 = 54/256*I2(:,:,1)+183/256*I2(:,:,2)+19/256*I2(:,:,3);


w = 8;%widow size = 2*2+1 = 5

initM2 = Img2(list2(1,1)-w:list2(1,1)+w,list2(2,1)-w:list2(2,1)+w);
for i = 1:Num1
    diM1 = Img1(list1(1,i)-w:list1(1,i)+w,list1(2,i)-w:list1(2,i)+w);
    dis(i,1) = sum(sum((double(diM1) - double(initM2)).^2));
    %dis(i,2) = 1;
    for j = 2:Num2        
        diM2 = Img2(list2(1,j)-w:list2(1,j)+w,list2(2,j)-w:list2(2,j)+w);
        p = double((double(diM1)-double(diM2)).^2);
        temp = sum(sum(p));
          if(temp < dis(i,1))
            dis(i,1) = temp;
            dis(i,2) = j;
          end
    end
end

% set theshold
fdis = zeros(1,2);%a list of good feature point of I1 and I2
%nu = 1;
[so turn] = sort(dis(:,1))
nu = 20;
for i = 1:nu
    fdis(i,1) = turn(i,1);%order of image I2
    fdis(i,2) = dis(turn(i,1),2);%order of image I1
end
%{
for i = 1:Num1
    if (dis(i,1) <threshold)
        fdis(nu,1) = i;
        fdis(nu,2) = dis(i,2);
        nu = nu + 1;
    end 
end
%}
%if(nu ==1)
%    disp('the threshold is too small!!');
%    O = 0;
%else
    
O = dis;
%show
Ic = size(I1(:,:,1),2);
num = size(fdis,1);
Icon = [I1,I2];%combine I1 and I2
figure,imshow(uint8(Icon));

hold on;
%plot all the original feature point candidates of I1 and I2
plot(list1(2,:),list1(1,:),'*','Color','b');
plot(list2(2,:)+Ic,list2(1,:),'*','Color','b');
for i = 1:num
    plot([list1(2,fdis(i,1)),list2(2,fdis(i,2))+Ic],[list1(1,fdis(i,1)),list2(1,fdis(i,2))],'LineWidth',1,'Color',[1,0,0]);
end
%end