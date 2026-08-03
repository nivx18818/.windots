# Git

## Configuration

- Run the following commands in PowerShell to set up your Git configuration:

  ```powershell
  git config --global user.name "Your Name"
  git config --global user.email "your_email@example.com"
  git config --global init.defaultBranch main
  git config --global core.autocrlf true
  git config --global core.editor "code --wait"
  git config --global color.ui auto
  git config --global fetch.prune true
  git config --global credential.helper manager
  ```

- Verify the configuration:

  ```powershell
  git config --global --list
  ```

- Set up SSH instead of HTTPS (Authentication key)

  ```powershell
  ssh-keygen -t ed25519 -C "your_email@example.com"
  ```

- Reuse authentication key for signing:

  ```powershell
  git config --global gpg.format ssh
  git config --global user.signingkey ~/.ssh/id_ed25519.pub
  git config --global commit.gpgsign true
  ```

- Add the SSH key to your Git hosting service (e.g., GitHub, GitLab, Bitbucket) by copying the contents of `~/.ssh/id_ed25519.pub` and adding it to your account's SSH keys.
