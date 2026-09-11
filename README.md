# Localization and Navigation: Trilateration and Azimuth

My CS BSc localization and navigation homework project.

## Project Summary

This project contains two MATLAB implementations for estimating a target location from fixed control points:

- `src/HW3_part1.m` models range-based trilateration and visualizes the least-squares objective surface.
- `src/HW3_part2.m` models azimuth-based observations and visualizes the corresponding least-squares objective surface.

Both scripts use MATLAB optimization tooling around `lsqnonlin`, contour plots, and callback-based visualization of optimization progress.

## Recovered Materials

- `assignment/MISSING_HANDOUT.md` records that the original exercise handout was not recovered.
- `src/` contains the recovered submitted MATLAB source files.
- `report/HW3.pdf` is the recovered submitted PDF report.

## Requirements

The source was written for MATLAB with Optimization Toolbox support. A purpose-built GNU Octave 11.1.0 environment with `optim` 1.6.3 parsed both submitted files, and an external compatibility harness using the submitted range and azimuth formulas recovered the expected point `(9500, 500)` with negligible residuals. Exact MATLAB `optimoptions`, callback, plotting, and entrypoint behavior was not reproduced.

## Validate

Run:

```sh
make check
```

The check confirms the expected MATLAB files, important solver markers, and basic privacy hygiene. The recorded container validation separately covers formula-level execution.
