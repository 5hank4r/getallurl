#!/bin/bash

# Prompt for subdomain file name
read -p "Enter the subdomain file name (including .txt extension): " subdomain_file

# Prompt for variable name
read -p "Enter the variable name: " variable_name

output_directory="output"
katana_output="$output_directory/$variable_name.katana.txt"
gau_output="$output_directory/$variable_name.gau.txt"
gospider_output="$output_directory/$variable_name.gospider.txt"
waybackurls_output="$output_directory/$variable_name.waybackurls.txt"
final_output="$output_directory/$variable_name.final.txt"


# Create output directory if it doesn't exist
mkdir -p "$output_directory"

# Run katana command and save output to variable_name.katana.txt
echo -e "\e[1m\e[32mRunning katana...\e[0m"
cat "$subdomain_file" | katana > "$katana_output"
echo -e "\e[1m\e[32mKatana completed. Output saved to $katana_output\e[0m"

# Run gauplus command and save output to variable_name.gau.txt
echo -e "\e[1m\e[32mRunning gau...\e[0m"
cat "$subdomain_file" | gauplus > "$gau_output"
echo -e "\e[1m\e[32mGau completed. Output saved to $gau_output\e[0m"

#Run GoSpider
echo -e "\e[1m\e[32mRunning GoSpider...\e[0m"
gospider -S $subdomain_file -c 10 -d 1 -a | grep -Eo "(http|https)://[a-zA-Z0-9./?=_-]*" > "$gospider_output" 
echo -e "\e[1m\e[32mGoSpider completed. Output saved to $gospider_output\e[0m"

# Run waybackurl command and save output to variable_name.waybackurls.txt
echo -e "\e[1m\e[32mRunning waybackurl...\e[0m"
cat "$subdomain_file" | waybackurls > "$waybackurls_output"
echo -e "\e[1m\e[32mwaybackurl completed. Output saved to $waybackurls_output\e[0m"

# Combine the results into variable_name.final.txt
cat "$katana_output" "$gau_output" "$gospider_output" "$waybackurls_output" > "$final_output"
echo -e "\e[1m\e[32mResults saved to $final_output\e[0m"
