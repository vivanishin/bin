#!/bin/bash

die()
{
    [ $# -gt 0 ] && echo >&2 "$@"
    exit 1
}

pdf=$1
stem=${2:-$(basename -s .pdf $pdf)}
mkdir -p "decomposed-${stem}" || die
stem="decomposed-${stem}/${stem}"

npages=$(pdfinfo "$pdf" | grep Pages: | awk '{print $2}')

for i in $(seq "$npages")
do
    pdf_page="$stem"-$(printf "%02d" $i).pdf
    png_page="$stem"-$(printf "%02d" $i).png

    pdftk "$pdf" cat "$i" output "$pdf_page"
    magick convert "$pdf_page" "$png_page"
done
