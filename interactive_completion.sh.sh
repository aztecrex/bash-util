# tab-completion is not automatically configured on mac
# this loads the homebrew completion if this is a mac
# it does not configure auto-completion for packages that
# do not use the homebrew auto-completion mechanism (e.g.
# awscli)
if $(am-mac); then
  if [ -f $(brew --prefix)/etc/bash_completion ]; then
      source $(brew --prefix)/etc/bash_completion
  fi
fi
