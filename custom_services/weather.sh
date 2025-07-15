#!/usr/bin/env bash


APIKEY=$(< /home/lou/.local/share/openweather/apikey)
fullinfo=$(curl -s "https://api.openweathermap.org/data/2.5/weather/?lat=18.9895249&lon=73.1221935&appid=$APIKEY")


# get weather info
actual_temprature=$(jq -r '(.main.temp - 273)*100|round/100' <<< $fullinfo )
feel_temprature=$(jq -r '(.main.feels_like - 273)*100|round/100' <<< $fullinfo )
description=$(jq -r '.weather[0].description' <<< $fullinfo )
pressure=$(jq -r '.main.pressure' <<< $fullinfo )
humidity=$(jq -r '.main.humidity' <<< $fullinfo )
location="Mumbai, India"

weatherinfo=$(
  jq -n \
  --arg temperature "$actual_temprature" \
  --arg feels_like "$feel_temprature" \
  --arg description "$description" \
  --arg pressure "$pressure" \
  --arg humidity "$humidity" \
  --arg location "$location" \
  '{ temperature: $temperature, feels_like: $feels_like, description: $description, pressure: $pressure, humidity: $humidity, location: $location }'
)


echo "$weatherinfo" > /tmp/weather.json
