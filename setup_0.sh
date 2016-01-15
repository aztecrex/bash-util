# common functions

am-mac() {
  test "$OSTYPE" = "darwin15"
}

am-linux() {
  ! $(am-mac)
}
