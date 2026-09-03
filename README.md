# Localization and Navigation: Trilateration and Azimuth

My CS BSc localization/navigation homework project.

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

The source was written for MATLAB with Optimization Toolbox support. A local MATLAB or Octave runtime was not available during validation, so validation is static only.

## Validate

Run:

```sh
make check
```

The check confirms the expected MATLAB files, important solver markers, and basic privacy hygiene.
