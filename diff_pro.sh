#!/bin/bash

#⠀⠀⠀⢠⣾⣷⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
#⠀⠀⣰⣿⣿⣿⣿⣷⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
#⠀⢰⣿⣿⣿⣿⣿⣿⣷⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
#⢀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
#⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣤⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
#⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣤⣄⣀⣀⣤⣤⣶⣾⣿⣿⣿⡷
#⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠁
#⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠁⠀
#⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠏⠀⠀⠀
#⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠏⠀⠀⠀⠀
#⣿⣿⣿⡇⠀⡾⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠁⠀⠀⠀⠀⠀
#⣿⣿⣿⣧⡀⠁⣀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀
#⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠉⢹⠉⠙⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀
#⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣀⠀⣀⣼⣿⣿⣿⣿⡟⠀⠀⠀⠀⠀⠀⠀
#⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠋⠀⠀⠀⠀⠀⠀⠀⠀
#⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠛⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀
#⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠛⠀⠤⢀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀
#⣿⣿⣿⣿⠿⣿⣿⣿⣿⣿⣿⣿⠿⠋⢃⠈⠢⡁⠒⠄⡀⠈⠁⠀⠀⠀⠀⠀⠀⠀
#⣿⣿⠟⠁⠀⠀⠈⠉⠉⠁⠀⠀⠀⠀⠈⠆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
#⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
################################################################################
#                                                                              #
#                               By: Thanura Rukshan                            #
#                             Name: Diff two files                             #
#                                                                              #
################################################################################

# Variables
DIR1="/add/the/path/to/directory"
DIR2="/add/the/path/to/directory"
REPORT_DIR="/add/the/path/to/report" 
REPORT_FILE="$REPORT_DIR/comparison_report.txt"

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' 

if [[ ! -d "$DIR1" || ! -d "$DIR2" ]]; then
  echo -e "${RED}Both arguments must be valid directories.${NC}"
  exit 1
fi

mkdir -p "$REPORT_DIR"

echo "Comparison Report - $(date)" > "$REPORT_FILE"
echo "Directory 1: $DIR1" >> "$REPORT_FILE"
echo "Directory 2: $DIR2" >> "$REPORT_FILE"
echo "======================================" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

compare_files() {
  local file1="$1"
  local file2="$2"

  echo -e "${BLUE}Comparing file: $file1 with $file2${NC}"
  echo "Comparing file: $file1 with $file2" >> "$REPORT_FILE"

  if [[ -L "$file1" ]]; then
    file1=$(readlink -f "$file1")
  fi
  if [[ -L "$file2" ]]; then
    file2=$(readlink -f "$file2")
  fi

  perm1=$(stat -c "%a" "$file1")
  perm2=$(stat -c "%a" "$file2")
  if [[ "$perm1" != "$perm2" ]]; then
    echo -e "${RED}Permissions differ: $perm1 vs $perm2${NC}"
    echo "Permissions differ: $perm1 vs $perm2" >> "$REPORT_FILE"
  fi

  owner1=$(stat -c "%U:%G" "$file1")
  owner2=$(stat -c "%U:%G" "$file2")
  if [[ "$owner1" != "$owner2" ]]; then
    echo -e "${RED}Ownership differs: $owner1 vs $owner2${NC}"
    echo "Ownership differs: $owner1 vs $owner2" >> "$REPORT_FILE"
  fi

  diff -y --suppress-common-lines --ignore-space-change "$file1" "$file2" > /tmp/diff_output
  if [[ -s /tmp/diff_output ]]; then
    echo -e "${RED}Content differs${NC}"
    echo "Content differs:" >> "$REPORT_FILE"
    echo "--------------------------------------" >> "$REPORT_FILE"
    cat /tmp/diff_output >> "$REPORT_FILE" 
    echo "--------------------------------------" >> "$REPORT_FILE"
  else
    echo -e "${GREEN}Content is identical${NC}"
    echo "Content is identical" >> "$REPORT_FILE"
  fi
  echo "" >> "$REPORT_FILE"
}

walk_directories() {
  local dir1="$1"
  local dir2="$2"

  find "$dir1" -type f | while read -r file; do
    rel_path="${file#$dir1/}"
    file2="$dir2/$rel_path"

    if [[ -f "$file2" || -L "$file2" ]]; then 
      compare_files "$file" "$file2"
    else
      echo -e "${RED}File missing in $DIR2: $rel_path${NC}"
      echo "File missing in $DIR2: $rel_path" >> "$REPORT_FILE"
    fi
  done

  find "$dir2" -type f | while read -r file; do
    rel_path="${file#$dir2/}"
    file1="$dir1/$rel_path"

    if [[ ! -f "$file1" && ! -L "$file1" ]]; then  
      echo -e "${RED}File missing in $DIR1: $rel_path${NC}"
      echo "File missing in $DIR1: $rel_path" >> "$REPORT_FILE"
    fi
  done
}

echo -e "${BLUE}Starting directory comparison...${NC}"
walk_directories "$DIR1" "$DIR2"
echo -e "${GREEN}Comparison complete. Report saved at $REPORT_FILE${NC}"

