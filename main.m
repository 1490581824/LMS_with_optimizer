clc;  
clear;
close all;  

%%
N1=1:500;
N2=501:1000;

x = [sin(2*pi*0.015*N1),0.5*sin(2*pi*0.015*N2)]; %1*N
x = x(:);  %size N*1
sx = size(x,1);  
  
subplot(3,2,1);  
plot(x);
title('ԭ�ź�/�����ź� d(n)');
xlabel('������N');
axis([0 sx -2 2]);  

  
% ��Ӹ�˹����   
noise = 0.2*randn(size(x));  % ��ֵΪ0������Ϊ0.5�ı�׼��̬����  
x1 = x + noise;  
subplot(3,2,2);  
plot(x1);
title('�����ź�x(n)');
xlabel('������N');
axis([0 sx -2 2]);  

  

% %����һ�����������������ź� lunge
noise = 0.2*randn(size(x));  % ��ֵΪ0������Ϊ0.5�ı�׼��̬����  
x2 = x + noise; 
% figure,  
% plot(x2)
  
%% LMS����Ӧ�˲�  
param.M        = 32;  
param.w        = ones(param.M, 1) * 0.1;  
param.u        = 0.002;  
param.max_iter = 100;  
param.min_err  = 0.01;
 


[W, err,err_mean] = LMS_TRAIN(x1, x, param);
[W_1, err_1,err_mean_1] = LMS_with_AdaGrad_TRAIN(x1, x, param);
[W_2, err_2,err_mean_2] = LMS_with_RMSProp_TRAIN(x1, x, param);
[W_3, err_3,err_mean_3] = LMS_with_adam_TRAIN(x1, x, param);

%%����
% x2Ϊ���Լ�
% x2 = x1;
[yn,err] = LMS_TEST(x1,x, W, param.M);
[yn_1,err_1] = LMS_TEST(x1,x, W_1, param.M);
[yn_2,err_2] = LMS_TEST(x1,x, W_2, param.M);
[yn_3,err_3] = LMS_TEST(x1,x, W_3, param.M);

%%���������źš������źź������㷨�˲�����ź�  
subplot(3,2,3);
plot(yn,'-');
title('LMS���y(n)');
xlabel('������N');
subplot(3,2,4);
plot(yn_1,'-')
title('AdaGrad���y(n)');
xlabel('������N');
subplot(3,2,5);
plot(yn_2,'-')
title('RMSProp���y(n)');
xlabel('������N');
subplot(3,2,6);
plot(yn_3,'-')
title('Adam���y(n)');
xlabel('������N');

%%����ѵ�������е�ƽ�����
figure
plot(err_mean,'-');
hold on
plot(err_mean_1,'.-');
plot(err_mean_2,'*-');
plot(err_mean_3,'--');
axis([0 param.max_iter 0 0.2]);
legend({'LMS','AdaGrad','RMSProp','Adam'});
xlabel('��������');
title('ѵ��ƽ��err');

%%����������� 
figure
subplot(2,2,1)
plot(abs(err),'-');
xlabel('������N');
axis([0 sx 0 0.2]);  
title('LMS�������err');
% hold on
subplot(2,2,2)
plot(abs(err_1),'-');
xlabel('������N');
axis([0 sx 0 0.2]);  
title('AdaGrad�������err');
subplot(2,2,3)
plot(abs(err_2),'-');
xlabel('������N');
axis([0 sx 0 0.2]);  
title('RMSProp�������err');
subplot(2,2,4)
plot(abs(err_3),'-');
xlabel('������N');
axis([0 sx 0 0.2]);  
title('Adam�������err');


 
