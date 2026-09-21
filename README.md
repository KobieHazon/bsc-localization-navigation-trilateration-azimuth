# Localization and Navigation: Trilateration and Azimuth

My CS BSc localization and navigation homework project.

## Project Summary

This project contains two MATLAB implementations for estimating a target location from fixed control points:

- `src/HW3_part1.m` models range-based trilateration and visualizes the least-squares objective surface.
- `src/HW3_part2.m` models azimuth-based observations and visualizes the corresponding least-squares objective surface.

Both scripts use MATLAB optimization tooling around `lsqnonlin`, contour plots, and callback-based visualization of optimization progress.

## Materials

- `src/` contains the MATLAB source files.
- `report/HW3.pdf` is the submitted PDF report.

## Run

In MATLAB with Optimization Toolbox, add `src/` to the path and run `HW3_part1` or `HW3_part2`. Both return the estimated location and residual norm, and plot the objective and solver trajectory. Pass `false` to disable plotting.

GNU Octave with the `optim` package can run the same entry points. With Docker installed:

```sh
make test
```

The test executes both solvers and checks convergence to `(9500, 500)` with small residuals. The MATLAB-specific toolbox implementation is a separate runtime; the automated suite uses Octave. `make check` checks the repository's source and document structure.
