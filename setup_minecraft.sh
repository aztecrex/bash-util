
if [ -f $HOME/.lib/Minecraft.jar ]; then
  if $(am-linux); then
    # LINUX: prevent keyboard lockups in minecraft (method works for any java-based ui)
    alias minecraft='XMODIFIERS= java -jar $HOME/.lib/Minecraft.jar > /dev/null < /dev/null 2>&1 & disown'
  else
    alias minecraft='java -jar $HOME/.lib/Minecraft.jar > /dev/null < /dev/null 2>&1 & disown'
  fi
fi
