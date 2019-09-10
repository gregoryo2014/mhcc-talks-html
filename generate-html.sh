#!/usr/bin/env sh
#
# Generate HTML for Weebly talks page
#
# First edit: Just generate new text to add to existing document(s)
#
set -o nounset
set -o errexit

IFS='
'

usage() {
  cat <<- EOF
  Usage:
  $0 -f file -s 'speaker name' -t 'talk topic'
EOF
}

while getopts "f:hs:t:" option; do
  case $option in
    f) UPLOAD_FILE=$OPTARG;;
    s) SPEAKER=$OPTARG;;
    t) TOPIC=$OPTARG;;
    h) usage; exit 0;;
  esac
done

FILENAME=$(basename $UPLOAD_FILE)
DATE=$(echo $FILENAME | cut -c 1-8)
SIZE=$(du -m "$UPLOAD_FILE" | cut -f 1)

[ -f "$UPLOAD_FILE" ] || {
  echo "Couldn't find file: $UPLOAD_FILE"
  exit 1
}

cat <<EOF
############################################################
<TR CLASS=R> <TD CLASS=C1>$DATE</TD> <TD CLASS=C2>$SPEAKER</TD>
<TD CLASS=C3>$TOPIC</TD> <TD CLASS=C4>
<A TARGET="MHCC" HREF="/uploads/6/0/7/6/6076729/20190818_cm.mp3">$FILENAME</A>
</TD><TD CLASS=C5>${SIZE}MB</TD></TR>

############################################################
EOF

unset IFS
