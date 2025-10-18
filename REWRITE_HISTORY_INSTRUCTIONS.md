# Safe history rewrite instructions (remove large tracked blobs)

This repository contains large tracked artifacts in history that prevent pushes and cause problems for CI. Rewriting history to remove those blobs is a destructive operation and must be run locally by the repository owner. Follow the checklist and steps below.

IMPORTANT: This rewrites git history. All contributors who push/pull must coordinate. Make a full clone/backup before running.

Checklist (before you start)
- Make a local copy of the repository (git clone --mirror <repo> backup-repo.git) or ensure you have an up-to-date clone.
- Export a list of large objects to review first: `git rev-list --objects --all | git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' | sort -k3 -n -r | head -n 50`.
- Decide which paths to permanently remove (example: `large-backup.zip`, `node_modules/packed.tar.gz`).

Preferred tool: git-filter-repo (faster, safer, actively maintained)

1) Install git-filter-repo (if not installed):

   - On Ubuntu/Debian: `sudo apt install git-filter-repo` (or `pip install git-filter-repo`).
   - On macOS: `brew install git-filter-repo`.

2) Create a fresh mirror clone as a safety buffer (in a separate directory):

   git clone --mirror <origin-url> repo-mirror.git
   cd repo-mirror.git

3) Run git-filter-repo to remove paths or file patterns. Example (remove named files/paths):

   git filter-repo --invert-paths --paths-from-file ../paths-to-remove.txt

   Create `paths-to-remove.txt` in the parent directory and list the paths (one per line) to remove completely from history.

   You can also remove by size, but removing by path is more deterministic.

4) Double-check the results locally. Inspect the mirror's refs and history. When ready, push to the remote with --force:

   git push --force --all
   git push --force --tags

5) After a successful push: Inform all contributors to reclone the repository, or to follow these commands locally to realign their remotes:

   git fetch origin --prune
   git checkout --detach
   git branch -D <branch-name>
   git checkout -b <branch-name> origin/<branch-name>

Fallback (BFG) instructions
- If you cannot use git-filter-repo, BFG is an alternative (https://rtyley.github.io/bfg-repo-cleaner/). Use BFG with a mirror clone similarly.

Add/update .gitignore
- After removing large artifacts from history, add them to `.gitignore` to prevent re-adding them.

Testing safety
- Before pushing, you can run `git rev-list --objects --all | git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' | sort -k3 -n -r | head` to confirm large objects are gone.

If you want, run the helper script `tools/clean_repo.sh` (provided) from a separate clone and follow the prompts.

If you want me to prepare `paths-to-remove.txt` from candidates I found earlier, tell me which paths you want removed and I will prepare that file for you to run with `git-filter-repo` locally.
