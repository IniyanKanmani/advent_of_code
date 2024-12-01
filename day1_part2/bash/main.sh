#!/usr/bin/env bash

content=()

while IOF= read -r line
do
    content+=("${line}")
done < input.txt

locations1=()
locations2=()

for line in "${content[@]}"
do
    IOF="   "
    read -ra loc <<< "$line"

    locations1+=("${loc[0]}")
    locations2+=("${loc[1]}")
done

sum=0

for ((i=0; i<"${#locations1[@]}"; i++))
do
    count=0

    for((j=0; j<"${#locations2[@]}"; j++))
    do
        if [[ "${locations1[$i]}" = "${locations2[$j]}" ]]
        then
            (( count++ ))
        fi
    done

    (( sum = sum + (( ${locations1[$i]} * count )) ))
done

echo "$sum" # 22588371
