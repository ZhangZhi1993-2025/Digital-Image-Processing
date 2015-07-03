function D = dist1(x,t)%���ص���һά����x���ÿһ������ȥt���һά����
% dist1 : calculate a nt*nx vector containing distances between all points
%	  in x and all points in t. x and t must be row vectors !
%         Used in sqrDist
% D = dist1(x,t)
%	x,t	- row vectors
%	D	- the nt*nx result

% Copyright (c) 1995-2001 Frank Dellaert
% All rights Reserved

global dist1_warning
if isempty(dist1_warning)
   warning('dist1: please compile mex-version by typing "mex dist1.c" in "clusters" directory');
   dist1_warning=1;
end

[dx,nx] = size(x);%x:1*4096
[dt,nt] = size(t);%t��1*1
if (dx~=1 || dt~=1), error('dist1 only takes row vectors'); end

% totally vectorized (but memory hungry)
D = x(ones(1,nt),:) - t(ones(1,nx),:)';%D:4096*1


