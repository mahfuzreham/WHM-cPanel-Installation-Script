#!/bin/bash

# Make sure you are running as root
if [ "$(whoami)" != "root" ]; then
    echo "This script must be run as root!" >&2
    exit 1
fi

# Install EPEL release
echo "Installing EPEL release..."
yum install -y epel-release

# Install necessary packages
echo "Installing screen and wget..."
yum install -y screen wget

# Stop and disable NetworkManager service
echo "Stopping and disabling NetworkManager service..."
systemctl stop NetworkManager.service
systemctl disable NetworkManager.service

# Update the system
echo "Updating the system..."
yum update -y

# Install Perl (required for cPanel)
echo "Installing Perl..."
yum install -y perl

# Prompt for hostname
read -p "Enter the hostname for your server (e.g., your.hostname.com): " SERVER_HOSTNAME

# Set hostname
hostnamectl set-hostname "$SERVER_HOSTNAME"
echo "Hostname set to $SERVER_HOSTNAME"

# Download and install cPanel
echo "Downloading and installing cPanel..."
cd /home
curl -o latest -L https://securedownloads.cpanel.net/latest
sh latest

# Wait for the installation to complete
echo "Waiting for cPanel installation to complete..."
while [ ! -f /usr/local/cpanel/cpanel ]; do
    sleep 10
done

# Configure WHM basic settings
echo "Configuring WHM basic settings..."
/usr/local/cpanel/scripts/setup_wizard < /dev/null

# Set cPanel user and password manually
CPANEL_USER="cpaneluser"
CPANEL_PASSWORD="yourpassword"

# Create cPanel user
echo "Creating cPanel user..."
/scripts/adduser "$CPANEL_USER"
/scripts/setpassword "$CPANEL_USER" "$CPANEL_PASSWORD"

# Open necessary ports in firewall
echo "Configuring firewall..."
firewall-cmd --zone=public --add-port=2087/tcp --permanent
firewall-cmd --zone=public --add-port=2083/tcp --permanent
firewall-cmd --zone=public --add-port=2082/tcp --permanent
firewall-cmd --zone=public --add-port=2086/tcp --permanent
firewall-cmd --reload

# Restart cPanel service
echo "Restarting cPanel service..."
service cpanel restart

# Display installation details
echo "WHM/cPanel installation is complete."
echo "Login to WHM at: https://$SERVER_HOSTNAME:2087"
echo "Use the root user and password to log in."

exit 0
