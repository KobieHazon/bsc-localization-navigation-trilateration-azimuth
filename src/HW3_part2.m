function HW3()
  controls = transpose([10000 10000; -10000 -10000; 10000 -10000; -10000 10000]);
  target = azimuth_model(controls, transpose([9500 500]));
  x = -20000:100:20000;
  y = -20000:100:20000;
  phi_grid = zeros(401, 401);
  for i = 1:401
    for j = 1:401
      phi_grid(i, j) = norm(azimuth_residual(controls, target , transpose([x(i) y(j)])))^2;
    end
  end
  
  figure
  contour(x, y, phi_grid, 25);
  daspect([1 1 1]);
  hold on;
  plot(controls(1, : ), controls(2, :), 'ro ');
  plot(target(1, :), target(2, :), 'rx ');
  hold off;
  options = optimoptions('lsqnonlin', 'SpecifyObjectiveGradient', false, 'Algorithm', 'levenberg-marquardt', 'OutputFcn', @callback);
  [x, resNorm, residual, exitflag, output] = lsqnonlin(@(ell) azimuth_residual(controls, target, transpose([ell(1) ell(2)])), transpose([1000 1000]), [], [], options)
%   %{options = optimset('OutputFcn', @callback);
%   %[ell_hat fval exitflag output] = fminsearch(@(ell)trilateration_objective(controls, target, transpose([ell(1)  ell(2)])), transpose([-12000 -12000]), options)
%   
%   
end
% 
% 
function stop = callback(current_ell, optimValues, state)
  stop = false;
  hold on;
  persistent prev;
  if strcmp(state, 'init')
    prev = current_ell;
  end
  line(prev, current_ell);
  prev = current_ell;
  drawnow;
end
 
function ret = azimuth_model(control_points, location)
x = size(control_points);
ret = zeros(x(2), 1);
for i = 1 : x(2)
    ret(i) = atan2(control_points(2, i) - location(2), control_points(1, i) - location(1));
end
end
 
function ret = azimuth_model2(control_points, location)
x = size(control_points);
ret = zeros(2*x(2), 1);
for i = 1 : x(2)
    ret(i) = (control_points(1, i) - location(1)) / norm(control_points(:, i) - location);
    ret(i + x(2)) = (control_points(2, i) - location(2)) / norm(control_points(:, i) - location);

end
end
 
function [r, jacobian_ret] = azimuth_residual(controls,target_observations,location)
  if nargout > 1
    syms controls location target_observations
    jacobian_ret =  jacobian(trilateration_model(controls , location) - target_observations);
  end
  r = azimuth_model(controls , location) - target_observations;
 
end

