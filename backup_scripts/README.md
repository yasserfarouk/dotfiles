# Git Repository Backup & Management Scripts

A comprehensive suite of bash scripts for automated git repository backup, management, and restoration. Designed for developers with multiple repositories who want automated, reliable backups with zero manual intervention.

## 📋 Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Prerequisites](#prerequisites)
- [Quick Start](#quick-start)
- [Scripts](#scripts)
- [Configuration](#configuration)
- [Usage Examples](#usage-examples)
- [Troubleshooting](#troubleshooting)
- [Safety Features](#safety-features)

---

## 🎯 Overview

This backup system provides:
- **Automated git repository management** - commits, pushes, and migrates repos
- **Cross-platform restoration** - generates scripts for Linux/macOS/Windows
- **iCloud integration** - backs up scripts and folders to iCloud
- **Unattended operation** - never prompts for input, perfect for cron jobs
- **Comprehensive reporting** - detailed logs of all operations

---

## ✨ Features

### Repository Management
- ✅ Auto-commits uncommitted changes with WIP message
- ✅ Converts all HTTPS URLs to SSH automatically
- ✅ Migrates Bitbucket/GitLab repos to GitHub
- ✅ Creates GitHub repos for local-only repositories
- ✅ Pushes to owned repositories only
- ✅ Creates backup repos for external/forked repos
- ✅ Handles diverged history gracefully
- ✅ Rate limiting (max 50 GitHub repos per run)
- ✅ SSH-only (no HTTPS, no credential prompts)

### Safety & Reliability
- ✅ Fully unattended operation (never hangs)
- ✅ Timeout protection (30s per push operation)
- ✅ Ownership checking (won't push to external repos)
- ✅ Comprehensive error handling
- ✅ Detailed reporting with statistics
- ✅ Ignore list support
- ✅ No destructive operations

### Backup & Restore
- ✅ Cross-platform restoration scripts (Linux/macOS/Windows)
- ✅ Preserves directory structure
- ✅ Captures both origin and backup remotes
- ✅ iCloud integration for cloud backup
- ✅ Folder syncing with rsync

---

## 📦 Prerequisites

### Required Tools
```bash
# macOS (using Homebrew)
brew install git gh coreutils

# Ubuntu/Debian
sudo apt-get install git gh coreutils

# Check if installed
git --version
gh --version
timeout --version
```

### GitHub CLI Setup
```bash
# Authenticate with GitHub
gh auth login

# Follow prompts:
# 1. Choose GitHub.com
# 2. Choose SSH
# 3. Follow authentication flow
```

### SSH Keys Setup
```bash
# Generate SSH key if you don't have one
ssh-keygen -t ed25519 -C "your_email@example.com"

# Add to ssh-agent
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

# Add public key to GitHub
# Copy your public key:
cat ~/.ssh/id_ed25519.pub
# Then add it at: https://github.com/settings/keys

# Test connection
ssh -T git@github.com
# Should see: "Hi username! You've successfully authenticated..."
```

---

## 🚀 Quick Start

### 1. Clone or Copy Scripts
```bash
# If cloning this repo
git clone <repo-url> ~/code/personal/dotfiles
cd ~/code/personal/dotfiles/backup_scripts

# Or copy scripts to a directory
mkdir -p ~/scripts
cp *.sh ~/scripts/
cd ~/scripts
```

### 2. Configure Your GitHub Accounts
Edit `update_git_repos.sh` and update your GitHub usernames:
```bash
# Line ~40-41
MY_GITHUB_ACCOUNTS=("your-username" "your-org" "another-account")
```

### 3. Run Initial Backup
```bash
# Make sure all scripts are executable
chmod +x *.sh

# Run the full backup
./backup.sh
```

That's it! The script will:
1. Scan all repos under `~/code`
2. Commit and push everything
3. Generate restore scripts
4. Back up to iCloud

---

## 📜 Scripts

### 1. `restore.sh` / `restore.ps1` - Complete System Restoration ⭐ NEW

**Platform:** `restore.sh` for macOS/Linux, `restore.ps1` for Windows

The master restoration script that brings your entire system back from backup.

**What it does:**
1. Restores SSH keys first (needed for git authentication)
2. Restores all configuration folders
3. Installs required tools (Homebrew/winget, git, gh)
4. Restores all git repositories using generated restore script
5. Restores non-git code folders
6. Installs all packages from Brewfile (macOS) or winget (Windows)

**Usage:**

*macOS/Linux:*
```bash
./restore.sh ~/Documents/MacBackup
```

*Windows PowerShell (as Administrator):*
```powershell
.\restore.ps1 -BackupPath "D:\MacBackup"
```

**What gets restored:**
- SSH keys (~/.ssh)
- Config folders (.config, .copilot, bin, etc.)
- All git repositories
- Non-git code folders
- Desktop, Downloads
- All Homebrew packages (macOS) or common dev tools (Windows)

**Features:**
- ✅ Progress tracking with colored output
- ✅ Detailed logging to file
- ✅ Safety confirmations
- ✅ Backs up existing files before overwriting
- ✅ Post-restoration checklist
- ✅ Time tracking

**Requirements:**
- rsync (macOS/Linux)
- robocopy (Windows)
- Internet connection for package installation

---

### 2. `update_git_repos.sh` - Main Repository Manager

The core script that handles all git operations.

**What it does:**
- Scans `~/code` recursively for git repositories
- Auto-commits uncommitted changes
- Converts HTTPS to SSH
- Migrates Bitbucket/GitLab to GitHub
- Pushes to owned repos
- Creates backups for external repos
- Handles diverged history

**Usage:**
```bash
./update_git_repos.sh
```

**Configuration:**
- Edit `MY_GITHUB_ACCOUNTS` array (line ~40)
- Edit `CODE_DIR` if your code is elsewhere (line ~104)
- Edit rate limits if needed (lines 37-38)

**Output:**
- Colored terminal output with progress
- Comprehensive reports at the end
- Statistics and recommendations

---

### 3. `generate_restore_script.sh` - Restoration Script Generator

Generates scripts to restore all repositories on a new machine.

**What it does:**
- Scans all repos with remotes
- Generates `restore_git_repos.sh` (Linux/macOS)
- Generates `restore_git_repos.bat` (Windows)
- Captures both origin and backup remotes
- Preserves directory structure and branch info

**Usage:**
```bash
./generate_restore_script.sh
```

**Output files:**
- `~/restore_git_repos.sh` - For Linux/macOS
- `~/restore_git_repos.bat` - For Windows

**To restore on a new machine:**

*Linux/macOS:*
```bash
chmod +x restore_git_repos.sh
./restore_git_repos.sh
```

*Windows:*
```cmd
restore_git_repos.bat
```

---

### 4. `backup.sh` - Master Orchestration Script

Runs the complete backup workflow.

**What it does:**
1. Runs `update_git_repos.sh` (commits & pushes)
2. Runs `generate_restore_script.sh` (creates restore scripts)
3. Backs up all scripts to iCloud
4. Syncs folders to iCloud with rsync

**Usage:**
```bash
./backup.sh
```

**What gets backed up:**
- All git repositories → GitHub
- Scripts → `~/Documents/MacBackup/git_management_scripts/`
- Folders → `~/Documents/MacBackup/`
  - `.ssh`, `.config`, `.copilot`, `bin`
  - `Desktop`, `Downloads`, `code`
  - `koshodojo`, `negmas`, `.secrets`

**Configuration:**
Edit the `FOLDERS_TO_SYNC` array (line ~21) to customize

**Output:**
Shows elapsed time at the end (HH:MM:SS format)

---

### 5. `add_to_ignore.sh` - Ignore List Manager

Helper to add repositories to the ignore list.

**What it does:**
- Adds repos to `~/.git_repos_ignore`
- Converts absolute paths to relative
- Shows current ignore list

**Usage:**
```bash
./add_to_ignore.sh <repo_path>
```

**Examples:**
```bash
# Add by relative path
./add_to_ignore.sh learning

# Add by absolute path
./add_to_ignore.sh /Users/yasser/code/old-project/repo

# Add entire folder
./add_to_ignore.sh external-repos
```

**When to use:**
- External repos with thousands of commits behind
- Repos with authentication issues
- Repos you don't maintain
- Test/experimental repos

---

## ⚙️ Configuration

### 1. GitHub Accounts
Edit `update_git_repos.sh` line ~40:
```bash
MY_GITHUB_ACCOUNTS=("yasserfarouk" "autoneg" "yassernec")
```

### 2. Code Directory
Default: `~/code`

To change, edit `update_git_repos.sh` line ~104:
```bash
CODE_DIR="$HOME/code"
```

### 3. Ignore List
Create/edit `~/.git_repos_ignore`:
```bash
# Comments start with #
learning
external-repos/old-project
papers/rejected/old-conference
```

### 4. Folders to Sync
Edit `backup.sh` FOLDERS_TO_SYNC array:
```bash
FOLDERS_TO_SYNC=(
    "$HOME/.ssh"
    "$HOME/code"
    # Add your folders here
)
```

### 5. Rate Limits
Edit `update_git_repos.sh` lines 37-38:
```bash
GITHUB_API_DELAY=3               # seconds between repo creations
MAX_GITHUB_REPOS_PER_RUN=50      # max repos per run
```

---

## 💡 Usage Examples

### Scenario 1: Daily Backup (Recommended)
```bash
# Run from anywhere
cd ~/code/personal/dotfiles/backup_scripts
./backup.sh
```

### Scenario 2: Just Update Git Repos
```bash
./update_git_repos.sh
```

### Scenario 3: Generate Fresh Restore Scripts
```bash
./generate_restore_script.sh
```

### Scenario 4: Complete System Restoration (New Machine) ⭐
```bash
# On your new macOS/Linux machine:
# 1. Copy backup directory from iCloud/USB/Network
# 2. Copy restore.sh to the new machine
# 3. Run restoration
./restore.sh ~/Documents/MacBackup

# Follow post-restoration steps:
# - Authenticate with GitHub: gh auth login
# - Test SSH: ssh -T git@github.com
# - Configure git user
# - Reboot
```

**Windows:**
```powershell
# Open PowerShell as Administrator
# 1. Copy backup from USB/Network to D:\MacBackup
# 2. Copy restore.ps1 to your machine
# 3. Run restoration
.\restore.ps1 -BackupPath "D:\MacBackup"

# Follow post-restoration steps
```

### Scenario 5: Ignore Problematic Repos
```bash
# Repo is thousands of commits behind upstream
./add_to_ignore.sh learning/pytorch-tutorial

# Then run backup again
./backup.sh
```

### Scenario 6: Manual Restore on New Machine (Old Method)
```bash
# Copy restore script to new machine
scp restore_git_repos.sh newmachine:~

# On new machine
ssh newmachine
chmod +x restore_git_repos.sh
./restore_git_repos.sh
```

### Scenario 7: Setup Cron Job (Automated Daily Backup)
```bash
# Edit crontab
crontab -e

# Add line (runs at 2 AM daily)
0 2 * * * cd ~/code/personal/dotfiles/backup_scripts && ./backup.sh >> ~/backup.log 2>&1
```

---

## 🔧 Troubleshooting

### Issue: "Permission denied (publickey)"
**Solution:** SSH keys not configured
```bash
# Check SSH connection
ssh -T git@github.com

# If fails, add your SSH key to GitHub
cat ~/.ssh/id_ed25519.pub
# Add at: https://github.com/settings/keys
```

### Issue: "gh: command not found"
**Solution:** Install GitHub CLI
```bash
brew install gh
gh auth login
```

### Issue: Script hangs or prompts for password
**Solution:** Should never happen with current version
- Script uses `GIT_TERMINAL_PROMPT=0` to prevent prompts
- All operations timeout after 30s
- Check the "Push failures" report at the end

### Issue: "timeout: command not found"
**Solution:** Install coreutils
```bash
brew install coreutils  # macOS
sudo apt-get install coreutils  # Linux
```

### Issue: Too many repos being created
**Solution:** Some repos already exist on GitHub but script doesn't recognize them
- Check if repos are under your configured GitHub accounts
- Add external repos to ignore list

### Issue: Want to skip certain repos
**Solution:** Use ignore list
```bash
./add_to_ignore.sh path/to/repo
```

### Issue: Repos not pushing
**Solution:** Check the final report section "Push Failures"
- Usually SSH key issues
- Run: `ssh -T git@github.com` to test

---

## 🛡️ Safety Features

### Never Destructive
- ✅ Never deletes anything
- ✅ Never force pushes to origin (only to backup remotes)
- ✅ Never modifies remote repos you don't own
- ✅ Creates backups before any risky operations

### Never Hangs
- ✅ All git operations timeout after 30s
- ✅ `GIT_TERMINAL_PROMPT=0` prevents credential prompts
- ✅ SSH batch mode (no interactive auth)
- ✅ Safe for cron jobs and unattended operation

### Ownership Protection
- ✅ Checks repo ownership before pushing
- ✅ Only pushes to repos you own
- ✅ Creates backup repos for external repos
- ✅ Never pushes to upstream external repos

### Rate Limiting
- ✅ Max 50 GitHub repos created per run
- ✅ 3 second delay between creations
- ✅ Respects GitHub API limits
- ✅ Can be run multiple times to create more repos

### Comprehensive Reporting
- ✅ Shows all operations performed
- ✅ Lists all failures with reasons
- ✅ Provides recommendations
- ✅ Statistics and summaries
- ✅ Helpful hints for fixing issues

---

## 📊 Understanding The Reports

After running `update_git_repos.sh`, you'll see several reports:

### 1. Repositories Without Remotes
Local repos that were given a GitHub remote and pushed

### 2. Repositories Behind Remote
Repos where remote has new commits (you need to pull)

### 3. Diverged History
Repos with diverged history (both local and remote have new commits)
- A backup fork was created on GitHub
- Original remote preserved

### 4. WIP Commits
Repos where uncommitted changes were auto-committed

### 5. Successfully Pushed
Repos where local commits were pushed to origin

### 6. Bitbucket/GitLab Migrations
Repos that were migrated from Bitbucket/GitLab to GitHub

### 7. HTTPS to SSH Conversions
Repos where HTTPS URLs were converted to SSH

### 8. Push Failures
Repos where push failed (usually SSH key issues)

### 9. Summary Statistics
Overall counts and recommendations

---

## 🔐 Security Considerations

### SSH Keys
- Store SSH keys securely
- Use passphrase-protected keys
- Use ssh-agent to avoid repeated passphrase entry

### Secrets
- Never commit secrets to repos
- Use `.gitignore` for sensitive files
- Consider using git-crypt or similar

### iCloud Backup
- Scripts are backed up to iCloud
- Make sure iCloud has 2FA enabled
- Consider encryption for sensitive data

---

## 📅 Recommended Workflow

### Daily (Automated)
```bash
# Setup cron job to run at 2 AM
0 2 * * * cd ~/code/personal/dotfiles/backup_scripts && ./backup.sh
```

### Weekly (Manual)
1. Review the backup reports
2. Check "Push Failures" section
3. Fix any SSH key issues
4. Update ignore list if needed

### Monthly (Maintenance)
1. Verify iCloud backup is syncing
2. **Test restore script on a test VM or machine**
3. Review and clean up old repos
4. Check GitHub storage usage

### When Getting New Machine
1. **Copy backup from iCloud/USB to new machine**
2. **Run `restore.sh` (or `restore.ps1` on Windows)**
3. **Follow post-restoration checklist**
4. **Verify all repos and tools work**
5. **Setup automated backups with cron/Task Scheduler**

---

## 🔄 Complete Restoration Workflow

### For macOS/Linux

**Step-by-step process when restoring to a new machine:**

1. **Prepare the backup**
   ```bash
   # Backup should be available in one of these locations:
   # - iCloud: ~/Documents/MacBackup
   # - USB drive: /Volumes/Backup/MacBackup
   # - Network: /mnt/nas/backups/MacBackup
   ```

2. **Copy restore script**
   ```bash
   # The restore.sh script should be in the backup
   cp ~/Documents/MacBackup/git_management_scripts/restore.sh ~/
   chmod +x ~/restore.sh
   ```

3. **Run restoration**
   ```bash
   ./restore.sh ~/Documents/MacBackup
   
   # The script will:
   # ✓ Restore SSH keys
   # ✓ Restore config folders
   # ✓ Install Homebrew & tools
   # ✓ Restore all git repos
   # ✓ Restore non-git folders
   # ✓ Install all Brewfile packages
   ```

4. **Post-restoration**
   ```bash
   # Authenticate with GitHub
   gh auth login
   
   # Test SSH connection
   ssh -T git@github.com
   
   # Configure git if needed
   git config --global user.name "Your Name"
   git config --global user.email "your@email.com"
   
   # Reboot
   sudo reboot
   ```

### For Windows

**Step-by-step process when restoring to a new Windows machine:**

1. **Prepare the backup**
   ```powershell
   # Copy backup to Windows machine
   # - USB: D:\MacBackup
   # - Network: \\NAS\backups\MacBackup
   ```

2. **Copy restore script**
   ```powershell
   # The restore.ps1 script should be in the backup
   Copy-Item "D:\MacBackup\git_management_scripts\restore.ps1" "$env:USERPROFILE\"
   ```

3. **Run PowerShell as Administrator**
   ```powershell
   # Right-click PowerShell → Run as Administrator
   ```

4. **Run restoration**
   ```powershell
   cd $env:USERPROFILE
   .\restore.ps1 -BackupPath "D:\MacBackup"
   
   # The script will:
   # ✓ Restore SSH keys
   # ✓ Restore config folders
   # ✓ Install Git & GitHub CLI via winget
   # ✓ Restore all git repos
   # ✓ Restore non-git folders
   # ✓ Install common dev packages
   ```

5. **Post-restoration**
   ```powershell
   # Authenticate with GitHub
   gh auth login
   
   # Test SSH connection
   ssh -T git@github.com
   
   # Configure git if needed
   git config --global user.name "Your Name"
   git config --global user.email "your@email.com"
   
   # Restart computer
   Restart-Computer
   ```

### What Gets Restored

| Item | Source | Destination | Notes |
|------|--------|-------------|-------|
| SSH Keys | `.ssh/` | `~/.ssh/` | Permissions fixed automatically |
| Config | `.config/` | `~/.config/` | All application configs |
| Git Repos | `code/` | `~/code/` | Only repos with git remotes |
| Non-Git Folders | `code/` | `~/code/` | Folders without .git |
| Scripts | `bin/` | `~/bin/` | Custom scripts |
| Desktop/Downloads | Desktop/, Downloads/ | ~/Desktop/, ~/Downloads/ | All files |
| Packages | Brewfile | System | All Homebrew packages |

---

## 🤝 Contributing

Feel free to submit issues or improvements!

---

## 📝 License

MIT License - feel free to use and modify

---

## 👤 Author

Generated by OpenCode
Date: 2026-03-23

---

## 📚 Additional Resources

- [GitHub CLI Documentation](https://cli.github.com/manual/)
- [Git Documentation](https://git-scm.com/doc)
- [SSH Key Setup Guide](https://docs.github.com/en/authentication/connecting-to-github-with-ssh)
- [rsync Manual](https://linux.die.net/man/1/rsync)

---

## 🎯 Quick Reference Card

```bash
# BACKUP
# Full backup (everything)
./backup.sh

# Just git operations
./update_git_repos.sh

# Just generate restore scripts
./generate_restore_script.sh

# RESTORE
# Complete system restore (macOS/Linux)
./restore.sh ~/Documents/MacBackup

# Complete system restore (Windows PowerShell as Admin)
.\restore.ps1 -BackupPath "D:\MacBackup"

# MANAGEMENT
# Add repo to ignore list
./add_to_ignore.sh <path>

# View ignore list
cat ~/.git_repos_ignore

# Test SSH connection
ssh -T git@github.com

# Check git status in all repos
find ~/code -name .git -type d -execdir pwd \; -execdir git status -s \;

# TROUBLESHOOTING
# Authenticate with GitHub
gh auth login

# View backup log
tail -f ~/backup.log

# View restore log
tail -f ~/restore_*.log
```

