#!/bin/sh

pac=$(checkupdates 2>/dev/null | wc -l)
total=$pac
percentage=$total

if [ "$total" -eq 0 ]; then
  text="📦"
  tooltip="📦 Repository Sync\nNo new packages available"
  class=""
else
  text="$total🎁"
  tooltip="🎁 Repository Sync\n$total Updates available"
  class="critical"
fi

echo "{\"text\": \"$text\", \"tooltip\": \"$tooltip\", \"class\": \"$class\", \"percentage\": \"$percentage\" }"
