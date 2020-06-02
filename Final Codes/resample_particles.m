function val = resample_particles(X, L_log, Y, W, H)

% Calculating Cumulative Distribution
global position Xrgb_trgt;

L = exp(L_log - max(L_log));
% L = L_log;
[val, ind] = min(L) ;

position = [X(2,ind), X(1,ind)] ;

m = X(1,ind);
n = X(2,ind);
%temp_obj = rgb2gray(Y(m:m+H-1,n:n+W-1,:));
temp_obj = Y(m:m+H-1,n:n+W-1,:);
[a,b,c,d] = dwt2(temp_obj,'db1');
sz = round(1/3*size(a));
%sz = round(size(a));
Xrgb_trgt = [a(sz(1):2*sz(1),sz(2):2*sz(2)),b(sz(1):2*sz(1),sz(2):2*sz(2)),c(sz(1):2*sz(1),sz(2):2*sz(2)),d(sz(1):2*sz(1),sz(2):2*sz(2))];
