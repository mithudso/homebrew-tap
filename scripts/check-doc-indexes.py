#!/usr/bin/env python3
"""Check the tap's local retrieval paths without network or index generation."""

from __future__ import annotations

import json
from pathlib import Path, PurePosixPath
import sys


def check(root: Path) -> int:
    """Return a nonzero status for malformed, duplicated or unsafe index entries."""
    index = root / "docs/high_signal_file_index.json"
    try:
        entries = json.loads(index.read_text(encoding="utf-8"))
    except (OSError, ValueError) as exc:
        print(f"index error: {exc}", file=sys.stderr)
        return 1
    if not isinstance(entries, list) or not entries:
        print("index error: expected a nonempty entry list", file=sys.stderr)
        return 1
    errors = []
    seen = set()
    for entry in entries:
        raw = entry.get("path") if isinstance(entry, dict) else None
        if not isinstance(raw, str) or not raw:
            errors.append("entry has no nonempty string path")
            continue
        path = PurePosixPath(raw)
        if path.is_absolute() or ".." in path.parts or str(path) != raw or "\\" in raw:
            errors.append(f"invalid relative path: {raw!r}")
            continue
        if raw in seen:
            errors.append(f"duplicate path: {raw}")
        seen.add(raw)
        try:
            target = (root / raw).resolve()
            if not target.is_relative_to(root.resolve()) or not target.is_file():
                errors.append(f"missing or escaping file: {raw}")
        except (OSError, ValueError, RuntimeError):
            errors.append(f"unresolvable file: {raw!r}")
    for error in errors:
        print(f"index error: {error}", file=sys.stderr)
    if errors:
        return 1
    print(f"index OK: {len(seen)} unique local files")
    return 0


if __name__ == "__main__":
    raise SystemExit(check(Path(__file__).resolve().parents[1]))
