#!/bin/bash

#Prompt user for their name
echo -n "Enter your name: "
read user_name

directory_name="submission_reminder_${user_name}"

#Create the main application directory
mkdir -p $directory_name
cd $directory_name || exit

#create necessary subdirectories
mkdir -p app modules assets config

#Create and populate files
cat << EOL > app/reminder.sh
#!/bin/bash

# Source environment variables and helper functions
source ./config/config.env
source ./modules/functions.sh

# Path to the submissions file
submissions_file="./assets/submissions.txt"

# Print remaining time and run the reminder function
echo "Assignment: \$ASSIGNMENT"
echo "Days remaining to submit: \$DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions "\$submissions_file"
EOL
chmod +x app/reminder.sh

cat << EOL > modules/functions.sh
#!/bin/bash

# Function to read submissions file and output students who have not submitted
function check_submissions {
	local submissions_file=\$1
	echo "Checking submissions in \$submissions_file"
	
	 # Skip the header and iterate through the lines
	 while IFS=, read -r student assignment status; do
		# Remove leading and trailing whitespace 
		student=\$(echo "\$student" | xargs)
		assignment=\$(echo "\$assignment" | xargs)
		status=\$(echo "\$status" | xargs)
	 # Check if assignment matches and status is 'not submitted
	 if [[ "\$assignment" == "\$ASSIGNMENT" && "$status" == "not submitted" ]]; then
		echo "Reminder: \$student has not submitted the \$ASSIGNMENT assignment!"
	fi									    
done < <(tail -n +2 "\$submissions_file") # Skip the header
}
EOL
chmod +x modules/functions.sh
	
cat <<EOL > assets/submissions.txt
Student,Assignment,Submission Status
Chinemerem,Shell Navigation,not submitted
Chiagoziem,Git,submitted
Divine,Shell Navigation,not submitted
Anissa,Shell Basics,submitted
Silver,Shell navigation,not submitted
Clark,Git,submitted
Liam,Shell Basics,submitted
Messi,Git,not submitted
Joe,Shell Basics,submitted
EOL

# Create and populate the configuration file last
cat <<EOL > config/config.env
# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
EOL

# Create and fill startup.sh
cat <<EOL > startup.sh
#!/bin/bash
bash app/reminder.sh
EOL
chmod +x startup.sh

# Confirmation Message
echo "Environment configured successfully"


