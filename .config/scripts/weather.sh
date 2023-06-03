#!/usr/bin/env bash

## Data dir
cache_dir="$HOME/.cache"
cache_file="$cache_dir/weatherdata"

## Weather data | openweatherdata file first line key second line id
KEY=$(awk 'NR == 1' ~/.config/scripts/openweatherdata)
ID=$(awk 'NR == 2' ~/.config/scripts/openweatherdata)
UNIT="imperial" # Available options : 'metric' or 'imperial'

## Make cache dir
if [[ ! -d "$cache_dir" ]]; then
	mkdir -p "${cache_dir}"
fi

## Get data
get_weather_data() {
	weather=$(curl -sf "http://api.openweathermap.org/data/2.5/weather?APPID=$KEY&id=$ID&units=$UNIT")
	echo "$weather" > "${cache_file}"
}

# Pulling info from file
w_temp=$(cat "$cache_file" | jq ".main.temp" | cut -d "." -f 1)
w_ftemp=$(cat "$cache_file" | jq ".main.feels_like" | cut -d "." -f 1)
w_stat=$(cat "$cache_file" | jq -r ".weather[].description" | head -1 | sed -e "s/\b\(.\)/\u\1/g")
w_city=$(cat "$cache_file" | jq -r ".name" | head -1)
w_humid=$(cat "$cache_file" | jq -r ".main.humidity" | cut -d "." -f 1)
w_wind=$(cat "$cache_file" | jq -r ".wind" | cut -d ":" -f 2 -s | head -1 | sed 's/.$//')


# Setting icon and hex values
set_icon() {
  weather_icon_code=$(echo "$weather" | jq -r ".weather[].icon" | head -1)

  #Big long if statement of doom
  if [ "$weather_icon_code" == "50d" ] || [ "$weather_icon_code" == "50n" ]; then
    weather_icon=" "
    weather_hex="#8be9fd"
  elif [ "$weather_icon_code" == "01d" ]; then
    weather_icon=" "
    weather_hex="#ffb86c"
  elif [ "$weather_icon_code" == "01n" ]; then
    weather_icon=" "
    weather_hex="#ff79c6"
  elif [ "$weather_icon_code" == "02d" ]; then
    weather_icon=" "
    weather_hex="#bd93f9"
  elif [ "$weather_icon_code" == "02n" ]; then
    weather_icon=" "
    weather_hex="#bd93f9"
  elif [ "$weather_icon_code" == "03d" ] || [ "$weather_icon_code" == "03n" ] || [ "$weather_icon_code" == "04d" ] || [ "$weather_icon_code" == "04n" ]; then
    weather_icon=" "
    weather_hex="#bd93f9"
  elif [ "$weather_icon_code" == "09d" ] || [ "$weather_icon_code" == "09n" ] || [ "$weather_icon_code" == "10d" ] || [ "$weather_icon_code" == "10n" ]; then
    weather_icon=" "
    weather_hex="#6272a4"
  elif [ "$weather_icon_code" == "11d" ] || [ "$weather_icon_code" == "11n" ]; then
    weather_icon=""
    weather_hex="#f1fa8c"
  elif [ "$weather_icon_code" == "13d" ] || [ "$weather_icon_code" == "10d" ]; then
    weather_icon=" "
    weather_hex="#f8f8f2"
  elif [ "$weather_icon_code" == "40d" ] || [ "$weather_icon_code" == "40n" ]; then
    weather_icon=" "
    weather_hex="#8be9fd"
  else
    weather_icon=" "
    weather_hex="#bd93f9"
  fi
}

case $1 in
  --getdata)
    get_weather_data
    ;;
  --icon)
    set_icon
    echo $weather_icon
    ;;
  --hex)
    set_icon
    echo $weather_hex
    ;;
  --temp)
    echo $w_temp
    ;;
  --feel)
    echo $w_ftemp
    ;;
  --stat)
    echo $w_stat
    ;;
  --city)
    echo $w_city
    ;;
  --humid)
    echo $w_humid
    ;;
  --wind)
    echo $w_wind
    ;;
  --waybar)
    set_icon
    printf "{\"text\":\"<span foreground=\\\\\"%s\\\\\">%s</span>%s\", \"alt\":\"%s\", \"tooltip\":\"Real feel: %s\"}\n" "$(echo "$weather_hex")" "$(echo "$weather_icon")" "$(echo "$w_temp")" "$(echo "$w_stat")" "$(echo "$w_ftemp")"
    ;;
esac

    
