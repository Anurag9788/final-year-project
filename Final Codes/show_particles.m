function show_particles(X, Y_k, W, H)

global position ;
figure(1)
image(Y_k)
title('+++ Showing Particles +++')

hold on
plot(position(1), position(2), '-r*');
rectangle('Position',[position(1), position(2),W,H])
% plot(X(2,:), X(1,:), '.')
hold off

drawnow
