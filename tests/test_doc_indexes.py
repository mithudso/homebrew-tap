"""Behavioral tests for the offline path boundary used by CI."""

from contextlib import redirect_stderr, redirect_stdout
import importlib.util
import io
import json
from pathlib import Path
import tempfile
import unittest


SPEC = importlib.util.spec_from_file_location(
    "doc_indexes", Path(__file__).resolve().parents[1] / "scripts/check-doc-indexes.py"
)
CHECKER = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(CHECKER)


class IndexChecks(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name).resolve()
        (self.root / "docs").mkdir()
        (self.root / "README.md").write_text("fixture", encoding="utf-8")

    def run_check(self, entries):
        (self.root / "docs/high_signal_file_index.json").write_text(
            json.dumps(entries), encoding="utf-8"
        )
        output = io.StringIO()
        with redirect_stderr(output), redirect_stdout(output):
            result = CHECKER.check(self.root)
        return result, output.getvalue()

    def test_existing_file_passes_with_observable_count(self):
        self.assertEqual(
            self.run_check([{"path": "README.md"}]),
            (0, "index OK: 1 unique local files\n"),
        )

    def test_bad_entry_shapes_fail_with_diagnostics(self):
        for entries in ({}, [], [None], [{"path": 7}], [{"path": ""}]):
            with self.subTest(entries=entries):
                result, output = self.run_check(entries)
                self.assertEqual(result, 1)
                self.assertIn("index error:", output)

    def test_unsafe_paths_are_rejected(self):
        for path in ("../README.md", "/tmp/file", "./README.md", "docs/../README.md", "x\\y", "bad\0name"):
            with self.subTest(path=path):
                result, output = self.run_check([{"path": path}])
                self.assertEqual(result, 1)
                self.assertIn("index error:", output)

    def test_duplicate_and_missing_files_fail(self):
        result, output = self.run_check(
            [{"path": "README.md"}, {"path": "README.md"}, {"path": "absent"}]
        )
        self.assertEqual(result, 1)
        self.assertIn("duplicate path: README.md", output)
        self.assertIn("missing or escaping file: absent", output)

    def test_symlink_escape_fails(self):
        outside = tempfile.TemporaryDirectory()
        self.addCleanup(outside.cleanup)
        target = Path(outside.name) / "external-file"
        target.write_text("outside the repository", encoding="utf-8")
        (self.root / "escape").symlink_to(target)
        result, output = self.run_check([{"path": "escape"}])
        self.assertEqual(result, 1)
        self.assertIn("missing or escaping file: escape", output)

    def test_malformed_json_and_missing_index_fail(self):
        index = self.root / "docs/high_signal_file_index.json"
        for content in ("{", None):
            if content is not None:
                index.write_text(content, encoding="utf-8")
            else:
                index.unlink()
            output = io.StringIO()
            with redirect_stderr(output):
                self.assertEqual(CHECKER.check(self.root), 1)
            self.assertIn("index error:", output.getvalue())


if __name__ == "__main__":
    unittest.main()
