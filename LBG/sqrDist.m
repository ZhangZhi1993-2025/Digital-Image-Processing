function D = sqrDist(x,t,w)%返回的是距离的平方
% SQRDIST : calculate a nt*nx matrix containing weighted squared error between
%           every vector in x and every vector in t
% D = sqrDist(x,t,w)
%	x - d*nx matrix containing the x vectors 
%	t - d*nt matrix containing the t vectors
%	w - if specified, a length d weight vector
%	D - the nt*nx result
%
% useful facts:
%  sqrDist(X,M,v.^-0.5) = sqrMahalanobis(X,z,diag(v))
%  sqrDist(X,M,s.^-1)   = sqrMahalanobis(X,z,diag(s.^2))
%  sqrDist(X,M,w)       = sqrMahalanobis(X,z,diag(w.^2))

% Copyright (c) 1995 Frank Dellaert
% All rights Reserved

global sqrDist_warning
if isempty(sqrDist_warning)
   warning('sqrDist: please compile mex-version by typing "mex sqrDist.c" in "clusters" directory');
   sqrDist_warning=1;
end

[d ,nx] = size(x);%x:16*4096,原始数据
[dt,nt] = size(t);%t:16*1,码字
%维数不一致报错
if (dt~=d), error('sqrDist: x and t must have same dimension'); end
if (nargin<3), w=[]; end

D = zeros(nt,nx);%D:1*4096，记录各向量到t的距离

for l=1:d%l:1-16
   D2 = dist1(x(l,:),t(l,:)).^2; % distance for 1 dimension, unweighted
                                 % D2:1*4096
   if isempty(w)
      D  = D + D2;               % sum to get unweighted distance
   else
      D  = D + (w(l)^2)*D2;      % sum to get weighted distance
   end
end


