function L = calc_log_likelihood(Xstd_rgb, X, Y, W, H) %#codegen

global position pos_change Xrgb_trgt;
Npix_h = size(Y, 1);
Npix_w = size(Y, 2);

N = size(X,2);

L = zeros(1,N);

A = log(sqrt(2 * pi) * Xstd_rgb);
B = 0.5 / (Xstd_rgb.^2);

X = round(X);

for k = 1:N
    
    m = X(1,k);
    n = X(2,k);
    
    I = (m >= 1 & m+H <= Npix_h);
    J = (n >= 1 & n+W <= Npix_w);
    
    if I && J
        
        temp_obj = rgb2gray(Y(m:m+H-1,n:n+W-1,:));
%         figure; imshow(temp_obj) ;
        [a,b,c,d] = dwt2(temp_obj,'db1');
% %         C = a / max(max(a));
        sz = round(1/3*size(a));
        C = [a(sz(1):2*sz(1),sz(2):2*sz(2)),b(sz(1):2*sz(1),sz(2):2*sz(2)),c(sz(1):2*sz(1),sz(2):2*sz(2)),d(sz(1):2*sz(1),sz(2):2*sz(2))];
%         C = [a,b,c,d] ;
%         C = C / max(max(C));
%         C = temp_obj(sz(1):2*sz(1),sz(2):2*sz(2),:) ;
%         C = C/max(max(C)) ;
        
        D2 = sum(sum(sum(abs(C - Xrgb_trgt))));
        
%         D2 = D' * D;
%         if (D2 < 100)
            L(k) =  A + B * D2;
%         else
%             L(k) = -Inf;
%         end
%         L(k) = D2 ;
    else
        
        L(k) = Inf;
    end
end

% [L, ind] = sort(L, 'ascend') ;
% if (val < W*H/250)
%     success = 1 ;
% else
%     success = 0 ;
% end
    

% pos_change = new_position - position ;
%  position = new_position ;
% L(ind) = Inf ;
% [~,ind] = max(L) ;
% L(ind) = Inf;