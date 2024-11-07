
# diff_pro

## Overview

This project includes shell scripts for comparing the contents, permissions, and ownership of files between two directories or files. It generates a detailed comparison report, highlighting any differences in file content, permissions, ownership, and missing files. If symbolic links are present, the scripts follow these links and compare the target files.

## Versions

### diff_pro.sh

This original script compares directories and generates a comparison report, displaying differences in file content, permissions, ownership, and missing files.

### diff_pro_v2.0.sh

An improved version of the original script, adding configurable options through runtime prompts to allow users to select specific checks (permissions, ownership, content).

### diff_pro_v3.0.sh [Under Maintenance]

The latest version, `diff-pro`, adds advanced functionality, allowing users to run the script directly from the command line with flags for ease of use.

## Features

- **File Content Comparison**: Compares the contents of files and displays differences side by side.
- **Permission and Ownership Check**: Checks for differences in file permissions and ownership between matching files.
- **Configurable Options**:
  - `diff_pro_v2.0.sh` uses runtime prompts for selection.
  - `diff-pro` allows configuration with command-line flags.
- **Missing File Detection**: Identifies files present in one directory but missing in the other.
- **Symbolic Link Resolution**: Follows symbolic links in both directories and compares the target files.
- **Formatted CLI Output**: Uses colors to make output easy to interpret.
- **Report Generation**: Saves all comparison results to a customizable report file.

## Prerequisites

Ensure that both paths (files or directories) exist and are accessible.

## Steps to Use

### Make the Script Executable

Run the following command to make `diff-pro` executable:

```bash
chmod +x diff-pro
```

### Move to PATH (Optional)

For easier access, you can move the script to a directory in your PATH, allowing it to be run from anywhere. For example:

```bash
sudo mv diff-pro-extended /usr/local/bin/diff-pro
```

Once moved, you can run the script simply by typing `diff-pro` from any terminal.

## Usage

### Running the Script

To compare directories or files, use the following syntax:

```bash
diff-pro /path/to/dir/or/file /path/to/dir2/or/file2 --report-name "report_name" -p -o -c
```

#### Flags

- `-p`: Check for permission differences.
- `-o`: Check for ownership differences.
- `-c`: Check for content differences.
- `--report-name`: Specifies the name of the report file (e.g., "report" will save the report as report.txt).

### Example Usage

```bash
diff-pro /path/to/first/dir /path/to/second/dir --report-name "my_comparison" -p -o -c
```

This command compares the contents, permissions, and ownership of files in both directories and saves the report as `my_comparison.txt`.

You can also use the script for comparing individual files:

```bash
diff-pro /path/to/file1.txt /path/to/file2.txt --report-name "file_comparison" -p -o -c
```

This will compare the files and save the report as `file_comparison.txt`.

### Remote Comparison (Extended Functionality) - Under Construction !

In version `diff-pro-extended`, the script supports remote comparisons over SSH. The following command compares files or directories located on different servers:

```bash
diff-pro 192.168.0.1:/path/to/file1.txt 192.168.0.2:/path/to/file2.txt --report-name "remote_comparison" --user1 "username" --user2 "username" --pw1 "password1" --pw2 "password2" -p -o -c
```

This command compares two files on different remote servers using SSH, checking for permission, ownership, and content differences. The result is saved in `remote_comparison.txt`.

#### Remote File Comparison Requirements:

- **`--user1` and `--user2`**: SSH usernames for the first and second remote servers, respectively.
- **`--pw1` and `--pw2`**: SSH passwords for the first and second remote servers.

### Legacy Usage

For `diff_pro.sh` and `diff_pro_v2.0.sh`, you can manually set the directories and options inside the script or follow the prompts when running.

#### Example Usage for `diff_pro_v2.0.sh`

To run `diff_pro_v2.0.sh` with prompts:

```bash
sh diff_pro_v2.0.sh
```

The script will prompt you to enter paths, report filename, and configuration options.

Copyright © 2024 | All Rights Reserved
