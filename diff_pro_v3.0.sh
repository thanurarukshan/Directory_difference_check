
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

# Default values for flags
CHECK_PERMISSION="n"
CHECK_OWNERSHIP="n"
CHECK_CONTENT="n"
REPORT_FILE="comparison_report.txt"

# Function to display usage
usage() {
  echo "Usage: diff-pro /path/to/dir1/or/file1 /path/to/dir2/or/file2 --report-name <report_name> [-p] [-o] [-c]"
  echo "  -p: Check for permission differences"
  echo "  -o: Check for ownership differences"
  echo "  -c: Check for content differences"
  exit 1
}

# Check if at least 2 arguments are provided
if [[ $# -lt 2 ]]; then
  usage
fi

# Parse command-line arguments
while [[ $# -gt 0 ]]; do
  case "$1" in
    -p) CHECK_PERMISSION="y"; shift ;;
    -o) CHECK_OWNERSHIP="y"; shift ;;
    -c) CHECK_CONTENT="y"; shift ;;
    --report-name)
      if [[ -n "$2" ]]; then
        REPORT_FILE="$2.txt"
        shift 2
      else
        echo "Error: --report-name requires an argument."
        usage
      fi
      ;;
    -*|--*) # Unknown options
      echo "Unknown option: $1"
      usage
      ;;
    *) # Positional arguments for directories/files
      if [[ -z "$DIR1" ]]; then
        DIR1="$1"
      elif [[ -z "$DIR2" ]]; then
        DIR2="$1"
      else
        echo "Too many positional arguments."
        usage
      fi
      shift
      ;;
  esac
done

# Ensure both paths are provided and valid
if [[ -z "$DIR1" || -z "$DIR2" ]]; then
  echo "Both paths must be specified."
  usage
fi

# Determine if paths are directories or files
if [[ -d "$DIR1" && -d "$DIR2" ]]; then
  TYPE="directory"
elif [[ -f "$DIR1" && -f "$DIR2" ]]; then
  TYPE="file"
else
  echo -e "${RED}Both paths must be either directories or files.${NC}"
  exit 1
fi

# Start report
echo "Comparison Report - $(date)" > "$REPORT_FILE"
echo "Path 1: $DIR1" >> "$REPORT_FILE"
echo "Path 2: $DIR2" >> "$REPORT_FILE"
echo "======================================" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# Function to compare files
compare_files() {
  local file1="$1"
  local file2="$2"
  
  echo -e "${BLUE}Comparing file: $file1 with $file2${NC}"
  echo "Comparing file: $file1 with $file2" >> "$REPORT_FILE"

  # Permission check
  if [[ "$CHECK_PERMISSION" == "y" ]]; then
    perm1=$(stat -c "%a" "$file1")
    perm2=$(stat -c "%a" "$file2")
    if [[ "$perm1" != "$perm2" ]]; then
      echo -e "${RED}Permissions differ: $perm1 vs $perm2${NC}"
      echo "Permissions differ: $perm1 vs $perm2" >> "$REPORT_FILE"
    fi
  fi

  # Ownership check
  if [[ "$CHECK_OWNERSHIP" == "y" ]]; then
    owner1=$(stat -c "%U:%G" "$file1")
    owner2=$(stat -c "%U:%G" "$file2")
    if [[ "$owner1" != "$owner2" ]]; then
      echo -e "${RED}Ownership differs: $owner1 vs $owner2${NC}"
      echo "Ownership differs: $owner1 vs $owner2" >> "$REPORT_FILE"
    fi
  fi

  # Content check
  if [[ "$CHECK_CONTENT" == "y" ]]; then
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
  fi
  echo "" >> "$REPORT_FILE"
}

# Function to walk and compare directories
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
