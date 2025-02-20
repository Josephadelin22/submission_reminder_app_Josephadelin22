# Submission Reminder App

## Description

This project is a simple submission reminder application that helps track and remind students who have not submitted their assignments. The application is built using Bash scripts and includes functionality to create the necessary environment, read submission data, and send reminders.

## Files and Directories

- `create_environment.sh`: Script to create the necessary environment and populate initial files.
- `app/reminder.sh`: Main script to run the reminder functionality.
- `modules/functions.sh`: Contains helper functions used by the main script.
- `config/config.env`: Configuration file containing environment variables.
- `assets/submissions.txt`: Sample submissions file with student data.
- `startup.sh`: Script to start the reminder application.

## Usage

1. **Set up the environment**:
    ```bash
    chmod +x create_environment.sh
    ./create_environment.sh
    ```

2. **Run the reminder application**:
    ```bash
    chmod +x startup.sh
    ./startup.sh
    ```

## Configuration

The `config/config.env` file contains the following environment variables:

- `ASSIGNMENT`: The name of the assignment to check for submissions.
- `DAYS_REMAINING`: The number of days remaining to submit the assignment.

Example:
```bash
export ASSIGNMENT="shell navigation"
export DAYS_REMAINING=2
