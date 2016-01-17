# common functions

# well-known user binary locations
for dir in ${HOME}/{bin,.local/bin}; do
  if [ -d $dir ]; then
    export PATH=${PATH}:${dir}
  fi
done
