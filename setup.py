#!/usr/bin/env python

import subprocess, inspect, os

# these files don't need to be symlimked
dont_link = [
  "README.md",
  ".git",
  ".gitignore",
  ".gitmodules",
  ".DS_Store",
  "LICENSE.txt",
  "README.md",
  "Brewfile",
  "Brewfile.lock.json",
  "Session.vim",
  "setup.py"
]

def make_symlinks():
  linked = []
  dotfiles_contents = os.listdir(dotfiles_root)
  for item in dotfiles_contents:
    if item not in dont_link and not item.endswith('.template'):
      src = os.path.join(dotfiles_root, item)
      dest = os.path.join(user_home, item)
      if os.path.exists(dest):
        print ("  %s exists, skipping..." % dest)
      else:
        os.symlink(src, dest)
        linked.append([dest, src])
        print ("  %s => %s" % (dest, src))
  return linked


if __name__ == "__main__":
  # Get the name of current file and its parent directory,
  # as well as the user's home directory.
  rel_path = inspect.getfile(inspect.currentframe())
  myself = os.path.basename(rel_path)
  dotfiles_root = os.path.dirname(os.path.abspath(rel_path))
  user_home = os.path.expanduser('~')

  print "\nStarting..."

  # Create the symlinks.
  print "\nCreating links..."
  linked = make_symlinks()

  # fetch and initialize submodules
  subprocess.call(['git', 'submodule', 'update', '--init'])
  
