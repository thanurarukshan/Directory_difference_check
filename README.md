# Directory Comparison Script

This shell script compares the contents, permissions, and ownership of files between two directories. It generates a detailed comparison report, highlighting any differences in file content, permissions, ownership, and missing files. If symbolic links are present, the script follows these links and compares the target files.

## Features

- **File Content Comparison**: Compares the contents of files in both directories and displays differences side by side.
- **Permission and Ownership Check**: Reports any differences in file permissions and ownership between matching files.
- **Missing File Detection**: Identifies files present in one directory but missing in the other.
- **Symbolic Link Resolution**: Follows symbolic links in both directories and compares the target files.
- **Formatted CLI Output**: Uses colors to make output easy to interpret.
- **Report Generation**: Saves all comparison results to a report file for easy review.

## Prerequisites

Ensure that both directories exist and are accessible. Update the script variables (`DIR1`, `DIR2`, `REPORT_DIR`) to specify the directories you wish to compare.

## Usage

1. **Set up the directories**: Update the script variables:
   ```bash
   DIR1="/path/to/first/directory"
   DIR2="/path/to/second/directory"
   REPORT_DIR="/path/to/report/directory"