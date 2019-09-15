%% SVM Preparation

clear
close all;
load('optimalcelldemo.mat','optimalcelldemo');


[theta1, g_st1, DualQuaternion1] = denoising(optimalcelldemo');

fileID1 = fopen('SVM_Train_Successful.txt', 'w'); %NC - changed to 'w' from 'a'
fileID2 = fopen('SVM_Train_Not_Converging.txt', 'w');
fileID3 = fopen('SVM_Train_Unsuccessful.txt', 'w');


[dq] = MatrixToDQuaternion( Temp(:,:,i) );
[ mindist,rot_met ] = distance_feature( dq,DualQuaternion1 );
fprintf(fileID1,'%f,%f\n', mindist,rot_met);



% fclose(fileID1);
% fclose(fileID2);
% fclose(fileID3);



