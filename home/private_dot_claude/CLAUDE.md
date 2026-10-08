# Claude Rules

## Tool preferences

* When searching outside the `Grep` tool, use ripgrep (`rg`), not `grep`.
* Run Python through `uv` (`uv run`, `uvx`). uv is the only Python toolchain on this machine, so a bare `python`/`python3` is not one to rely on.
* Prefer `jq` over `python3 -m json.tool`. Easier to read, and easier to extend with custom filters.

## Git workflow

* Don't amend commits unless necessary, strongly advised or user-requested. I prefer smaller commits when they are atomic and individually working.
* When creating a Git worktree, place it inside the current repo at `.worktrees/<name>` (e.g. `git worktree add -b my-branch --no-track .worktrees/my-branch origin/main`), NOT as a sibling at the parent level. Keeping it inside the project stays within the permission scope and avoids extra permission prompts. My global gitignore (`~/.config/git/ignore`) already lists `.worktrees/`, so these never show up as untracked files. Clean up with `git worktree remove .worktrees/<name>` when done.
* When a change splits into dependent pieces that are each reviewable on their own, use `gh stack` and its skill to create chained pull requests.

## Writing style

Avoid these AI-coded words/phrases when generating text:

* "load-bearing"
* "canonical"
* "quietly"
* "here's the kicker"
* negative parallelism ("not X, Y").

## Timelessness

Treat codebases as timeless.

Code and comments must make sense to a developer encountering the repository with no knowledge of this conversation, task, PR, or previous implementation.

Do not include:

* references to the prompt, conversation, task, issue, or review process;
* unnecessary descriptions of what changed or what the code used to do;
* rejected approaches or comparisons with previous implementations;
* comments such as “we now…”, “this was changed because…”, “keeping this…”, or “instead of the old approach…”.

Comments should document only durable information about the current code: non-obvious invariants, constraints, external requirements, or reasons the current implementation must have its present form.

Assume future maintainers will be proficient with Git archaeology and can review the commit history and pulls requests to understand the evolution of the code.
Put implementation history and rejected alternatives in the commit message and/or PR description, not the source code.

Before finishing, review the diff and remove any comments or identifiers that only make sense given the conversation that produced the change.

## Communication

You will have access to tools allowing you to communicate with my colleagues in the real world, like:

* Slack
* Linear
* GitHub issues, PR reviews and comments

I want my colleagues to clearly know when a human vs. a bot is talking to them.

Sometimes, we're drafting a message together, and I'll vet and approve it. In those cases, I'm posting through you and it's fine to "impersonate me".

If I ask you to comment or you take that initiative and entirely write the message, then you should ALWAYS preface the message with:

> _Sent by Claude ([your model name, e.g. Opus 5]) on behalf of Sam_

Git commits and PR descriptions are exempt, as long as the Co-Authored-By trailer and the "Generated with Claude Code" footer are present.

## Other

* Use double quotes to escape whitespace in paths, not backslashes. Backslashes result in an extra permission check, because the command "Contains backslash-escaped whitespace"
* When you are outputting in the terminal, never reference raw PR numbers like `#123`. Always use a markdown link like `[repo#123](https://github.com/samueldg/repo/pull/123)` so that the PR number is clickable, and self-contained. Similarly, use links for Linear or Sentry issues.
* `__sdg__/` is my personal scratchpad directory (my initials). It's listed in my global gitignore (`~/.config/git/ignore`), so an `__sdg__/` dir at any repo root is never tracked. Use it freely for notes, briefs, plans, and other durable working files that should live alongside a repo but not be committed — e.g. a brief to hand off to a fresh session. Create it at the repo root if it doesn't exist. (Distinct from the session scratchpad under `/private/tmp/...`, which is ephemeral; `__sdg__/` persists in the working tree.) NEVER mention it in a pull request description, commit message, code comment etc. These documents are only available to me.
