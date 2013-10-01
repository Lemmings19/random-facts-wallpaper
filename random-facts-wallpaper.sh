#!/bin/bash

BACKGROUND_COLOR="black"
TEXT_COLOR="white"
FONT_PATH=$HOME/.fonts/random-fact-wallpaper.otf
FONT_SIZE=60
FONT_URL="https://copy.com/oOvnMBqTxYwh/Please%20write%20me%20a%20song.ttf?download=1"
WALLPAPER_SIZE="1920x1080"
WALLPAPER_PATH=$1

# Oh yeah, you need PHP
# Here's the script to make sure you have PHP:
# DO YOU HAVE PHP?
# YES > GOOD
# NO > SHIT

# Make sure we have a valid wallpaper path
if [ ! -e "$WALLPAPER_PATH" ]; then
    echo "Usage: `basename $0` [wallpaper path]";
    echo "e.g. `basename $0` $HOME/Pictures/"
    exit 1;
fi

# Is imagemagick installed?
if [ -z `which convert` ]; then
    echo "Installing imagemagick"
    sudo apt-get install imagemagick
fi

# Download the font if it doesn't exist
if [ ! -e "$FONT_PATH" ]; then
    echo "Downloading `basename $FONT_PATH`"
    mkdir -p `dirname $FONT_PATH`
    wget "$FONT_URL" -O $FONT_PATH
fi

# Get a random fact
RANDOM_FACT=`php randomFacts.php`

# Create the wallpaper
convert \
    -background $BACKGROUND_COLOR \
    -fill $TEXT_COLOR \
    -size $WALLPAPER_SIZE \
    -font $FONT_PATH \
    -gravity Center \
    -pointsize $FONT_SIZE caption:"$RANDOM_FACT" \
    $WALLPAPER_PATH/random-wallpaper.png
