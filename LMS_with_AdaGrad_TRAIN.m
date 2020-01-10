function [W, err,err_mean] = LMS_with_AdaGrad_TRAIN(xn, dn, param)  
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
epsilon = 10^-7;
  
if length(W) ~= M  
    error('param.w�ĳ��ȱ������˲���������ͬ.\n');  
end  



iter = 1;
N=length(xn)
r=0;

for i = 1:param.max_iter
    for k = M:N
        x    = xn(k:-1:k-M+1);   % �˲���M����ͷ������  
        y    = (W')*x;  
        err(iter)  = dn(k) - y;  
        grad=(err(iter))*x;
        %r=r+grad'*grad;  %����ԭ�����㷨���ã�Ч������
        r=0.95*r+grad'*grad;
        % �����˲���Ȩֵϵ��  
        W = W + param.u/(epsilon+sqrt(r))*grad;  
        iter = iter + 1;

          
    end  
    err_mean(i)=mean(abs(err(iter-1-(N-M):iter-1))); 

end
mean(abs(err))
end

