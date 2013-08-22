function N = getImp(x, L, gen, mode, varargin)
%
% TODO DOC
%

% transform the data
Lx = L*x;
% get the number of data examples
n = size(x,2);
% ensure that gen's second dimension is a multiple of n
assert(mod( size(gen,2), n ) == 0)
% get the number of target neighbours used
k = size(gen,2)/n;
% compute square distances to target neighbours plus margin
Ni = zeros(k,n);
for i = 1:k
    Ni(i,:) = sum( (Lx - Lx(:, gen(1, (i-1)*n+1:i*n) )).^2 ) +1;
end

if strcmp(mode, 'exact')
    
    fprintf('>>>>> getImp: exact mode selected\n')
    % ensure that the correct number of arguments is given
    assert(length(varargin) == 1)
    % extract arguments
    y = varargin{1};
    
    N = getExactImp(Lx,Ni,y,gen,k);
    
elseif strcmp(mode, 'approx')

% % %     fprintf('>>>>> getImp: approx mode selected\n')
    % ensure that the correct number of arguments is given
    assert(length(varargin) == 1)
    % extract arguments
    Ncex = varargin{1};
    
    N = getApproxImp(Lx,Ni,Ncex);

else
    error('%s mode not available, use either exact or approx', mode)
end

