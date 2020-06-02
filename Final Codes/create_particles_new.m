function X = create_particles_new(Npix_resolution, Npop_particles)

X1 = randi([Npix_resolution(3),Npix_resolution(4)], 1, Npop_particles);
X2 = randi([Npix_resolution(1),Npix_resolution(2)], 1, Npop_particles);
X3 = zeros(2, Npop_particles);

X = [X1; X2; X3];
