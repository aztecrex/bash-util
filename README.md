# Bash Util

Here are common setups for some of the tools I use. They should be useful for both Linux and Mac (assuming homebrew).

I put these into a Dropbox folder then source them from each machine I use.

For example, in ```bash_profile```, something like:

```bash
if [ -f ~/.bashrc ]; then
  source ~/.bashrc  # assume bashrc will source common
else
  _zero=~/Dropbox/Bash/zero.sh
  if [ -f $_zero ]; then
    source $_zero
    bash-util-common
  fi
  unset _zero
fi
bash-util-interactive
```

Then in ```.bashrc```:

```bash
_zero=~/Dropbox/Bash/zero.sh
if [ -f $_zero ]; then
  source $_zero
  bash-util-common
fi
unset _zero
```

----
&copy; Greg Wiley

License: BSD3 (see LICENSE)
