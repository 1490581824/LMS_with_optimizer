function [yn,err] = LMS_TEST(xn1,xn, W, M) 
% xn1      �����źţ���������ԭʼ�ź�  
% xn       �����ź�
% W        �˲���ʹ�õ�Ȩ��ϵ��    
% M        - �˲�������
%  
% yn       �˲�֮������ 


% ������ʱ�˲������������  
yn = inf * ones(size(xn1));  
for k = M:length(xn1)  
    x = xn1(k:-1:k-M+1);  
    yn(k) = (W')* x;
    err(k)=xn(k)-yn(k);
end 

end
