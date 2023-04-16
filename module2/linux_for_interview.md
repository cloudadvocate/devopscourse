## Regular expressions in shell

Regular expressions can be very useful in shell scripting to manipulate and search for text data. Here are some examples of how to use regular expressions in shell:

### Matching patterns using the grep command:

```sh
# This will search for all lines containing the word "apple"
grep "apple" fruits.txt

# This will search for all lines starting with "a"
grep "^a" fruits.txt

# This will search for all lines ending with "e"
grep "e$" fruits.txt

# This will search for all lines containing any number
grep "[0-9]" numbers.txt
```
### Substituting patterns using the sed command:

```sh
# This will replace all occurrences of "apple" with "orange"
sed 's/apple/orange/g' fruits.txt

# This will remove all occurrences of the word "the"
sed 's/the//g' text.txt

# This will replace all occurrences of the word "dog" with "cat" only on lines starting with "a"
sed '/^a/s/dog/cat/g' animals.txt
```
### Using regular expressions in conditional statements:
```sh
# This will check if a variable matches a regular expression
if [[ $var =~ ^[0-9]+$ ]]; then
    echo "Variable is a number"
fi
```
## How do you handle errors in a shell script?
Handling errors is an important part of shell scripting, as it can help you identify and resolve issues in your script. Here are some ways to handle errors in a shell script:

Checking the exit status of commands: Every command in a shell script returns an exit status, which indicates whether the command succeeded or failed. You can use the $? variable to check the exit status of the previous command and take appropriate action based on that. For example:

```bash
# Check if the command succeeded
command
if [ $? -eq 0 ]; then
    echo "Command succeeded"
else
    echo "Command failed"
fi
```

## What is a pipeline in a shell script, and how do you use it?

In shell scripting, a pipeline is a mechanism that allows you to chain multiple commands together so that the output of one command is used as the input of the next command. A pipeline is represented by the | symbol in a shell script.

Here's an example of how a pipeline works:
```sh
command1 | command2 | command3
```

In this example, the output of command1 is piped into command2, and the output of command2 is piped into command3. Each command in the pipeline is executed sequentially, with the output of the previous command being passed as input to the next command.

Pipelines are a powerful mechanism for shell scripting, as they allow you to combine simple commands to perform complex tasks. For example, you could use a pipeline to find all files in a directory that contain a specific text string:

```sh
grep -l "search string" * | xargs rm
```
In this example, grep -l "search string" * finds all files in the current directory that contain the text string "search string". The output of this command is then piped into xargs rm, which deletes each of the matching files.

## What is awk and some examples of awk
The awk command is used for text processing in Linux. Although, the sed command is also used for text processing, but it has some limitations, so the awk command becomes a handy option for text processing. It provides powerful control to the data. The Awk is a powerful scripting language used for text scripting.

#### Print the first column of a CSV file:
```sh
awk -F ',' '{print $1}' file.csv
```
#### Count the number of lines in a file:
```sh
awk 'END{print NR}' file.txt
```
#### Calculate the average value of the third column in a CSV file:
```sh
awk -F ',' '{sum+=$3; count++} END {print sum/count}' file.csv
```
#### Print the length of each line in a file:
```sh
awk '{print length}' file.txt
```
#### Convert a file from Windows to Unix format:
```sh
awk '{sub(/\r$/,""); print}' file.txt > newfile.txt
```
## How to use find command in Linux?
The find command in Linux is a powerful tool for searching and locating files and directories based on various criteria, such as name, type, size, and timestamp. Here are some sample commands using find:

#### Find all files in the current directory with the .txt extension:
```sh
find . -type f -name "*.txt"
```
#### Find all directories in the current directory that are named logs:
```sh
find . -type d -name "logs"
```
#### Find all files in the current directory that are larger than 10MB:
```sh
find . -type f -size +10M
```
#### Find all files in the current directory that were modified in the last 7 days:
```sh
find . -type f -mtime -7
```
#### Find all empty files in the current directory:
```sh
find . -type f -empty
```
#### Find all files in the current directory that are owned by the user john:
```sh
find . -type f -user john
```

