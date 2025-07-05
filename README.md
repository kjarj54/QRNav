# QRNav

QRNav is a Flutter application that allows users to scan QR codes and quickly interact with the scanned content. It is designed for ease of use, providing an intuitive interface to scan, view, and act on the contents of QR codes, whether they are URLs, contacts, locations, emails, calendar events, or plain text.

## Features

- **Scan QR Codes**: Instantly scan QR codes using your device's camera.
- **Smart Content Detection**: Automatically detects different types of QR content:
  - URLs (open in browser or within the app)
  - Email addresses (compose email)
  - Phone numbers (call or send SMS)
  - Wi-Fi credentials (display)
  - Locations (open in Google Maps)
  - Contacts (display details)
  - Calendar events (display summary and date)
  - Plain text
- **Quick Actions**: After scanning, interact with actions relevant to the content type (e.g., open links, call numbers, send emails).
- **Modern UI**: Clean interface with Material Design, including overlays and intuitive navigation.
- **Multi-platform support**: Built with Flutter, can run on Android, iOS, web, Windows, and Linux.

## Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- A device or emulator with a camera (for scanning)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/kjarj54/QRNav.git
   cd QRNav
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   - For Android/iOS:
     ```bash
     flutter run
     ```
   - For web:
     ```bash
     flutter run -d chrome
     ```

## Usage

1. Launch the app.
2. On the home screen, tap "Leer QR" to open the QR scanner.
3. Point your camera at a QR code. Once detected, the app will process the code and display its content.
4. Use the available action buttons to interact with the content (open links, call, email, view on map, etc.).

## Project Structure

- `lib/screens` - UI screens (home, scan, content display)
- `lib/services` - Business logic (QR scanning, content processing)
- `lib/models` - Data models (content types, QR parsing)
- `lib/widgets` - Reusable UI components (scanner overlay, action buttons)

## Dependencies

- `flutter`
- `mobile_scanner` - Camera and QR scanning
- `url_launcher` - Open links, dial phones, send emails, etc.

## License

This project is currently unlicensed. Please refer to the repository for future updates.

## Author

- [kjarj54](https://github.com/kjarj54)

---
*This project is in early development. Feedback and contributions are welcome!*
