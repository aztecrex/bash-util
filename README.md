# Bash Util

Now with 100% Gitter: [![Gitter](https://badges.gitter.im/gitterHQ/gitter.svg)](https://gitter.im/aztecrex/bash-util)

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

Then in ```.bashrc```, you might

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
