import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import '../screens/content_display_screen.dart';
import '../models/qr_content.dart';

class QRScannerService {  static void processQRCode(BuildContext context, String? code) async {
    if (code == null) return;
    
    final qrContent = QRContent.fromRawData(code);
    
    if (qrContent.type == ContentType.url) {
      final bool openInBrowser = await _showOpenLinkDialog(context);
        if (openInBrowser) {
        await _launchURL(qrContent.parsedData['url'] as String);
      } else {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ContentDisplayScreen(
              content: qrContent,
            ),
          ),
        );
      }
    } else {
      await Navigator.push(
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