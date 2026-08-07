import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/localization/app_localizations.dart';
import '../data/agency_model.dart';

class AgencyStoreDetailScreen extends StatelessWidget {
  final AgencyStore agency;

  const AgencyStoreDetailScreen({super.key, required this.agency});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(agency.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Store Banner Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppTheme.secondaryColor, Color(0xFF0F1E1E)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 36,
                    backgroundColor: AppTheme.primaryColor.withOpacity(0.2),
                    child: Text(
                      agency.logoEmoji,
                      style: const TextStyle(fontSize: 36),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          agency.name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      if (agency.isVerified) ...[
                        const SizedBox(width: 8),
                        const Icon(Icons.verified, color: Colors.blueAccent, size: 20),
                      ]
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '📍 ${agency.address}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 18),
                      const SizedBox(width: 4),
                      Text(
                        '${agency.rating} (${agency.reviewCount} avis)',
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Contact Actions (WhatsApp & Call)
                  Text(
                    loc.translate('contact_agency'),
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.secondaryColor),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('WhatsApp: ${agency.whatsapp}')),
                            );
                          },
                          icon: const Icon(Icons.chat_bubble_outline),
                          label: Text(loc.translate('whatsapp')),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF25D366),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Appel: ${agency.phone}')),
                            );
                          },
                          icon: const Icon(Icons.phone),
                          label: Text(loc.translate('call')),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Agency Description
                  Text(
                    loc.translate('about_agency'),
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.secondaryColor),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    agency.description,
                    style: const TextStyle(color: AppTheme.textSecondaryColor, height: 1.4),
                  ),
                  const SizedBox(height: 24),

                  // Available Fleet Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        loc.translate('fleet'),
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.secondaryColor),
                      ),
                      Text(
                        '${agency.fleet.length} ${loc.translate('vehicles_available')}',
                        style: const TextStyle(color: AppTheme.textSecondaryColor, fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: agency.fleet.length,
                    itemBuilder: (context, index) {
                      final vehicle = agency.fleet[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 16),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  color: AppTheme.primaryColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Center(
                                  child: Text(
                                    vehicle['image'],
                                    style: const TextStyle(fontSize: 32),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      vehicle['name'],
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${vehicle['category']} • ${vehicle['fuel']} • ${vehicle['transmission']}',
                                      style: const TextStyle(fontSize: 12, color: AppTheme.textSecondaryColor),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      '${vehicle['price']} DH${loc.translate('per_day')}',
                                      style: const TextStyle(
                                        color: AppTheme.primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('${loc.translate('reservation_requested')} ${vehicle['name']}')),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                  minimumSize: const Size(60, 36),
                                ),
                                child: Text(loc.translate('book_now'), style: const TextStyle(fontSize: 12)),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
