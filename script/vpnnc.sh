#!/bin/sh
if docker ps -q -f name=$1 | grep -q '\w'; then
    exec docker exec -i $1 nc -q0 $2 $3  2>/dev/null
    exit 0;
fi
exec nc  $2 $3  

