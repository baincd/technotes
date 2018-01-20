# How to change your shell from ksh to bash when chsh is not allowed

Unix system, uses ksh as the login shell by default.  Users are not allowed to change their shell (using chsh or any other means).

Solution found [here](http://unix.stackexchange.com/a/46682)

1) Create `~/.bash_profile` This ensures that bash uses this file instead of `~/.profile`
2) Put the following at the end of ~/.profile
```bash
   case $- in
    *i*)
      # Interactive session. Try switching to bash.
      if [ -z "$BASH" ]; then # do nothing if running under bash already
        bash=$(command -v bash)
        if [ -x "$bash" ]; then
          export SHELL="$bash"
          exec "$bash" -l
        fi
      fi
  esac
```

3) Before logging out, login with another terminal window to make sure it works!  If you mess up and have logged out of all the terminal windows, a sysadmin will have to fix this for you.
