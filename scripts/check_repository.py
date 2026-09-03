#!/usr/bin/env python3
from pathlib import Path
import sys

ROOT = Path(__file__).resolve().parents[1]

required_files = [
    ROOT / "src" / "HW3_part1.m",
    ROOT / "src" / "HW3_part2.m",
    ROOT / "report" / "HW3.pdf",
    ROOT / "assignment" / "MISSING_HANDOUT.md",
]
missing = [str(path.relative_to(ROOT)) for path in required_files if not path.exists()]
if missing:
    print("Missing required files: " + ", ".join(missing), file=sys.stderr)
    sys.exit(1)

source_files = [ROOT / "src" / "HW3_part1.m", ROOT / "src" / "HW3_part2.m"]
text = "\n".join(path.read_text(encoding="utf-8").replace("\r\n", "\n") for path in source_files)
required_markers = [
    "trilateration_model",
    "trilateration_residual",
    "azimuth_model",
    "azimuth_residual",
    "lsqnonlin",
    "callback",
]
missing_markers = [marker for marker in required_markers if marker not in text]
if missing_markers:
    print("Missing expected MATLAB markers: " + ", ".join(missing_markers), file=sys.stderr)
    sys.exit(1)

student_id = "".join(["208", "234", "161"])
local_path_marker = "/" + "Users" + "/"
scan_roots = [
    ROOT / "README.md",
    ROOT / "assignment" / "MISSING_HANDOUT.md",
    *source_files,
]
for path in scan_roots:
    content = path.read_text(encoding="utf-8", errors="ignore")
    if student_id in content or local_path_marker in content:
        print(f"Privacy marker found in {path.relative_to(ROOT)}", file=sys.stderr)
        sys.exit(1)

print("Repository static checks passed.")
