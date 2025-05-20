import 'package:flutter/material.dart';
import '../models/qr_content.dart';
import 'package:url_launcher/url_launcher.dart';

class QRActionButtons extends StatelessWidget {
  final QRContent content;
  
  const QRActionButtons({
    super.key,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    switch (content.type) {
      case ContentType.url:
        return _buildUrlButtons(context);
      case ContentType.email:
        return _buildEmailButtons(context);
      case ContentType.phone:
        return _buildPhoneButtons(context);
      case ContentType.wifi:
        return _buildWifiButtons(context);
      case ContentType.location:
        return _buildLocationButtons(context);
      case ContentType.sms:
        return _buildSmsButtons(context);
      case ContentType.contact:
        return _buildContactButtons(context);
      case ContentType.calendar:
        return _buildCalendarButtons(context);
      case ContentType.text:
      case ContentType.unknown:
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildUrlButtons(BuildContext context) {
    final url = content.parsedData['url'] as String;
    return Row(
      children: [
        Expanded(
          child: FilledButton.icon(
            onPressed: () => _launchURL(url),
            icon: const Icon(Icons.open_in_browser),
            label: const Text('Abrir en navegador'),
          ),
        ),
      ],
    );
  }

  Widget _buildEmailButtons(BuildContext context) {
    final email = content.parsedData['email'] as String?;
    if (email == null) return const SizedBox.shrink();
    
    return Row(
      children: [
        Expanded(
          child: FilledButton.icon(
            onPressed: () => _launchURL('mailto:$email'),
            icon: const Icon(Icons.email),
            label: const Text('Enviar correo'),
          ),
        ),
      ],
    );
  }

  Widget _buildPhoneButtons(BuildContext context) {
    final phone = content.parsedData['phone'] as String?;
    if (phone == null) return const SizedBox.shrink();
    
    return Row(
      children: [
        Expanded(
          child: FilledButton.icon(
            onPressed: () => _launchURL('tel:$phone'),
            icon: const Icon(Icons.call),
            label: const Text('Llamar'),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: FilledButton.icon(
            onPressed: () => _launchURL('sms:$phone'),
            icon: const Icon(Icons.message),
            label: const Text('Enviar SMS'),
          ),
        ),
      ],
    );
  }

  Widget _buildWifiButtons(BuildContext context) {
    return const SizedBox.shrink();
  }

  Widget _buildLocationButtons(BuildContext context) {
    final lat = content.parsedData['latitude'] as String?;
    final lng = content.parsedData['longitude'] as String?;
    
    if (lat == null || lng == null) return const SizedBox.shrink();
    
    return Row(
      children: [
        Expanded(
          child: FilledButton.icon(
            onPressed: () => _launchURL('https://maps.google.com/?q=$lat,$lng'),
            icon: const Icon(Icons.map),
            label: const Text('Ver en Google Maps'),
          ),
        ),
      ],
    );
  }

  Widget _buildSmsButtons(BuildContext context) {
    final phone = content.parsedData['phone'] as String?;
    final message = content.parsedData['message'] as String?;
    
    if (phone == null) return const SizedBox.shrink();
    
    return Row(
      children: [
        Expanded(
          child: FilledButton.icon(
            onPressed: () {
              final uri = message != null 
                  ? 'sms:$phone?body=${Uri.encodeComponent(message)}'
                  : 'sms:$phone';
              _launchURL(uri);
            },
            icon: const Icon(Icons.send),
            label: const Text('Enviar SMS'),
          ),
        ),
      ],
    );
  }

  Widget _buildContactButtons(BuildContext context) {
    final phone = content.parsedData['phone'] as String?;
    final email = content.parsedData['email'] as String?;
    
    if (phone == null && email == null) return const SizedBox.shrink();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (phone != null)
          FilledButton.icon(
            onPressed: () => _launchURL('tel:$phone'),
            icon: const Icon(Icons.call),
            label: const Text('Llamar'),
          ),
          
        if (phone != null && email != null)
          const SizedBox(height: 8),
          
        if (email != null)
          FilledButton.icon(
            onPressed: () => _launchURL('mailto:$email'),
            icon: const Icon(Icons.email),
            label: const Text('Enviar correo'),
          ),
      ],
    );
  }

  Widget _buildCalendarButtons(BuildContext context) {
    return const SizedBox.shrink();
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }
}
