FleetWise

FleetWise is a Flutter-based mobile application designed for fleet management, providing tools for user authentication, file uploads, and real-time profit/loss (PnL) tracking. The app supports both light and dark themes, adapting to the system's theme settings, and uses modern Flutter packages for state management, secure storage, and API integration.

Features
User Authentication: Secure login and registration via phone number with OTP verification.
File Uploads: Upload documents or images to the backend server.
PnL Tracking: Retrieve and cache today's, yesterday's, and monthly profit/loss data with offline support.
Secure Storage: Stores authentication tokens securely using flutter_secure_storage.
State Management: Uses flutter_bloc for robust state management.
Local Data Persistence: Caches PnL data using hive_flutter for offline access.

Getting Started

Prerequisites
Flutter SDK: Version 3.7.0.
Dart SDK: Included with Flutter.
IDE:  VS Code.
Emulator/Device:Pixel 7 Pro API 36(android-x64 emulator) .
Backend Server: The app communicates with a backend server at https://avaronn-backend-development-server.pemy8f8ay9m4p.ap-south-1.cs.amazonlightsail.com/test. 


Implementation Notice:
Home interface features intuitive slider navigation between driver management and financial reporting interfaces
Theme implementation is currently in progressive deployment across application modules
Source code repository available at: https://github.com/AkashMadhuNp/fleetwiseassignment

Available on:https://github.com/AkashMadhuNp/fleetwiseassignment

