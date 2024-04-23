#!/bin/bash

# Define log file path
log_file="example.log"

# Function to monitor log file
monitor_log() {
    logger -t "log-monitor" -p user.info "Starting log monitoring..."
    timestamps=()
    error_counts=()
    while true; do
        if [ -f "$log_file" ]; then
            while read -r line; do
                echo "$line" | logger -t "log-monitor" -p user.info  # Log each line as INFO
                timestamp=$(date +%s)
                timestamps+=("$timestamp")
                error_count=$(echo "$line" | tr '[:upper:]' '[:lower:]' | grep -o "error" | wc -l)
                error_counts+=("$error_count")
                # Update plot
                echo "set xlabel 'Time'; set ylabel 'Error Count'; set title 'Real-time Error Count'; plot '${timestamps[*]}' u 1:2 w l" | gnuplot -persist
            done < <(tail -n 0 -f "$log_file")
        else
            logger -t "log-monitor" -p user.error "Error: Log file '$log_file' not found."
            exit 1
        fi
        sleep 0.1
    done
}

# Function to analyze log file
analyze_log() {
    logger -t "log-monitor" -p user.info "Analyzing log file..."
    error_count=$(grep -c "ERROR" "$log_file")
    logger -t "log-monitor" -p user.info "Number of ERROR messages: $error_count"
}

# Function to handle Ctrl+C
cleanup() {
    logger -t "log-monitor" -p user.info "Stopping log monitoring."
    exit 0
}

# Main function
main() {
    trap cleanup SIGINT

    if [ ! -f "$log_file" ]; then
        logger -t "log-monitor" -p user.error "Error: Log file '$log_file' not found."
        exit 1
    fi

    monitor_log &
    monitor_pid=$!

    analyze_log

    wait $monitor_pid
}

# Execute main function
main
