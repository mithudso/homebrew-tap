"""Exercise generation in disposable repositories, including hostile paths."""

from pathlib import Path
import shutil
import subprocess
import sys
import tempfile
import unittest


class GenerationChecks(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name) / "repo"
        (self.root / "scripts").mkdir(parents=True)
        self.script = self.root / "scripts/generate-doc-indexes.py"
        shutil.copyfile(
            Path(__file__).resolve().parents[1] / "scripts/generate-doc-indexes.py",
            self.script,
        )
        subprocess.run(["git", "init", "-q", str(self.root)], check=True)

    def generate(self, *args):
        return subprocess.run(
            [sys.executable, str(self.script), *args], capture_output=True, text=True
        )

    def test_repeat_generation_and_drift_check(self):
        self.assertEqual(self.generate().returncode, 0)
        before = (self.root / "docs/codebase-overview.md").read_bytes()
        self.assertEqual(self.generate().returncode, 0)
        self.assertEqual((self.root / "docs/codebase-overview.md").read_bytes(), before)
        self.assertEqual(self.generate("--check").returncode, 0)
        (self.root / "added-file").touch()
        result = self.generate("--check")
        self.assertNotEqual(result.returncode, 0)
        self.assertIn("stale generated indexes", result.stderr)

    def test_output_symlink_cannot_overwrite_external_file(self):
        external = Path(self.temp.name) / "outside"
        external.write_text("preserve", encoding="utf-8")
        (self.root / "llms.txt").symlink_to(external)
        result = self.generate()
        self.assertNotEqual(result.returncode, 0)
        self.assertEqual(external.read_text(encoding="utf-8"), "preserve")

    def test_parent_symlink_cannot_write_outside_repository(self):
        external = Path(self.temp.name) / "outside-docs"
        external.mkdir()
        (self.root / "docs").symlink_to(external, target_is_directory=True)
        self.assertNotEqual(self.generate().returncode, 0)
        self.assertEqual(list(external.iterdir()), [])

    def test_filename_newlines_cannot_add_markdown_rows(self):
        (self.root / "entry`\n\n[injected](https:example.invalid)\n\n`tail|column").touch()
        self.assertEqual(self.generate().returncode, 0)
        overview = (self.root / "docs/codebase-overview.md").read_text(encoding="utf-8")
        self.assertNotIn("\n\n[injected]", overview)
        self.assertNotIn("tail|column", overview)


if __name__ == "__main__":
    unittest.main()
