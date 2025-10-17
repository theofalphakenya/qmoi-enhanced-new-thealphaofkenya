## Secure secret provisioning and demo push

This repository includes a minimal secret manager and helper scripts to securely
store encrypted tokens in `.qmoi/` and decrypt them at runtime.

Quick steps to bootstrap locally (do not paste secrets in chat):

1. Generate master key and persist locally (only for local demo):

```bash
python - <<'PY'
from cryptography.fernet import Fernet
print(Fernet.generate_key().decode())
PY

export QMOI_MASTER_KEY="<paste-the-key-here>"
python qmoi-enhanced/qmoi-enhanced/scripts/qmoi_bootstrap_secrets.py --github-token "$GITHUB_TOKEN" --create-git-helper --confirm-write
```

2. Push securely using the askpass helper (example):

```bash
export QMOI_GITHUB_TOKEN="ghp_..."
export GIT_ASKPASS="$(pwd)/.qmoi/git-credential-env-helper.sh"
git push private main
unset QMOI_GITHUB_TOKEN GIT_ASKPASS
```

CI notes
- Add `QMOI_MASTER_KEY` and `QMOI_GITHUB_TOKEN` as repository secrets in GitHub
  (Settings → Secrets → Actions). Use the same names if you want the supplied
  workflow to work out of the box.
