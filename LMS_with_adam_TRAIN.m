function [W, err,err_mean] = LMS_with_adam_TRAIN(xn, dn, param)  
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
epsilon = 10^-8;
p1=0;
p2=0.999;
  
if length(W) ~= M  
    error('param.w�ĳ��ȱ������˲���������ͬ.\n');  
end  



iter = 1;
N=length(xn)
r=0;
s=0;
t=0;
for i = 1:param.max_iter
    for k = M:N
        x    = xn(k:-1:k-M+1);   % �˲���M����ͷ������  
        y    = (W')*x;  
        err(iter)  = dn(k) - y;  
        grad=(err(iter))*x;
        t=t+1;
        s=p1*s+(1-p1)*grad;
        r=p2*r+(1-p2)*grad'*grad;
 
        %ԭ�����㷨�����������й�һ������ʵ��Ч������
        %s=s/(1-p1^t);
        %r=r/(1-p2^t);
        
        % �����˲���Ȩֵϵ��  
        W = W + param.u*s/(epsilon+sqrt(r));  
        iter = iter + 1;

          
    end  
    err_mean(i)=mean(abs(err(iter-1-(N-M):iter-1))); 

end
mean(abs(err))
end

