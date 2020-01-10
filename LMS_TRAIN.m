function [W, err,err_mean] = LMS_TRAIN(xn, dn, param)  
% xn       �����źţ���������ԭʼ�ź�  
% dn       �������  
% param    Structure for using LMS, must include at least  
%          .w        - ��ʼ��Ȩֵ  
%          .u        - ѧϰ��  
%          .M        - �˲�������  
%          .max_iter - ����������  
%  
% W        ���Ȩ��
% error    ������  

W = param.w;  % ��ʼȨֵ  
M = param.M;  % �˲�������  
  
if length(W) ~= M  
    error('param.w�ĳ��ȱ������˲���������ͬ.\n');  
end  



iter = 1;
N=length(xn)
for i = 1:param.max_iter
    for k = M:N
        x    = xn(k:-1:k-M+1);   % �˲���M����ͷ������  
        y    = (W')*x;  
        err(iter)  = dn(k) - y;  
          
        % �����˲���Ȩֵϵ��  
        W = W + param.u*(err(iter))*x;  
        iter = iter + 1;
    end  
    err_mean(i)=mean(abs(err(iter-1-(N-M):iter-1))); 


end
mean(abs(err))
end

