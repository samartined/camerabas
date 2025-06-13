# Camerabas

A Flutter application for remote control of Motion surveillance system.

## Overview

Camerabas is a mobile application that allows you to remotely control a Motion surveillance system running on a Linux server. The application connects to the server via SSH and provides a user-friendly interface to manage the Motion service.

## Infrastructure

The system consists of:

1. **Linux Server**:
   - Running Motion surveillance software
   - Accessible via SSH
   - Configured with sudo privileges for Motion service control

2. **Mobile Application**:
   - Built with Flutter
   - Connects to the server via SSH
   - Provides interface for Motion service control

## Features

- SSH connection management
- Motion service control (start/stop)
- Connection status verification
- Secure credential storage
- Tailscale connectivity check

## Technical Stack

- **Frontend**: Flutter
- **SSH Client**: ssh2 package
- **State Management**: flutter_bloc
- **Local Storage**: shared_preferences
- **Network**: connectivity_plus

## Prerequisites

- Linux server with Motion installed
- SSH access to the server
- Tailscale network setup
- Flutter development environment

## Getting Started

1. Clone the repository
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Run the application:
   ```bash
   flutter run
   ```

## Configuration

The application requires the following configuration:
- Server hostname/IP
- SSH username
- SSH password or private key
- Motion service commands

## Security

- SSH credentials are stored securely using shared_preferences
- All connections are encrypted via SSH
- No sensitive data is stored in plain text

## Development

This project uses:
- Unit testing with mockito
- BLoC pattern for state management
- Clean architecture principles
