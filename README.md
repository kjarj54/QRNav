# 📱 QRNav - Intelligent QR Code Scanner

**QRNav** is a powerful and intuitive Flutter application that provides advanced QR code scanning capabilities with intelligent content parsing. Built with modern Material 3 design, QRNav recognizes various QR code formats and handles them intelligently, offering users a seamless experience across all platforms.

## ✨ Key Features

### 📷 Multi-format QR Code Scanning
- **Custom Scanning Overlay** - Professional scanning interface with visual guidance
- **Camera Controls** - Toggle flash/torch and switch between front/rear cameras
- **Real-time Detection** - Instant QR code recognition and processing

### 🧠 Intelligent Content Parsing
QRNav automatically detects and handles various QR code formats:

| Format | Description | Example |
|--------|-------------|---------|
| 🌐 **URLs** | Web links and websites | `https://example.com` |
| 📧 **Email** | Email addresses with mailto protocol | `mailto:user@example.com` |
| 📞 **Phone** | Phone numbers with tel protocol | `tel:+1234567890` |
| 📶 **WiFi** | WiFi network credentials | `WIFI:T:WPA;S:NetworkName;P:password;;` |
| 📍 **Location** | Geographic coordinates | `geo:37.7749,-122.4194` |
| 👤 **Contact** | vCard contact information | `BEGIN:VCARD...END:VCARD` |
| 📅 **Calendar** | vEvent calendar events | `BEGIN:VEVENT...END:VEVENT` |
| 💬 **SMS** | SMS messages with recipients | `sms:+1234567890:Hello World` |
| 📄 **Text** | Plain text content | Any other text content |

### 🎨 Modern Design
- **Material 3** design system with dynamic theming
- **Dynamic Colors** that adapt to system preferences
- **Cross-platform** consistent UI/UX
- **Responsive** layout for different screen sizes

## 🚀 Platform Support

QRNav is built with Flutter and supports all major platforms:

- ✅ **Android** (API 21+)
- ✅ **iOS** (iOS 11.0+)
- ✅ **Windows** (Windows 10+)
- ✅ **Linux** (Ubuntu 18.04+)
- ✅ **Web** (Modern browsers)
- ✅ **macOS** (macOS 10.14+)

## 🛠️ Technology Stack

- **Framework**: Flutter 3.7.0+
- **Language**: Dart
- **QR Scanning**: mobile_scanner 3.5.6
- **URL Handling**: url_launcher 6.2.5
- **Theming**: dynamic_color 1.7.0
- **Design System**: Material 3
- **Architecture**: Clean Architecture with separation of concerns

## 📦 Installation

### Prerequisites
- Flutter SDK 3.7.0 or higher
- Dart SDK (included with Flutter)
- Platform-specific development tools:
  - **Android**: Android Studio with Android SDK
  - **iOS**: Xcode (macOS only)
  - **Windows**: Visual Studio with C++ development tools
  - **Linux**: CMake and ninja-build
  - **Web**: Chrome or other modern browser

### Setup Instructions

