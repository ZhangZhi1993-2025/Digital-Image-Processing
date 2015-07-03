% =====================================================================
%                 LBG algorithm 
%     Start Date: 1995
%   Last Changed: 21/08/2006
%          Usage: Before runing the program, make sure training vector 
%                 (4096��16) file exist 
%  Specification: MATLAB 6.5 Programing
%                 The algorithm is taken from Sing-Tze Bow, 'Pattern Recognition'
%                 The program was firstly writen by Frank Dellaert in 1995-2001
%                 and changed by Ji and Liao on the stop condition
%  
%
% Copyright (c) Ji and Liao in 2006
% All rights Reserved
%==========================================================================

load lena_tv % download the training vectors file which return tv(n*d)
x=tv'; % d*n training vectors,16*4096
K=256; %number of clusters wanted
[d,n] = size(x);


%------------------------------------------------------------------------
% Initialize variables
%------------------------------------------------------------------------
oldmu = Inf*ones(d,K);%d*256
c = zeros(1,n); % 1*n calculated membership vector where c(j) \in 1..K
D = zeros(K,n);%256*n

%------------------------------------------------------------------------
% step 1: Arbitrarily choose K samples as the initial cluster centers
%------------------------------------------------------------------------
p=randperm(n);  % initial d*K  codevectors
mu = x(:,p(1:K));%���ѡȡK�飬��256��������Ϊ���������

tic%���ڼ���ȷ����������ʱ��
pp=1;%��ʼʧ������
iter=1; 
Dis(iter)=8000000;%��ʼƽ��ʧ��
while(pp>0.001),
   %------------------------------------------------------------------------
   % step 2: distribute the samples x to the chosen cluster domains
   %         based on which cluster center is nearest
   %------------------------------------------------------------------------
   iter=iter+1;
   for j=1:K,                        % for every cluster
      center = mu(:,j);              % get cluster centerȡ����j������
      if ~isequal(center,oldmu(:,j)) % has it moved ? �ж���ԭ�����Ƿ����
         D(j,:) = sqrDist(x,center); % calculate sqrDist from x to center
                                     % D:256*4096,������x�е�ÿ��������j�ľ���
      end
   end
   oldmu = mu;
   [Dmin,index] = min(D);%D:256*4096,min(D):Dmin��¼ÿ�е���Сֵ,index��¼��Сֵ���к�
   moved = sum(index~=c);%c:1*4096,
   c = index;%c�м�¼����ÿ����������������
   %------------------------------------------------------------------------
   % step 3: Update the cluster centers
   %------------------------------------------------------------------------
   for i=1:K
      ci=find(c==i);%ci��¼����������i�������������ڵ�����
      mu(:,i)=mean(x(:,ci),2);%x(:,ci)��ÿһ�еľ�ֵ����������������i�������ľ�ֵ��Ϊ�µ�����
   end
   Dis(iter)=sum(Dmin)/4096; % average distortionƽ��ʧ��
   pp=(Dis(iter-1)-Dis(iter))/Dis(iter-1); % used for stop condition
end % while
t=toc/60
Distortion=Dis(iter); % average distortion for the last iteration
PSNR_means = 10 * log10(255.^2*16 ./Dis) % calculate the PSNR
