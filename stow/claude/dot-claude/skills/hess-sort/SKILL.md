---
name: hess-sort
description: Performs a "Hess Sort" to lines of multiline text using a custom Swift sorting algorithm. Use this skill whenever the user asks to hess sort.
---

# Line Sorter

Reorders lines of multiline text using a custom Swift sorting algorithm bundled in `scripts/hess-sort.swift`.

## Workflow

1. **Collect the input** — get the multiline text from the user (pasted inline or from a file).
2. **Run the script** via `bash_tool`, piping lines into stdin using a heredoc:

```bash
swift /path/to/skill/scripts/hess-sort.swift <<'EOF'
line 1
line 2
line 3
EOF
```

Use the absolute path to `scripts/hess-sort.swift`.

Example invocation:
```bash
swift /path/to/hess-sort.swift <<'EOF'
apple
banana
cherry
EOF
```

3. **Capture stdout** — the script outputs the reordered lines, one per line.
4. **Return the result** to the user, formatted as a clean block of text.

## Error handling

- If `swift` is not found, tell the user they need Swift installed (https://swift.org/install).
- If the script exits non-zero, show the stderr output and ask the user to check the script.
- If input is empty, ask the user to provide the text to sort.

## Notes

- The script reads lines from stdin (one line per line). Pipe, redirect, or use a heredoc to pass input.
- Line count in == line count out (the script reorders, never drops or adds lines).
- Do not modify or reformat the script's output — return it as-is.