1. **Clone the repository**
   ```bash
   git clone https://github.com/kjarj54/QRNav.git
   cd QRNav
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the application**
   ```bash
   # For development (debug mode)
   flutter run
   
   # For specific platform
   flutter run -d android
   flutter run -d ios
   flutter run -d windows
   flutter run -d linux
   flutter run -d chrome
   ```

4. **Build for production**
   ```bash
   # Android APK
   flutter build apk --release
   
   # iOS (requires macOS and Xcode)
   flutter build ios --release
   
   # Windows executable
   flutter build windows --release
   
   # Linux executable
   flutter build linux --release
   
   # Web build
   flutter build web --release
   ```

## 📖 Usage Guide

### Basic Usage
1. **Launch QRNav** on your device
2. **Tap "Leer QR"** on the home screen to start scanning
3. **Point your camera** at a QR code
4. **Wait for automatic detection** - the app will process the content
5. **View results** - QRNav will display parsed information or offer actions

### Supported QR Code Formats

#### 🌐 Web URLs
```
https://www.example.com
http://example.com/path?query=value
```
*Action: Choose to open in browser or view in app*

#### 📧 Email Addresses
```
mailto:contact@example.com
mailto:user@domain.com?subject=Hello&body=Message
```
*Action: Open default email client*

#### 📞 Phone Numbers
```
tel:+1234567890
tel:555-123-4567
```
*Action: Open phone dialer*

#### 📶 WiFi Networks
```
WIFI:T:WPA;S:NetworkName;P:password;H:false;;
WIFI:T:WEP;S:NetworkName;P:password;;
```
*Action: Display network credentials*

#### 📍 Geographic Locations
```
geo:37.7749,-122.4194
geo:40.7128,-74.0060?q=New+York
```
*Action: Open maps application*

#### 👤 Contact Information (vCard)
```
BEGIN:VCARD
VERSION:3.0
FN:John Doe
ORG:Example Corp
TEL:+1234567890
EMAIL:john@example.com
END:VCARD
```
*Action: Display contact details with save option*

#### 📅 Calendar Events (vEvent)
```
BEGIN:VEVENT
SUMMARY:Meeting
DTSTART:20231215T100000Z
DTEND:20231215T110000Z
DESCRIPTION:Important meeting
END:VEVENT
```
*Action: Display event details*

#### 💬 SMS Messages
```
sms:+1234567890:Hello, this is a test message
smsto:555-123-4567:Meeting at 3 PM
```
*Action: Open SMS client with pre-filled message*

## 📁 Project Structure

```
QRNav/
├── android/                 # Android platform files
├── ios/                     # iOS platform files
├── web/                     # Web platform files
├── windows/                 # Windows platform files
├── linux/                   # Linux platform files
├── macos/                   # macOS platform files
├── lib/
│   ├── main.dart           # Application entry point
│   ├── models/             # Data models
│   │   └── qr_content.dart # QR content parsing model
│   ├── screens/            # UI screens
│   │   ├── home_screen.dart
│   │   ├── qr_scan_screen.dart
│   │   └── content_display_screen.dart
│   ├── services/           # Business logic
│   │   └── qr_scanner_service.dart
│   └── widgets/            # Reusable UI components
│       ├── app_button.dart
│       ├── qr_action_buttons.dart
│       └── qr_scanner_overlay.dart
├── pubspec.yaml            # Dependencies and project config
└── README.md              # Project documentation
```

## 🤝 Contributing

We welcome contributions to QRNav! Here's how you can help:

### Getting Started
1. **Fork** the repository
2. **Create** a feature branch: `git checkout -b feature/amazing-feature`
3. **Make** your changes following our coding standards
4. **Test** your changes thoroughly
5. **Commit** your changes: `git commit -m 'Add amazing feature'`
6. **Push** to your branch: `git push origin feature/amazing-feature`
7. **Open** a Pull Request

### Development Guidelines
- Follow [Flutter's style guide](https://dart.dev/guides/language/effective-dart/style)
- Write meaningful commit messages
- Add tests for new features
- Update documentation as needed
- Ensure all platforms build successfully

### Code Style
- Use `flutter analyze` to check for lint issues
- Format code with `dart format .`
- Follow Material 3 design principles
- Maintain consistent naming conventions

### Reporting Issues
- Use the [GitHub Issues](https://github.com/kjarj54/QRNav/issues) page
- Provide detailed reproduction steps
- Include device/platform information
- Attach screenshots if applicable

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

```
MIT License

Copyright (c) 2024 QRNav Contributors

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

## 👥 Authors & Contributors

- **[@kjarj54](https://github.com/kjarj54)** - Original author and main contributor
- **QRNav Community** - Various improvements and bug fixes

### Special Thanks
- Flutter team for the amazing framework
- mobile_scanner package maintainers
- Material Design team for design guidelines
- All beta testers and community contributors

---

## 🔗 Links

- **Repository**: [https://github.com/kjarj54/QRNav](https://github.com/kjarj54/QRNav)
- **Issues**: [https://github.com/kjarj54/QRNav/issues](https://github.com/kjarj54/QRNav/issues)
- **Flutter Documentation**: [https://flutter.dev/docs](https://flutter.dev/docs)
- **Material 3 Design**: [https://m3.material.io/](https://m3.material.io/)

---

**Made with ❤️ using Flutter**
