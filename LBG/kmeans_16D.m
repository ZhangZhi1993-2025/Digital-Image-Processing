% =====================================================================
%                 LBG algorithm 
%     Start Date: 1995
%   Last Changed: 21/08/2006
%          Usage: Before runing the program, make sure training vector 
%                 (4096×16) file exist 
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
mu = x(:,p(1:K));%随机选取K组，即256组向量作为最初的码书

tic%用于计算确定码书所用时间
pp=1;%初始失控门限
iter=1; 
Dis(iter)=8000000;%初始平均失真
while(pp>0.001),
   %------------------------------------------------------------------------
   % step 2: distribute the samples x to the chosen cluster domains
   %         based on which cluster center is nearest
   %------------------------------------------------------------------------
   iter=iter+1;
   for j=1:K,                        % for every cluster
      center = mu(:,j);              % get cluster center取出第j个码字
      if ~isequal(center,oldmu(:,j)) % has it moved ? 判断与原码字是否相等
         D(j,:) = sqrDist(x,center); % calculate sqrDist from x to center
                                     % D:256*4096,计算了x中的每个向量到j的距离
      end
   end
   oldmu = mu;
   [Dmin,index] = min(D);%D:256*4096,min(D):Dmin记录每列的最小值,index记录最小值的行号
   moved = sum(index~=c);%c:1*4096,
   c = index;%c中记录的是每个向量归属的码字
   %------------------------------------------------------------------------
   % step 3: Update the cluster centers
   %------------------------------------------------------------------------
   for i=1:K
      ci=find(c==i);%ci记录了属于码字i的所有向量所在的列数
      mu(:,i)=mean(x(:,ci),2);%x(:,ci)的每一行的均值，即所有属于码字i的向量的均值作为新的码字
   end
   Dis(iter)=sum(Dmin)/4096; % average distortion平均失真
   pp=(Dis(iter-1)-Dis(iter))/Dis(iter-1); % used for stop condition
end % while
t=toc/60
Distortion=Dis(iter); % average distortion for the last iteration
PSNR_means = 10 * log10(255.^2*16 ./Dis) % calculate the PSNR
