function HW3()
  controls = transpose([10000 10000; -10000 -10000; 10000 -10000; -10000 10000]);
  target = trilateration_model(controls, transpose([9500 500]));
  x = -20000:100:20000;
  y = -20000:100:20000;
  phi_grid = zeros(401, 401);
  for i = 1:401
    for j = 1:401
      phi_grid(i, j) = norm(trilateration_residual(controls, target , transpose([x(i) y(j)])))^2;
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
  [x, resNorm, residual, exitflag, output] = lsqnonlin(@(ell) trilateration_residual(transpose([10000 10000; -10000 -10000; 10000 -10000; -10000 10000]), target, transpose([ell(1) ell(2)])), transpose([-12000 -12000]), [], [], options)
  %{options = optimset('OutputFcn', @callback);
  %[ell_hat fval exitflag output] = fminsearch(@(ell)trilateration_objective(controls, target, transpose([ell(1)  ell(2)])), transpose([-12000 -12000]), options)

    end
 
 
function dist_vector = trilateration_model(controls , location)
controls
x = size(controls);
  dist_vector = zeros(x(2), 1);
  for  i = 1:x(2)
    i
    dist_vector(i) = sqrt((controls(1,i) - location(1))^2 + (controls(2,i) - location(2))^2);
  end
end
 
function [r, jacobian_ret] = trilateration_residual(controls,target_observations,location)
  if nargout > 1
    syms controls location target_observations
    jacobian_ret =  jacobian(trilateration_model(controls , location) - target_observations);
  end
  r = trilateration_model(controls , location) - target_observations;
 
end
 
function ret = trilateration_objective(control_points, target_observations, location)
  ret = norm(trilateration_residual(control_points, target_observations, location))^2;
end
 
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
