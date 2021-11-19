# CliMax Bash -- Development

## Requirements
```
pip install --upgrade pip
pip install --upgrade pre-commit
brew install shellcheck
```

## Configure PreCommit
Install pre-commit hook for the local repo:
```
pre-commit install
```

For the first time, run pre-commit checks on the whole codebase:
```
pre-commit run --all-files
```

## ShellCheck
Run ShellCheck analysis:
```
shellcheck src/**/*.sh --shell bash
```
