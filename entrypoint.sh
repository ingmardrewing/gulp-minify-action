#!/bin/sh

# Exit if any subcommand fails
set -e

# Setup node modules if needed
if [ -e node_modules/.bin/gulp ]; then
    setup=""
else
    echo "## Your environment is not ready yet. Installing modules..."
    if [ -f yarn.lock ]; then
        setup="yarn --non-interactive --silent --ignore-scripts --production=false &&"
    else
        if [ -f package-lock.json ]; then
            setup="NODE_ENV=development npm ci --ignore-scripts &&"
        else
            setup="NODE_ENV=development npm install --no-package-lock --ignore-scripts &&"
        fi
    fi
fi

if [ -z "$1" ]; then
    glob="."
else
    glob="$@"
fi

echo "## Running Gulp minify"
sh -c "$setup ./node_modules/.bin/gulp minify"
