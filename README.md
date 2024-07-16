# WHM/cPanel Installation Script

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Platform](https://img.shields.io/badge/platform-Linux-orange.svg)
![cPanel](https://img.shields.io/badge/cPanel-supported-brightgreen.svg)

## Overview

This repository contains a shell script to automate the installation of WHM/cPanel on CentOS, CloudLinux, or RHEL servers. The script ensures that all necessary packages are installed, and services are properly configured to get WHM/cPanel up and running quickly and efficiently.

## Features

- Installs EPEL release
- Installs necessary packages (`screen`, `wget`, `perl`)
- Stops and disables NetworkManager service
- Updates the system
- Sets server hostname
- Downloads and installs WHM/cPanel
- Configures basic WHM settings
- Creates a cPanel user
- Configures firewall settings
- Restarts cPanel service

## Prerequisites

- A fresh CentOS, CloudLinux, or RHEL server
- Root access to the server

## Installation

To run the WHM/cPanel installation script, use the following command:

```sh
bash -c "$(curl -fsSL https://raw.githubusercontent.com/mahfuzreham/CpanelInstallbasic/main/setup_cpanel.sh)"
