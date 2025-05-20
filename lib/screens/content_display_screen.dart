import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/qr_content.dart';
import '../widgets/qr_action_buttons.dart';

class ContentDisplayScreen extends StatelessWidget {
  final QRContent content;

  const ContentDisplayScreen({
    super.key,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(content.getDisplayTitle()),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.copy),
            tooltip: 'Copiar al portapapeles',
            onPressed: () {
              Clipboard.setData(ClipboardData(text: content.rawData));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Contenido copiado al portapapeles'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display the appropriate content view based on content type
              _buildContentView(context),
              
              const SizedBox(height: 24),
              
              // Action buttons for this content type
              QRActionButtons(content: content),
              
              const SizedBox(height: 24),
              
              // Show full raw data section
              const Text(
                'Contenido completo:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceVariant,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.outline,
                    width: 1,
                  ),
                ),
                child: SelectableText(
                  content.rawData,
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContentView(BuildContext context) {
    switch (content.type) {
      case ContentType.url:
        return _buildUrlView(context);
      case ContentType.wifi:
        return _buildWifiView(context);
      case ContentType.contact:
        return _buildContactView(context);
      case ContentType.email:
        return _buildEmailView(context);
      case ContentType.phone:
        return _buildPhoneView(context);
      case ContentType.location:
        return _buildLocationView(context);
      case ContentType.calendar:
        return _buildCalendarView(context);
      case ContentType.sms:
        return _buildSmsView(context);
      case ContentType.text:
      case ContentType.unknown:
        return _buildTextView(context);
    }
  }

  Widget _buildUrlView(BuildContext context) {
    final url = content.parsedData['url'] as String;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.link, size: 48),
        const SizedBox(height: 16),
        Text(
          'Enlace Web',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 8),
        Text(
          url,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }

  Widget _buildWifiView(BuildContext context) {
    final ssid = content.parsedData['ssid'] as String?;
    final password = content.parsedData['password'] as String?;
    final encryption = content.parsedData['encryption'] as String?;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.wifi, size: 48),
        const SizedBox(height: 16),
        Text(
          'Red WiFi',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 16),
        
        if (ssid != null) _buildInfoRow(context, 'SSID (nombre red):', ssid),
        if (password != null) _buildInfoRow(context, 'Contraseña:', password),
        if (encryption != null) _buildInfoRow(context, 'Encriptación:', encryption),
      ],
    );
  }

  Widget _buildContactView(BuildContext context) {
    final name = content.parsedData['name'] as String?;
    final phone = content.parsedData['phone'] as String?;
    final email = content.parsedData['email'] as String?;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.person, size: 48),
        const SizedBox(height: 16),
        Text(
          'Contacto',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 16),
        
        if (name != null) _buildInfoRow(context, 'Nombre:', name),
        if (phone != null) _buildInfoRow(context, 'Teléfono:', phone),
        if (email != null) _buildInfoRow(context, 'Email:', email),
      ],
    );
  }

  Widget _buildEmailView(BuildContext context) {
    final email = content.parsedData['email'] as String?;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.email, size: 48),
        const SizedBox(height: 16),
        Text(
          'Correo Electrónico',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 8),
        Text(
          email ?? '',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }

  Widget _buildPhoneView(BuildContext context) {
    final phone = content.parsedData['phone'] as String?;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.phone, size: 48),
        const SizedBox(height: 16),
        Text(
          'Número Telefónico',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 8),
        Text(
          phone ?? '',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }

  Widget _buildLocationView(BuildContext context) {
    final lat = content.parsedData['latitude'] as String?;
    final lng = content.parsedData['longitude'] as String?;
    
    final coordsText = (lat != null && lng != null) 
        ? '$lat, $lng'
        : 'Coordenadas no disponibles';
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.location_on, size: 48),
        const SizedBox(height: 16),
        Text(
          'Ubicación',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 8),
        Text(
          coordsText,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }

  Widget _buildCalendarView(BuildContext context) {
    final summary = content.parsedData['summary'] as String?;
    final start = content.parsedData['start'] as String?;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.event, size: 48),
        const SizedBox(height: 16),
        Text(
          'Evento de Calendario',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 16),
        
        if (summary != null) _buildInfoRow(context, 'Título:', summary),
        if (start != null) _buildInfoRow(context, 'Inicio:', start),
      ],
    );
  }

  Widget _buildSmsView(BuildContext context) {
    final phone = content.parsedData['phone'] as String?;
    final message = content.parsedData['message'] as String?;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.message, size: 48),
        const SizedBox(height: 16),
        Text(
          'Mensaje SMS',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 16),
        
        if (phone != null) _buildInfoRow(context, 'Número:', phone),
        if (message != null) _buildInfoRow(context, 'Mensaje:', message),
      ],
    );
  }

  Widget _buildTextView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.text_snippet, size: 48),
        const SizedBox(height: 16),
        Text(
          'Texto',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceVariant,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Theme.of(context).colorScheme.outline,
              width: 1,
            ),
          ),
          child: SelectableText(
            content.rawData,
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}
