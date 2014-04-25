%test only
function O = test(I1,I2)

[list1 o1] = HCDetector(I1,2);
[list2 o2] = HCDetector(I2,2);

O = feature_match(I1,list1,I2,list2);