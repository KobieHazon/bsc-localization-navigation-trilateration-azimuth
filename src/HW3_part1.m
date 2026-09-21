function [estimate, resNorm] = HW3_part1(show_plot)
  % Estimate the target from four range/azimuth observations.
  if nargin < 1
    show_plot = true;
  end
  controls = [10000 10000; -10000 -10000; 10000 -10000; -10000 10000].';
  target_location = [9500; 500];
  observations = observation_model(controls, target_location);
  residual = @(location) observation_model(controls, location) - observations;
  if show_plot
    coordinates = -20000:100:20000;
    objective = zeros(length(coordinates));
    for row = 1:length(coordinates)
      for column = 1:length(coordinates)
        objective(row, column) = norm(residual([coordinates(column); coordinates(row)]))^2;
      end
    end
    figure;
    contour(coordinates, coordinates, objective, 25);
    daspect([1 1 1]);
    hold on;
    plot(controls(1,:), controls(2,:), 'ro');
    plot(target_location(1), target_location(2), 'rx');
  end
  if exist('OCTAVE_VERSION', 'builtin')
    pkg('load', 'optim');
    options = optimset('Jacobian', 'off', 'TolFun', 1e-12);
  else
    options = optimoptions('lsqnonlin', 'SpecifyObjectiveGradient', false, ...
      'Algorithm', 'levenberg-marquardt', 'FunctionTolerance', 1e-12);
  end
  if show_plot
    options.OutputFcn = @callback;
  end
  [estimate, resNorm] = lsqnonlin(residual, [-12000; -12000], [], [], options);
end

function observations = observation_model(controls, location)
  observations = sqrt(sum((controls - location).^2, 1)).';
end

function stop = callback(current_location, optimValues, state)
  stop = false;
  persistent previous;
  if strcmp(state, 'init')
    previous = current_location;
  end
  line([previous(1), current_location(1)], [previous(2), current_location(2)]);
  previous = current_location;
  drawnow;
end
