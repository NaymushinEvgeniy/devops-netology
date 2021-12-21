#!/bin/bash

host1=habr.com
host2=173.194.222.113
host3=87.250.250.242

hosts=("$host1" "$host2" "$host3")
for h in ${hosts[@]}
do
        for (( i=1; i <= 5; i++ ))
        do
                curl $h >> curl.log
                sleep 1
                done
done