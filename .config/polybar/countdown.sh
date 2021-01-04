#!/usr/bin/env bash

deadline=`date -d "Jan 6 2021" +%s`
today=`date +%s`
days=$(((($deadline - $today)/(3600*24))))
echo "ﮙ " $days "days left";
