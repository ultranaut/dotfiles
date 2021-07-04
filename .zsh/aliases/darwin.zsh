if [[ $OSTYPE==darwin* ]]; then
  alias flushdns='sudo dscacheutil -flushcache' # clear the dns cache on Mac OS
fi
