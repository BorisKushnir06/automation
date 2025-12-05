##  Scripts Description

### 1. `backup.sh` (Directory Backup)

This script creates a compressed archive (`.tar.gz`) of an important source directory and saves it to a specified destination.

* **Function:** Creates a timestamped, compressed backup archive.
* **Usage:** `./backup.sh <source_directory> [destination_directory]`
* **Default Behavior:** If the destination is not provided, it defaults to the `/backup` directory.
* **Validation:** Checks if the source directory exists and attempts to create the destination directory if missing.

### 2. `cleanup.sh` (Temporary File Cleanup)

This script automatically searches a directory (and its subdirectories) for files matching specified extensions and deletes them.

* **Function:** Cleans up temporary, log, or backup files in a given location.
* **Usage:** `./cleanup.sh <directory_path> [extension1 extension2 ...]`
* **Default Behavior:** If no extensions are specified, it defaults to deleting files with the **`.tmp`** extension.
* **Output:** Reports the total number of files deleted upon completion.
* **Validation:** Checks if the cleanup directory exists.

### 3. `disk_usage.sh` (Disk Usage Monitoring)

This script monitors the storage consumption of a directory against a predefined maximum volume and alerts the administrator if a usage threshold is exceeded.

* **Function:** Monitors directory size and triggers an alert based on percentage usage.
* **Obligatory Arguments:** The directory path and the maximum reserved volume in **Megabytes (MB)**.
* **Optional Argument:** The threshold percentage (defaults to **80%**).
* **Logging:** Outputs the current usage percentage to the **`disk_usage.log`** file.
* **Alerts:** Sends a notification to a specified email address if the usage is at or above the threshold.

---

##  How to Use

Before running any script, ensure it has executable permissions:

```bash
chmod +x lab01/*.sh