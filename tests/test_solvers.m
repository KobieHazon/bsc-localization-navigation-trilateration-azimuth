addpath(fullfile(fileparts(mfilename('fullpath')), '..', 'src'));
[range_location, range_residual] = HW3_part1(false);
[azimuth_location, azimuth_residual] = HW3_part2(false);
assert(norm(range_location - [9500; 500]) < 0.01);
assert(norm(azimuth_location - [9500; 500]) < 0.01);
assert(range_residual < 1e-8);
assert(azimuth_residual < 1e-8);
disp('PASS: both complete solver entry points converge to (9500, 500)');
