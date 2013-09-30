#!/bin/bash

BACKGROUND_COLOR="black"
TEXT_COLOR="white"
FONT_PATH=$HOME/.fonts/random-fact-wallpaper.otf
FONT_SIZE=60
FONT_URL="https://copy.com/oOvnMBqTxYwh/Please%20write%20me%20a%20song.ttf?download=1"
WALLPAPER_SIZE="1920x1080"
WALLPAPER_PATH=$1
GITHUB_OAUTH_TOKEN_PATH=$HOME/.random-fact-wallpaper-oauth.token

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

# Do we have a GitHub OAuth token
# We want a GitHub OAuth token so we aren't rate limited to 60 requests / hour for the GitHub API
if [ ! -e "$GITHUB_OAUTH_TOKEN_PATH" ]; then
    echo -n "What is your GitHub username: "
    read GITHUB_USERNAME

    echo "Requesting a GitHub OAuth token"
    RESPONSE_FILE=`mktemp --suffix=.json`
    curl --silent -u "$GITHUB_USERNAME" -d '{"note": "Random Fact Wallpaper Script"}' https://api.github.com/authorizations > $RESPONSE_FILE

    GITHUB_OAUTH_TOKEN=`cat $RESPONSE_FILE | grep token | awk '{print $2'} | sed -e 's/"//g' -e 's/,//g'`
    if [ -z "$GITHUB_OAUTH_TOKEN" ]; then
        echo "Did not get OAUth token:"
        cat $RESPONSE_FILE
        exit 1
    fi

    echo "Writing GitHub OAuth token to $GITHUB_OAUTH_TOKEN_PATH"
    echo "$GITHUB_OAUTH_TOKEN" | sudo tee $GITHUB_OAUTH_TOKEN_PATH
else
    GITHUB_OAUTH_TOKEN=`cat $GITHUB_OAUTH_TOKEN_PATH`
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
