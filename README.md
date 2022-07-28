# server-automation-scripts
Server Automation Scripts to quickly install apps in Debian & Ubuntu

This application can be executed in 2 ways. One way is running the script in your command-line, or as a start-up script, with arguments.

**The following scripts (and their number) are currently available:**

0. Initial Setup for Ubuntu 22.04
1. Docker & Docker-Compose
2. Nginx + PHP 8.0 FPM
3. MariaDB

If you want the server to restart after installation, you can add **999** to the list of actions.

To run multiple scripts, just enter a comma-separated list of numbers, eg.: **0,1,999**

## How to run Quick Install Script

*!!! ROOT IS REQUIRED TO RUN THIS SCRIPT !!!*
___

### **Interactive Commandline**
To run the interactive script, enter the following 

```
$ curl -fsSL https://raw.githubusercontent.com/systemedz/server-automation-scripts/develop/quickinstall_ubuntu2204.sh -o install.sh

$ sudo chmod +x install.sh

$ sudo ./install.sh
```
___
### **Non-interactive Commandline with arguments**
You can also run the script without any interaction by adding the scripts to run as arguments, like this:

```
$ curl -fsSL https://raw.githubusercontent.com/systemedz/server-automation-scripts/develop/quickinstall_ubuntu2204.sh -o install.sh

$ sudo chmod +x install.sh

$ sudo ./install.sh 0,1,999
```
___
___
### **DigitalOcean User Data**
This script was intentionally made with the purpose of quickly installing servers on DigitalOcean via their User Data option, when creating a droplet. In this case, you can enter this:

```
#!/bin/bash

curl -fsSL https://raw.githubusercontent.com/systemedz/server-automation-scripts/develop/quickinstall_ubuntu2204.sh \
    -o /tmp/install.sh \
    && chmod +x /tmp/install.sh \
    && ./tmp/install.sh 0,1,999
```
___