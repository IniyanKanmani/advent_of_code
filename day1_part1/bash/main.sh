#!/usr/bin/env bash

content=()

while IFS= read -r line
do
    content+=("${line}")
done < input.txt

locations1=()
locations2=()

for line in "${content[@]}"
do
    IFS="   "
    read -ra loc <<< "$line"

    locations1+=("${loc[0]}")
    locations2+=("${loc[1]}")
done

function quicksort() {
    local array=("$@")

    if [[ "${#array[@]}" -le 1 ]]
    then
        echo "${array[@]}"
        return
    fi

    local length="${#array[@]}"
    local pivot="${array[$(($length - 1))]}"

    local lesser=()
    local greater=()

    for ((i = 0; i < $length - 1; i++))
    do
        if [[ "${array[i]}" -le "$pivot" ]]
        then
            lesser+=("${array[i]}")
        else
            greater+=("${array[i]}")
        fi
    done

    local sorted_lesser=($(quicksort "${lesser[@]}"))
    local sorted_greater=($(quicksort "${greater[@]}"))

    echo "${sorted_lesser[@]} $pivot ${sorted_greater[@]}"
}

sorted_locations1=($(quicksort "${locations1[@]}"))
sorted_locations2=($(quicksort "${locations2[@]}"))

distance=0

for ((i=0; i<"${#sorted_locations1[@]}"; i++))
do
    loc1=${sorted_locations1[$i]}
    loc2=${sorted_locations2[$i]}

    if [[ loc1 -gt loc2 ]]
    then
        ((distance = distance + $(( $loc1 - $loc2 )) ))
    else
        ((distance = distance - $(( $loc1 - $loc2 )) ))
    fi
done

echo "$distance" # 1590491
