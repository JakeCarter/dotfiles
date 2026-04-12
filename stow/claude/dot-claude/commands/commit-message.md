  Review the staged git diff and write a conventional commit message.

  Rules:
  - Keep the subject under 72 characters, imperative mood
  - Add a body if the change needs explanation
  - Do not hard wrap lines in the body
  - Do not include anything other than the commit message
  - Use bullet points
  - No need for full sentences, but do use sentence case
  - Output in such a way that I can easily copy/paste the ouput without needing to outdent or fix whitespace
  - Prefer single quotes to backticks

  Run `git diff --staged` to see what's staged, then output only the commit message.
