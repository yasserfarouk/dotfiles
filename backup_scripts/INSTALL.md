# Quick Installation Guide

## Step 1: Prerequisites

```bash
# Install required tools (macOS)
brew install git gh coreutils

# Authenticate with GitHub
gh auth login
# Choose: GitHub.com → SSH → Follow prompts

# Setup SSH keys if not already done
ssh-keygen -t ed25519 -C "your_email@example.com"
ssh-add ~/.ssh/id_ed25519
cat ~/.ssh/id_ed25519.pub
# Add public key to: https://github.com/settings/keys

# Test connection
ssh -T git@github.com
```

## Step 2: Configure Scripts

```bash
cd ~/code/personal/dotfiles/backup_scripts

# Edit your GitHub usernames
nano update_git_repos.sh
# Find line ~50: MY_GITHUB_ACCOUNTS=("your-username" "your-org")
```

## Step 3: First Run

```bash
# Make scripts executable (if not already)
chmod +x *.sh

# Run full backup
./backup.sh
```

## Step 4: Optional - Setup Automated Daily Backup

```bash
# Edit crontab
crontab -e

# Add this line (runs at 2 AM daily):
0 2 * * * cd ~/code/personal/dotfiles/backup_scripts && ./backup.sh >> ~/backup.log 2>&1
```

## Step 5: Add Scripts to PATH (Optional)

```bash
# Add to your ~/.zshrc or ~/.bashrc
echo 'export PATH="$HOME/code/personal/dotfiles/backup_scripts:$PATH"' >> ~/.zshrc
source ~/.zshrc

# Now you can run from anywhere:
backup.sh
update_git_repos.sh
add_to_ignore.sh <path>
```

---

## Troubleshooting Installation

### "gh: command not found"
```bash
brew install gh
```

### "timeout: command not found"
```bash
brew install coreutils
```

### "Permission denied (publickey)"
```bash
# Generate and add SSH key
ssh-keygen -t ed25519 -C "your@email.com"
ssh-add ~/.ssh/id_ed25519
cat ~/.ssh/id_ed25519.pub
# Copy output and add to: https://github.com/settings/keys
```

### Scripts not executable
```bash
cd ~/code/personal/dotfiles/backup_scripts
chmod +x *.sh
```

---

## Verification

After installation, verify everything works:

```bash
# Check all tools installed
git --version
gh --version
timeout --version

# Check SSH connection
ssh -T git@github.com
# Should see: "Hi username! You've successfully authenticated..."

# Run test
cd ~/code/personal/dotfiles/backup_scripts
./update_git_repos.sh
# Should scan repos and show report
```

---

## What Gets Backed Up

### Git Repositories
- All repos under `~/code` are pushed to GitHub
- External repos get backup copies
- Diverged repos get fork copies

### Files
- Scripts → `~/Documents/MacBackup/git_management_scripts/`
- Folders → `~/Documents/MacBackup/`

### Folders Synced to iCloud
- `.ssh`, `.config`, `.copilot`, `bin`
- `Desktop`, `Downloads`
- `code`, `koshodojo`, `negmas`, `.secrets`

---

## Next Steps

1. **Review the backup report** after first run
2. **Add repos to ignore list** if needed:
   ```bash
   ./add_to_ignore.sh learning
   ```
3. **Test restore script** (optional):
   ```bash
   ./generate_restore_script.sh
   cat ~/restore_git_repos.sh
   ```
4. **Setup automation** with cron job
5. **Read the full README.md** for advanced usage

---

## Quick Reference

```bash
# Full backup
./backup.sh

# Just git operations
./update_git_repos.sh

# Add to ignore list
./add_to_ignore.sh <path>

# Generate restore scripts
./generate_restore_script.sh
```
