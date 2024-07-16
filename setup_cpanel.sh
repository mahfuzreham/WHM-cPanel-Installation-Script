#!/bin/bash

# Clone the repository
git clone https://github.com/mahfuzreham/CpanelInstallbasic

# Navigate to the repository directory
cd CpanelInstallbasic

# Make the install script executable
chmod +x install_whm.sh

# Run the install script with root privileges
sudo ./install_whm.sh
