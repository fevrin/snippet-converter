#!/bin/bash

#converts autokey files to aText-compatible CSV output

convert_autokey_to_atext() {
# currently can convert only text files, not scripts
   outfile=~/Desktop/do.csv
   for i in ~/.config/autokey/data/do/*txt; do
      dir="$(dirname "$i")";
      name="$(basename "$i")";
      abbrev="$(grep -A1 abbreviations "$dir/.${name/.txt/.json}" | tr -d '\n' | grep -v ']' | tail -n1 | cut -d\" -f4)";
      label="$(grep \"description\" "$dir/.${name/.txt/.json}" | cut -d\" -f4)";
   
      #grab the contents and double up on double-quotes for aText
      data="$(cat "$i" | sed 's;";"";g' )";
      echo "$abbrev",\""$data"\","$label" >>"$outfile";
   done
}

convert_autokey_to_atext
