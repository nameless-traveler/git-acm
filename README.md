# git-acm

`git-acm` is a small Git helper for the most common workflow: add, commit, and optionally push.

If you are tired of typing the same three commands every time, this keeps it simple.

```bash
git add .
git commit -m "message"
git push
```

becomes:

```bash
git acm "message" -p
```

## Commands

- `git acm "message"`
Stages everything and creates a commit.

- `git acm "message" -p`
Stages, commits, then pushes.

- `git acm "message" -p orm`
Stages, commits, then runs `git push -u origin main` (useful for first push).

## Install

1. Clone the repo:

```bash
git clone https://github.com/YOUR_USERNAME/git-acm.git
cd git-acm
```

2. Make scripts executable:

```bash
chmod +x git-acm install.sh uninstall.sh
```

If you are skeptical about `chmod` in the command, copy-paste the code into any AI and ask whether it is harmful or not.

3. Run installer:

```bash
./install.sh
```

### Demo (Install + Working)

![Demo of installing and using git-acm](assets/demo-install-working.jpeg)

The installer copies `git-acm` to `~/.local/bin/` (or `/usr/local/bin/`) and marks it executable.

4. If needed, add this to your shell config (`~/.bashrc` or `~/.zshrc`):

```bash
export PATH="$HOME/.local/bin:$PATH"
```

Reload shell:

```bash
source ~/.bashrc
# or
source ~/.zshrc
```

5. Verify:

```bash
git acm --help
```

## Examples

```bash
# Stage + commit
git acm "fix: typo in README"

# Stage + commit + push
git acm "feat: add login page" -p

# First push to origin/main (sets upstream)
git acm "initial commit" -p orm
```

## Add Your Own Custom Commands

`git-acm` is just a Bash script, so you can add your own flags/behavior by editing the `git-acm` file.

1. Open `git-acm` and add a new flag variable near:

```bash
PUSH=false
ORM=false
```

For example:

```bash
PUSH=false
ORM=false
NO_VERIFY=false
```

2. In the `while [[ $# -gt 0 ]]; do ... case "$1" in` block, add your flag:

```bash
    -nv|--no-verify)
      NO_VERIFY=true
      shift
      ;;
```

3. Update the commit step to use that flag:

```bash
if $NO_VERIFY; then
  git commit -m "$MESSAGE" --no-verify
else
  git commit -m "$MESSAGE"
fi
```

4. (Optional but recommended) add the new option to `show_help()` so users can discover it.

5. Reinstall to apply changes globally:

```bash
./install.sh
```

Then use:

```bash
git acm "your message" -nv
```

Tip: keep custom flag names short and unique to avoid confusion with standard Git flags.

## Uninstall

```bash
./uninstall.sh
```

You only need the `chmod` step once.

## Why this works

Git treats executables named `git-<name>` as subcommands. So if `git-acm` is in your `PATH`, `git acm` works automatically.

## License

MIT
