#!/bin/bash
################################################################################
#       _______  __   __  _______  __    _  __   __  ______    _______         #
#      |       ||  | |  ||   _   ||  |  | ||  | |  ||    _ |  |   _   |        #
#      |_     _||  |_|  ||  |_|  ||   |_| ||  | |  ||   | ||  |  |_|  |        #
#        |   |  |       ||       ||       ||  |_|  ||   |_||_ |       |        #
#        |   |  |       ||       ||  _    ||       ||    __  ||       |        #
#        |   |  |   _   ||   _   || | |   ||       ||   |  | ||   _   |        # 
#        |___|  |__| |__||__| |__||_|  |__||_______||___|  |_||__| |__|⠀⠀⠀⠀⠀⠀ #⠀
#⠀⠀⠀⠀⠀                                                                        #
################################################################################
#                                                                              #
#                               By: Thanura Rukshan                            #
#                             Name: Diff two files                             #
#                                                                              #
################################################################################

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

# Prompt for directories or files
read -p "Enter path for directory or file 1: " DIR1
read -p "Enter path for directory or file 2: " DIR2

# Prompt for report filename
read -p "Enter the report filename (without extension): " FILENAME
REPORT_FILE="$(pwd)/${FILENAME}.txt"  # Save report in the current working directory with .txt extension

# Check if paths are directories or files
if [[ -d "$DIR1" && -d "$DIR2" ]]; then
  TYPE="directory"
elif [[ -f "$DIR1" && -f "$DIR2" ]]; then
  TYPE="file"
else
  echo -e "${RED}Both paths must be either directories or files.${NC}"
  exit 1
fi

# Prompt for configurations
read -p "Check for permission differences? (y/n): " CHECK_PERMISSION
read -p "Check for ownership differences? (y/n): " CHECK_OWNERSHIP
read -p "Check content? (y/n): " CHECK_CONTENT

# Start report
...skipping...

  find "$dir2" -type f | while read -r file; do
    rel_path="${file#$dir2/}"
    file1="$dir1/$rel_path"

    if [[ ! -f "$file1" && ! -L "$file1" ]]; then  
      echo -e "${RED}File missing in $DIR1: $rel_path${NC}"
      echo "File missing in $DIR1: $rel_path" >> "$REPORT_FILE"
    fi
  done
}

# Main script logic
echo -e "${BLUE}Starting comparison...${NC}"

if [[ "$TYPE" == "directory" ]]; then
  if [[ "$CHECK_CONTENT" == "y" ]]; then
    walk_directories "$DIR1" "$DIR2"
  else
    # Only compare directory structure, permissions, and ownership if content check is "n"
    find "$DIR1" -type f | while read -r file; do
      rel_path="${file#$DIR1/}"
      file2="$DIR2/$rel_path"
      [[ -f "$file2" || -L "$file2" ]] && compare_files "$file" "$file2"
    done
  fi
elif [[ "$TYPE" == "file" ]]; then
  compare_files "$DIR1" "$DIR2"
fi

echo -e "${GREEN}Comparison complete. Report saved at $REPORT_FILE${NC}"
