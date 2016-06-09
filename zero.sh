# common functions

am-mac() {
  echo $OSTYPE | grep '^darwin' > /dev/null
}

am-linux() {
  ! $(am-mac)
}

_bash-util-dir() {
  dirname ${BASH_SOURCE[0]}
}

bash-util-interactive() {
  local recopt=$(shopt -p nullglob)
  shopt -s nullglob
  local files=($(_bash-util-dir)/interactive_* )
  if [ ${#files[@]} -gt 0 ]; then
    for s in $(_bash-util-dir)/interactive_*; do
      source $s
    done
  fi
  eval $recopt
}

bash-util-common() {
  local recopt=$(shopt -p nullglob)
  shopt -s nullglob
  local files=($(_bash-util-dir)/common_*)
  if [ ${#files[@]} -gt 0 ]; then
    for s in $(_bash-util-dir)/common_*; do
      source $s
    done
  fi
  eval $recopt
}
