#!/bin/bash
# Original from https://github.com/DashieTM/dotFiles/blob/main/eww_laptop/scripts/weather

## Collect data
cache_dir="$HOME/.cache/eww/weather"
cache_weather_stat=${cache_dir}/weather-stat
cache_weather_degree=${cache_dir}/weather-degree
cache_weather_hex=${cache_dir}/weather-hex
cache_weather_icon=${cache_dir}/weather-icon
cache_weather_city=${cache_dir}/weather-city
cache_weather_feelslike=${cache_dir}/weather-fdegree

## Weather data | openweatherdata file first line KEY second line ID
KEY=$(awk 'NR == 1' ~/.config/eww/scripts/openweatherdata)
ID=$(awk 'NR == 2' ~/.config/eww/scripts/openweatherdata)
UNIT="imperial" # Available options : 'metric' or 'imperial'

## Make cache dir
if [[ ! -d "$cache_dir" ]]; then
  mkdir -p "${cache_dir}"
fi

## Get data
get_weather_data() {
  weather=$(curl -sf "http://api.openweathermap.org/data/2.5/weather?APPID=$KEY&id=$ID&units=$UNIT")

  if [ -n "$weather" ]; then
    weather_temp=$(echo "$weather" | jq ".main.temp" | cut -d "." -f 1)
    weather_ftemp=$(echo "$weather" | jq ".main.feels_like" | cut -d "." -f 1)
    weather_icon_code=$(echo "$weather" | jq -r ".weather[].icon" | head -1)
    weather_description=$(echo "$weather" | jq -r ".weather[].description" | head -1 | sed -e "s/\b\(.\)/\u\1/g")
    weather_city=$(echo "$weather" | jq -r ".name" | head -1)

    case "$weather_icon_code" in
    "50d" | "50n")
      weather_icon=" "
      weather_hex="#8be9fd"
      ;;
    "01d")
      weather_icon=" "
      weather_hex="#ffb86c"
      ;;
    "01n")
      weather_icon=" "
      weather_hex="#ff79c6"
      ;;
    "02d")
      weather_icon=" "
      weather_hex="#bd93f9"
      ;;
    "02n")
      weather_icon=" "
      weather_hex="#bd93f9"
      ;;
    "03d" | "03n" | "04d" | "04n")
      weather_icon=" "
      weather_hex="#bd93f9"
      ;;
    "09d" | "09n" | "10d" | "10n")
      weather_icon=" "
      weather_hex="#6272a4"
      ;;
    "11d" | "11n")
      weather_icon=""
      weather_hex="#f1fa8c"
      ;;
    "13d")
      weather_icon=" "
      weather_hex="#f8f8f2"
      ;;
    "40d" | "40n")
      weather_icon=" "
      weather_hex="#8be9fd"
      ;;
    *)
      weather_icon=" "
      weather_hex="#bd93f9"
      ;;
    esac
    echo "$weather_icon" >"${cache_weather_icon}"
    echo "$weather_description" >"${cache_weather_stat}"
    echo "$weather_temp""°F" >"${cache_weather_degree}"
    echo "$weather_ftemp""°F" >"${cache_weather_feelslike}"
    echo "$weather_hex" >"${cache_weather_hex}"
    echo "$weather_city" >"${cache_weather_city}"
  fi
}

printf "{\"text\":\"<span foreground=\\\\\"%s\\\\\">%s</span>%s\", \"alt\":\"%s\", \"tooltip\":\"Real feel: %s\"}\n" "$(cat "$cache_weather_hex")" "$(cat "$cache_weather_icon")" "$(cat "$cache_weather_degree")" "$(cat "$cache_weather_stat")" "$(cat "$cache_weather_feelslike")"
