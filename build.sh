#!/bin/bash
FLUTTER_BRANCH=`grep channel: .metadata | sed 's/  channel: //g'`

# Get flutter
git clone https://github.com/flutter/flutter.git
FLUTTER=flutter/bin/flutter

#Flutter channel cmd
cmd="${FLUTTER} channel stable"

# Set channel info and update
DIR=$($cmd >& /dev/stdout)
echo "<!-- $DIR -->"
$FLUTTER config --enable-web
if [[ $DIR == *"Your branch is behind"* ]]; then
  echo "Update starting"
  $FLUTTER upgrade
  echo "Update finished"
fi

# Build flutter for web
$FLUTTER build web --release 