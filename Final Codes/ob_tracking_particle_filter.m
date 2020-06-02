%% Parameters

clc ;
close all;
clear all;

global position pos_change Xrgb_trgt;

F_update = [1 0 1 0; 0 1 0 1; 0 0 1 0; 0 0 0 1];

Npop_particles = 1000;

Xstd_rgb = 50;
Xstd_pos = 25;
Xstd_vec = 5;


%% Loading Movie
[f,p] = uigetfile('*.*');
vr = VideoReader([p,f]);
% vr = VideoReader('MPII_1.avi');

Npix_resolution = [vr.Width vr.Height];
Nfrm_movie = floor(vr.Duration * vr.FrameRate);

frame1 = read(vr, 1);
figure, imshow(frame1);
k = waitforbuttonpress;
point1 = get(gca,'CurrentPoint');    % button down detected
finalRect = rbbox;                   % return figure units
point2 = get(gca,'CurrentPoint');    % button up detected
point1 = point1(1,1:2);              % extract x and y
point2 = point2(1,1:2);
p1 = min(point1,point2);             % calculate locations
offset = round(abs(point1-point2));         % and dimensions
x0=p1(1);
y0=p1(2);
W=offset(1);
H=offset(2);

object = frame1(y0:y0+H-1,x0:x0+W-1,:);
[a,b,c,d] = dwt2(object,'db1') ;
sz = round(1/3*size(a));
Xrgb_trgt = [a(sz(1):2*sz(1),sz(2):2*sz(2)),b(sz(1):2*sz(1),sz(2):2*sz(2)),c(sz(1):2*sz(1),sz(2):2*sz(2)),d(sz(1):2*sz(1),sz(2):2*sz(2))];
%% Object Tracking by Particle Filter

position = [x0,y0];
pos_change = [0,0];
for k = 1:Nfrm_movie
    
    % Getting Image
    Y_k = read(vr, k);
    
    X = create_particles_new([position(1)-round(W/4),position(1)+round(W/4),position(2)-round(H/4),position(2)+round(H/4)], round(W*H/4));    
        
    % Calculating Log Likelihood
    L = calc_log_likelihood(Xstd_rgb, X(1:2, :), Y_k, W, H);
    
    % Resampling
    val = resample_particles(X, L, Y_k, W, H);

    % Showing Image
    show_particles(X, Y_k, W, H); 
%    show_state_estimated(X, Y_k);

end

