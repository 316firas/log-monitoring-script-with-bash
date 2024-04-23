# log-monitoring-script-with-bash
# Log Monitoring Script (Bash)

This Bash script continuously monitors a specified log file for new entries, logs each line as INFO, and generates a real-time error count plot using Gnuplot.

## Features:
- Continuously monitors a specified log file for new entries.
- Logs each line as INFO using the `logger` command.
- Generates a real-time error count plot using Gnuplot.
- Implements a mechanism to stop the monitoring loop using Ctrl+C.

## Prerequisites:
Gnuplot: Ensure Gnuplot is installed on your system. You can install it using your package manager (e.g., apt, yum, brew).
## Dependencies:
No additional dependencies required.
## Stopping the Script:
Press Ctrl+C to stop the monitoring script.

## Usage:
1. Clone the repository:
   ```bash
   git clone https://github.com/316firas/log-monitoring-script-with-bash.git
