# mhcc-talks-html

Generate HTML for http://www.mhcc.asn.au/talks.html using data file
talks-data.csv, which should be in the format below. Note the file should
exist in the compressed audio files directory, and its name should start with
the date stamp. Lines should be in reverse chronological order, and should be
preserved - just add new ones at the top.

Data files are expected to be in the directory '../compressed audio files'.

```# Date,Speaker,Topic,Filename 1[,Filename 2[,...]]
10/09/2019,Name Of Speaker 2,Topic of talk 2,20190910-filename2.mp3,20190910-filename2.pdf
09/09/2019,Name Of Speaker,Topic of talk,20190909.filename.mp3```

## HOW TO USE:
1. Populate talks-data.csv
1. ./generate-html.sh > data/10-data
1. Concatenate the data to the clipboard:
  * Ubuntu: cat data/* | xclip -sel c
  * Mac:    cat data/* | pbcopy
1. Paste into the talks page HTML object.
1. Click Publish.

Separately (before or after), upload the audio files to the "Talks holding page" on
Weebly.
