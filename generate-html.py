#!/usr/bin/env python
#
# Author: Gregory Orange
#
# Generate HTML for Weebly talks page, using data file talks-data.csv, which
# should be in the format below. Note the file should exist in the compressed
# audio files directory, and its name should start with the date stamp. Lines
# should be in reverse chronological order, and should be preserved - just add
# new ones.
#
# # Bare filename,Speaker,Topic
# Name Of Speaker 2,Topic of talk 2,20190910-filename2.mp3,20190910-filename2.pdf
# Name Of Speaker,Topic of talk,20190909.filename.mp3,
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
import re, os

# https://stackoverflow.com/questions/1094841/reusable-library-to-get-human-readable-version-of-file-size
def sizeof_fmt(num, suffix='B'):
    for unit in ['','K','M','G','T','P','E','Z']:
        if abs(num) < 1000.0:
            return "%3.1f%s%s" % (num, unit, suffix)
        num /= 1000.0
    return "%.1f%s%s" % (num, 'Y', suffix)

############################################################

for line in open("talks-data.csv", "r"):
  if not re.match("^ *#", line):
    fields = line.rstrip().split(',')
    date = fields.pop(0)
    speaker = fields.pop(0)
    topic = fields.pop(0)
    size = 0
    # http://wiki.christophchamp.com/index.php?title=Python
    # https://stackoverflow.com/questions/10112614/how-do-i-create-a-multiline-python-string-with-inline-variables

    head = """\
<TR CLASS=R> <TD CLASS=C1>%s</TD> <TD CLASS=C2>%s</TD>
<TD CLASS=C3>%s</TD> <TD CLASS=C4>
""" % (date, speaker, topic)

    body = ""
    for filename in fields:
      body += """\
<A TARGET="MHCC" HREF="/uploads/6/0/7/6/6076729/%s">%s</A><BR />
""" % (filename, filename)
      path = "../compressed audio files/" + filename
      this_size = os.path.getsize(path)
      if this_size > size:
        size = this_size

    tail = "</TD><TD CLASS=C5>" + str(sizeof_fmt(size)) + "</TD></TR>"

    print head.rstrip()
    print body.rstrip()
    print tail
    print
