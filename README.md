# mhcc-talks-html

Generate HTML for http://www.mhcc.asn.au/talks.html using metadata file
`talks-data.csv`, which should be in the format below. Lines should be in
reverse chronological order, and should be preserved - just add new ones at the
top.

All data files are expected to be in the directory `../compressed audio files`.

```
# Date,Speaker,Topic,Filename 1[,Filename 2[,...]]
10/09/2019,Name Of Speaker 2,Topic of talk 2,20190910-filename2.mp3,20190910-filename2.pdf
09/09/2019,Name Of Speaker,Topic of talk,20190909.filename.mp3
```

## How To Use
* Populate talks-data.csv
* `./generate-html.py > data/10-data`
* Concatenate the data to the clipboard:
  * Ubuntu: `cat data/* | xclip -sel c`
  * Mac:    `cat data/* | pbcopy`
* Paste into the talks page HTML object.
* Click Publish.

Separately (before or after), upload the audio files to the "Talks holding page" on
Weebly.

Consider archiving the HTML snippets into yearly files.
