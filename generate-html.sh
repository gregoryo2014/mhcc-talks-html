#!/usr/bin/env bash
#
# Author: Gregory Orange
#
# Generate HTML for Weebly talks page, using data file talks-data.csv, which
# should be in the format below. Note the file should exist in the compressed
# audio files directory, and its name should start with the date stamp. Lines
# should be in reverse chronological order, and should be preserved - just add
# new ones.
#
# 20190910-filename2.mp3,Name Of Speaker 2,Topic of talk 2
# 20190909.filename.mp3,Name Of Speaker,Topic of talk
#
####################
# HOW TO USE:
####################
# 1. Populate talks-data.csv
# 2. ./generate-html.sh > data/10-data
# 3. Concatenate the data to the clipboard:
#   * Ubuntu: cat data/* | xclip -sel c
#   * Mac:    cat data/* | pbcopy
# 4. Paste into the talks page HTML object.
# 5. Click Publish.
#
# Separately (before or after), upload the audio files to the "Talks holding page" on
# Weebly.
####################
#
set -o nounset
set -o errexit

usage() {
  cat <<- EOF
  Usage:
  $0 -f file -s 'speaker name' -t 'talk topic'
EOF
}

############################################################
IFS='
'
SCRIPT_DIR=$(dirname $0)
DATA_FILE="$SCRIPT_DIR/talks-data.csv"
TALKS_DIR="$SCRIPT_DIR/../compressed audio files"

# process file
for line in $(cat $DATA_FILE); do
  FILENAME=$(echo $line | cut -f1 -d,)
  SPEAKER=$(echo $line | cut -f2 -d,)
  TOPIC=$(echo $line | cut -f3 -d,)
  UPLOAD_FILE="$TALKS_DIR/$FILENAME"
  FILENAME=$(basename $UPLOAD_FILE)
  DATE=$(echo $FILENAME | cut -c 1-8)
  SIZE=$(du -m "$UPLOAD_FILE" | cut -f 1)

  cat <<EOF
<TR CLASS=R> <TD CLASS=C1>$DATE</TD> <TD CLASS=C2>$SPEAKER</TD>
<TD CLASS=C3>$TOPIC</TD> <TD CLASS=C4>
<A TARGET="MHCC" HREF="/uploads/6/0/7/6/6076729/$FILENAME">$FILENAME</A>
</TD><TD CLASS=C5>${SIZE}MB</TD></TR>

EOF

done
