import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import '../screens/content_display_screen.dart';
import '../models/qr_content.dart';

class QRScannerService {
  static void processQRCode(BuildContext context, String? code) async {
    if (code == null) return;
    
    // Parse the QR code content
    final qrContent = QRContent.fromRawData(code);
    
    // Handle the content based on type
    if (qrContent.type == ContentType.url) {
      // Show dialog asking if user wants to open in browser or in-app
      final bool openInBrowser = await _showOpenLinkDialog(context);
        if (openInBrowser) {
        // Launch URL in external browser
        await _launchURL(qrContent.parsedData['url'] as String);
      } else {
        // Navigate to content display screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ContentDisplayScreen(
              content: qrContent,
            ),
          ),
        );
      }
    } else {
      // Navigate to content display screen for all other content types
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ContentDisplayScreen(
            content: qrContent,
          ),
        ),
      );
    }
  }
  
  static Future<bool> _showOpenLinkDialog(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Enlace detectado'),
        content: const Text('¿Cómo deseas abrir este enlace?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Ver en la app'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Abrir en navegador'),
          ),
        ],
      ),
    );
    
    return result ?? false;
  }

  static Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }
}