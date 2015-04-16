#!/bin/bash

#converts snippets from one program's format to another's

convert_autokey_to_atext() {
# converts autokey files to aText-compatible CSV output
# currently can convert only autokey text files, not autokey scripts
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
