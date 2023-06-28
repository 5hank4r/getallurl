#!/bin/bash

# Prompt for subdomain file name
read -p "Enter the subdomain file name (including .txt extension): " subdomain_file

# Prompt for variable name
read -p "Enter the variable name: " variable_name

output_directory="$variable_name"
mkdir -p "$output_directory"

gau_output="$output_directory/$variable_name.gau.txt"
katana_output="$output_directory/$variable_name.katana.txt"
final_output="$output_directory/$variable_name.final.txt"

# Run katana command and save output to variable_name.katana.txt
echo -e "\e[1m\e[32mRunning katana...\e[0m"
cat "$subdomain_file" | katana > "$katana_output"
echo -e "\e[1m\e[32mKatana completed. Output saved to $katana_output\e[0m"

# Run gau command and save output to variable_name.gau.txt
echo -e "\e[1m\e[32mRunning gau...\e[0m"
cat "$subdomain_file" | gau > "$gau_output"
echo -e "\e[1m\e[32mGau completed. Output saved to $gau_output\e[0m"

# Combine the results into variable_name.final.txt
cat "$katana_output" "$gau_output" > "$final_output"

echo -e "\e[1m\e[32mResults saved to $output_directory directory\e[0m"
