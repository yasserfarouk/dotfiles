# Global instructions (all projects)

Shared by Claude Code (`~/.claude/CLAUDE.md`), Codex (`~/.codex/AGENTS.md`),
opencode (`~/.config/opencode/AGENTS.md`) and pi (`~/.pi/agent/AGENTS.md`);
the source is `base/agents/.config/agents/AGENTS.md` in the dotfiles repo.

## Git worktrees: always via workmux, always with readable names

- **Create, open, merge and remove worktrees with `workmux`** (`workmux add`,
  `open`, `merge`, `remove`, `list`, `path`) — never raw `git worktree add` or
  an agent's built-in worktree feature (Claude Code's `EnterWorktree` tool or
  `Agent(isolation: "worktree")`, `claude -w`, etc.), which produce unmanaged
  worktrees with random names.
- Worktrees live inside the main checkout at `<repo>/.worktrees/<name>`
  (`worktree_dir` in `~/.config/workmux/config.yaml`; ignored globally), each
  in its own tmux window running the default agent. `workmux add <name> -a codex`
  (or `opencode`, `pi`) picks another agent. When working inside
  `.worktrees/<name>`, stay in that worktree; don't edit the main checkout.
- **Name every worktree for what it does**: a short kebab-case description of
  the task, e.g. `workmux add fix-login-timeout` or
  `workmux add feature/nested-protocols --name nested-protocols`. Never an
  opaque/generated handle (`agent-a1b2c3`, `wt-1`, `tmp`, a hash or a date).
  Rename an existing badly-named one with `workmux rename`.
- **A project's own landing rules win** over workmux defaults: if the repo
  requires rebase-then-fast-forward (no merge commits), land with
  `workmux merge --rebase`; never push unless the project/user allows it.
- For dispatching tasks to parallel worktree agents, use the `worktree` /
  `coordinator` skills (both drive workmux).
