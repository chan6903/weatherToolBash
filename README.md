# Weather Data Logger

A simple Bash-based weather logging tool that fetches weather data using `wttr.in`, stores it in an SQLite database, and supports automated logging via cron jobs.

## Features
- Fetches weather data without requiring an API key.
- Stores temperature, humidity, and weather conditions in SQLite.
- Uses local system time for logging.
- Can be scheduled to run automatically using cron.

## Prerequisites
Ensure you have the following installed:

- **SQLite3**: Install it via:
  ```bash
  sudo apt install sqlite3  # Debian/Ubuntu
  sudo dnf install sqlite   # Fedora
  brew install sqlite3      # macOS
  ```
- **cURL**: Install it via:
  ```bash
  sudo apt install curl  # Debian/Ubuntu
  sudo dnf install curl  # Fedora
  brew install curl      # macOS
  ```
- **jq** (for JSON parsing, if needed in future modifications):
  ```bash
  sudo apt install jq  # Debian/Ubuntu
  sudo dnf install jq  # Fedora
  brew install jq      # macOS
  ```

## Installation
1. Clone or download this repository.
2. Navigate to the project folder:
   ```bash
   cd weatherToolBash
   ```
3. Ensure the script has execution permissions:
   ```bash
   chmod +x weatherLog.sh
   ```

## Setup Database
Run the following command to create the SQLite database and table:
```bash
sqlite3 weather.db <<EOF
CREATE TABLE IF NOT EXISTS weather (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    city TEXT,
    temperature TEXT,
    humidity TEXT,
    weather_description TEXT,
    timestamp TEXT
);
EOF
```

## Usage
To log weather data for a specific city:
```bash
./weatherLog.sh "City_Name"
```
Example:
```bash
./weatherLog.sh "Delhi"
```
This will fetch weather data and store it in `weather.db`.

## Viewing Logged Data
To check stored weather data:
```bash
sqlite3 weather.db "SELECT * FROM weather;"
```

## Automate Logging with Cron (Optional)
To run the script every hour, add the following to your crontab:
```bash
crontab -e
```
Then, add this line at the bottom:
```bash
0 * * * * /path/to/weatherLog.sh "Delhi" >> /path/to/weather_log.log 2>&1
```
(Change `/path/to/` to the actual path of the script.)

## Using UTC Instead of Local Time
Currently, the script logs timestamps in **local system time**. To switch to **UTC**, modify the timestamp line in `weatherLog.sh`:
```bash
LOCAL_TIMESTAMP=$(date -u "+%Y-%m-%d %H:%M:%S")
```
This ensures all logged times are in Coordinated Universal Time (UTC).

## Developer
This project is open-source and fun project. Feel free to reach me @chandan6903@proton.me

---
