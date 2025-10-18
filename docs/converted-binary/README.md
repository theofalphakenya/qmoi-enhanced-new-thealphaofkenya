This directory contains binary backups extracted during repository sanitization.
These files can be large. We intentionally keep local copies here for recovery and inspection,
but they are not committed to the repository history to avoid bloating the git repo.

A generated MANIFEST.txt (same directory) lists the files and their sizes (bytes).

Next steps for the repo owner:
- Run the history rewrite instructions in REWRITE_HISTORY_INSTRUCTIONS.md to remove large historic blobs from git history.
- Move any required binary artifacts to an external object store (S3, GCS, or an artifacts server) and reference them from docs or config.

Do NOT remove this README unless you know what you're doing.
