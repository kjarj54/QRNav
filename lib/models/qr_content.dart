enum ContentType {
  url,
  text,
  email,
  phone,
  wifi,
  location,
  calendar,
  contact,
  sms,
  unknown
}

class QRContent {
  final String rawData;
  final ContentType type;
  final Map<String, dynamic> parsedData;

  QRContent({
    required this.rawData,
    required this.type,
    this.parsedData = const {},
  });

  factory QRContent.fromRawData(String data) {
    if (data.startsWith('http://') || data.startsWith('https://')) {
      return QRContent(
        rawData: data,
        type: ContentType.url,
        parsedData: {'url': data},
      );
    } else if (data.startsWith('mailto:')) {
      final email = data.substring(7);
      return QRContent(
        rawData: data,
        type: ContentType.email,
        parsedData: {'email': email},
      );
    } else if (data.startsWith('tel:')) {
      final phone = data.substring(4);
      return QRContent(
        rawData: data,
        type: ContentType.phone,
        parsedData: {'phone': phone},
      );
    } else if (data.startsWith('WIFI:')) {
      // WIFI:S:<SSID>;T:<WPA|WEP|>;P:<password>;;
      final Map<String, dynamic> wifiData = {};
      
      // Extract SSID
      final ssidMatch = RegExp(r'S:([^;]*)').firstMatch(data);
      if (ssidMatch != null) {
        wifiData['ssid'] = ssidMatch.group(1);
      }
      
      // Extract password
      final passMatch = RegExp(r'P:([^;]*)').firstMatch(data);
      if (passMatch != null) {
        wifiData['password'] = passMatch.group(1);
      }
      
      // Extract encryption type
      final typeMatch = RegExp(r'T:([^;]*)').firstMatch(data);
      if (typeMatch != null) {
        wifiData['encryption'] = typeMatch.group(1);
      }
      
      return QRContent(
        rawData: data,
        type: ContentType.wifi,
        parsedData: wifiData,
      );
    } else if (data.startsWith('geo:')) {
      // geo:latitude,longitude
      final coords = data.substring(4).split(',');
      if (coords.length >= 2) {
        return QRContent(
          rawData: data,
          type: ContentType.location,
          parsedData: {
            'latitude': coords[0],
            'longitude': coords[1],
          },
        );
      }
    } else if (data.startsWith('BEGIN:VCARD')) {
      // Very basic vCard parsing
      final Map<String, dynamic> contactData = {};
      
      // Extract name
      final nameMatch = RegExp(r'FN:(.*?)\n').firstMatch(data);
      if (nameMatch != null) {
        contactData['name'] = nameMatch.group(1);
      }
      
      // Extract phone
      final phoneMatch = RegExp(r'TEL:(.*?)\n').firstMatch(data);
      if (phoneMatch != null) {
        contactData['phone'] = phoneMatch.group(1);
      }
      
      // Extract email
      final emailMatch = RegExp(r'EMAIL:(.*?)\n').firstMatch(data);
      if (emailMatch != null) {
        contactData['email'] = emailMatch.group(1);
      }
      
      return QRContent(
        rawData: data,
        type: ContentType.contact,
        parsedData: contactData,
      );
    } else if (data.startsWith('BEGIN:VEVENT')) {
      // Basic calendar event parsing
      final Map<String, dynamic> eventData = {};
      
      // Extract summary (event title)
      final summaryMatch = RegExp(r'SUMMARY:(.*?)\n').firstMatch(data);
      if (summaryMatch != null) {
        eventData['summary'] = summaryMatch.group(1);
      }
      
      // Extract start date
      final startMatch = RegExp(r'DTSTART:(.*?)\n').firstMatch(data);
      if (startMatch != null) {
        eventData['start'] = startMatch.group(1);
      }
      
      return QRContent(
        rawData: data,
        type: ContentType.calendar,
        parsedData: eventData,
      );
    } else if (data.startsWith('smsto:') || data.startsWith('sms:')) {
      // Basic SMS parsing
      final colonIndex = data.indexOf(':');
      final data2 = data.substring(colonIndex + 1);
      final parts = data2.split(':');
      
      if (parts.length >= 2) {
        return QRContent(
          rawData: data,
          type: ContentType.sms,
          parsedData: {
            'phone': parts[0],
            'message': parts[1],
          },
        );
      } else {
        return QRContent(
          rawData: data,
          type: ContentType.sms,
          parsedData: {'phone': parts[0]},
        );
      }
    }
    
    // Default to text type if no specific format is detected
    return QRContent(
      rawData: data,
      type: ContentType.text,
      parsedData: {'text': data},
    );
  }

  String getDisplayTitle() {
    switch (type) {
      case ContentType.url:
        return 'Enlace Web';
      case ContentType.email:
        return 'Correo Electrónico';
      case ContentType.phone:
        return 'Número Telefónico';
      case ContentType.wifi:
        return 'Red WiFi';
      case ContentType.location:
        return 'Ubicación';
      case ContentType.calendar:
        return 'Evento de Calendario';
      case ContentType.contact:
        return 'Contacto';
      case ContentType.sms:
        return 'Mensaje SMS';
      case ContentType.text:
      case ContentType.unknown:
      default:
        return 'Texto';
    }
  }
}
