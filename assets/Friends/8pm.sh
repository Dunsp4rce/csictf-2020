#!/bin/bash

touch namo.txt
touch temp.txt

echo "nan" > payload.txt

# get nc response
cat payload.txt | nc chall.csivit.com 30425 > namo.txt

# get indexes
index=($(grep -o " [0-9]\{1,2\} " namo.txt))

# get bits of flag
bits=($(grep -o "\".\"" namo.txt))

# match the indexes with the flag and store in file
for(( j=0 ; j<${#index[@]} ; j++ ))
do
	printf -v s "%02d" ${index[$j]} # format index
	echo "$s:${bits[$j]}" >> temp.txt
done

# sort file and get flag
flag=($(sort temp.txt | cut -d '"' -f 2))

# remove files
rm namo.txt
rm temp.txt
rm payload.txt

printf %s "${flag[@]}" $'\n'