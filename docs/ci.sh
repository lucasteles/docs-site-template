#!/usr/bin/env bash

GAME_NAME="Docs Template Mugen"
DEFAULT_PASSWORD=Password@Secret!123
TMP_DIR=_site_tmp
OUT_DIR=_site
export STATICRYPT_PASSWORD="${STATICRYPT_PASSWORD:-$DEFAULT_PASSWORD}"

echo "- Installing DocFx"
dotnet tool install -g docfx

echo "- Building Docs"
docfx --output $TMP_DIR

echo "- Encrypting Pages"
npx --yes staticrypt \
        $TMP_DIR/* \
        --recursive \
        --config false --short \
        --directory $OUT_DIR \
        --remember 1 \
        --template ./password_template.html \
        --template-color-primary "#323a42" \
        --template-color-secondary "#343a40" \
        --template-title "$GAME_NAME - Wiki" \
        --template-button "ENTER" \
        --template-instructions 'Enter the password'

echo "- Cleaning Temp Files"
rm -rf ./$TMP_DIR

echo "- Done!"
