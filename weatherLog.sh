#!/bin/bash

# Check if city name is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <city_name>"
    exit 1
fi

CITY="$1"

# Fetch weather data from wttr.in
WEATHER=$(curl -s "wttr.in/${CITY}?format=%C+%t+%h")

# Parse data
DESCRIPTION=$(echo "$WEATHER" | awk '{print $1}')
TEMP=$(echo "$WEATHER" | awk '{print $2}')
HUMIDITY=$(echo "$WEATHER" | awk '{print $3}')

# Validate response
if [ -z "$TEMP" ] || [ -z "$HUMIDITY" ]; then
    echo "Error: Could not fetch weather data for '$CITY'."
    exit 1
fi

# Get local timestamp
LOCAL_TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

# Insert into SQLite database
sqlite3 weather.db <<EOF
CREATE TABLE IF NOT EXISTS weather (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    city TEXT,
    temperature TEXT,
    humidity TEXT,
    weather_description TEXT,
    timestamp TEXT
);
INSERT INTO weather (city, temperature, humidity, weather_description, timestamp)
VALUES ("$CITY", "$TEMP", "$HUMIDITY", "$DESCRIPTION", "$LOCAL_TIMESTAMP");
EOF

echo "Weather data for '$CITY' logged successfully at $LOCAL_TIMESTAMP."
