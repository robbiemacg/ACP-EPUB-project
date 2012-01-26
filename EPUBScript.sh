#!/bin/bash

# Top level directory
# Any .epub file under this directory
# will be modified
TOP_DIR="$HOME/Desktop/OriginalFiles"

# Output directory
# Modified epubs will be saved here
OUTPUT_DIR="$HOME/Desktop/OutputFiles"

# Create Output directory if it doesn't exist
if [ ! -d "$OUTPUT_DIR" ]; then
    mkdir -p "$OUTPUT_DIR"
fi

# Make epub
# execute function within target directory 
# to correctly package epub files
function  epub()
{
rm -f $@; zip -q0X $@ mimetype; zip -qXr9D $@ *
}

for EPUB in "$TOP_DIR/"*.epub
do
    if [ -f "$EPUB" ]
    then
        cp "$EPUB" "${EPUB}.zip"
        mkdir -p "${EPUB}.d"
        unzip -o "$EPUB" -x *Shortcovers.xml -d "${EPUB}.d"
        cd "${EPUB}.d"
        epub "${OUTPUT_DIR}/$(basename "$EPUB")"
        cd "$TOP_DIR"
        rm -rf "${EPUB}.d"
        rm -rf "$EPUB.zip"
    fi
done

