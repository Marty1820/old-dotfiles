#!/usr/bin/env sh

## Data dir
cache_dir="$HOME/.cache"
cache_file="$cache_dir/weatherdata"

## Weather data | openweatherdata file first line key second line id
KEY=$(awk 'NR == 1' ~/.config/scripts/openweatherdata)
ID=$(awk 'NR == 2' ~/.config/scripts/openweatherdata)
UNIT="imperial" # Available options : 'metric' or 'imperial'

## Make cache dir
if [ ! -d "$cache_dir" ]; then
	mkdir -p "${cache_dir}"
fi

## Get data
get_weather_data() {
	weather=$(curl -sf "http://api.openweathermap.org/data/2.5/weather?APPID=$KEY&id=$ID&units=$UNIT")
	echo "$weather" > "${cache_file}"
}

# Pulling info from file
w_temp=$(jq ".main.temp" < "$cache_file" | cut -d "." -f 1)
w_ftemp=$(jq ".main.feels_like"  < "$cache_file" | cut -d "." -f 1)
w_stat=$(jq -r ".weather[].description"  < "$cache_file" | head -1 | sed -e "s/\b\(.\)/\u\1/g")
w_city=$(jq -r ".name"  < "$cache_file" | head -1)
w_humid=$(jq -r ".main.humidity"  < "$cache_file" | cut -d "." -f 1)
w_wind=$(jq -r ".wind" < "$cache_file" | cut -d ":" -f 2 -s | head -1 | sed 's/.$//')


# Setting icon and hex values
set_icon() {
  w_icon_code=$(jq -r ".weather[].icon" < "$cache_file" | head -1)

  #Big long if statement of doom
  if [ "$w_icon_code" = "01d" ]; then
    w_icon="󰖙"
    w_hex="#ffb86c"
  elif [ "$w_icon_code" = "01n" ]; then
    w_icon="󰖔"
    w_hex="#bd93f9"
  elif [ "$w_icon_code" = "02d" ]; then
    w_icon="󰖕"
    w_hex="#f1fa8c"
  elif [ "$w_icon_code" = "02n" ]; then
    w_icon="󰼱"
    w_hex="#6272a4"
  elif [ "$w_icon_code" = "03d" ] || [ "$w_icon_code" = "03n" ] || [ "$w_icon_code" = "04d" ] || [ "$w_icon_code" = "04n" ]; then
    w_icon="󰖐"
    w_hex="#bd93f9"
  elif [ "$w_icon_code" = "09d" ] || [ "$w_icon_code" = "09n" ]; then
    w_icon="󰖖"
    w_hex="#8be9fd"
  elif [ "$w_icon_code" = "10d" ] || [ "$w_icon_code" = "10n" ]; then
    w_icon="󰼳"
    w_hex="#8be9fd"
  elif [ "$w_icon_code" = "11d" ]; then
    w_icon="󰼲"
    w_hex="#ffb86c"
  elif [ "$w_icon_code" = "11n" ]; then
    w_icon="󰖓"
    w_hex="#ffb86c"
  elif [ "$w_icon_code" = "13d" ]; then
    w_icon="󰼴"
    w_hex="#8be9fd"
  elif [ "$w_icon_code" = "13n" ]; then
    w_icon="󰼶"
    w_hex="#8be9fd"
  elif [ "$w_icon_code" = "50d" ]; then
    w_icon="󰼰"
    w_hex="#6272a4"
  elif [ "$w_icon_code" = "50n" ]; then
    w_icon="󰖑"
    w_hex="#6272a4"
  else
    w_icon="󰼯"
    w_hex="#ff5555"
  fi
}

case $1 in
  --getdata)
    get_weather_data
    ;;
  --icon)
    set_icon
    echo "$w_icon"
    ;;
  --hex)
    set_icon
    echo "$w_hex"
    ;;
  --temp)
    echo "$w_temp"
    ;;
  --feel)
    echo "$w_ftemp"
    ;;
  --stat)
    echo "$w_stat"
    ;;
  --city)
    echo "$w_city"
    ;;
  --humid)
    echo "$w_humid"
    ;;
  --wind)
    echo "$w_wind"
    ;;
  --waybar)
    set_icon
    printf "{\"text\":\"<span foreground=\\\\\"%s\\\\\">%s</span> %s\", \"alt\":\"%s\", \"tooltip\":\"Real feel: %s\"}\n" "$w_hex" "$w_icon" "$w_temp" "$w_stat" "$w_ftemp"
    ;;
esac

