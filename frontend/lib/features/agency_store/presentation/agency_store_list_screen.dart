import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/widgets/app_drawer.dart';
import '../data/agency_model.dart';
import 'agency_store_detail_screen.dart';

class AgencyStoreListScreen extends StatefulWidget {
  final Map<String, dynamic> sessionData;
  final AppLanguage currentLanguage;
  final ValueChanged<AppLanguage> onLanguageChanged;
  final VoidCallback onSignOut;

  const AgencyStoreListScreen({
    super.key,
    required this.sessionData,
    required this.currentLanguage,
    required this.onLanguageChanged,
    required this.onSignOut,
  });

  @override
  State<AgencyStoreListScreen> createState() => _AgencyStoreListScreenState();
}

class _AgencyStoreListScreenState extends State<AgencyStoreListScreen> {
  String _selectedCity = 'Tous';
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  final List<String> _cities = ['Tous', 'Casablanca', 'Marrakech', 'Rabat', 'Tangier', 'Agadir'];

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    final filteredStores = AgencyStore.mockStores.where((agency) {
      final matchesCity = _selectedCity == 'Tous' || agency.city.toLowerCase() == _selectedCity.toLowerCase();
      final matchesSearch = agency.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          agency.city.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          agency.address.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCity && matchesSearch;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(loc.translate('app_title'), style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(loc.translate('agencies_home'), style: const TextStyle(fontSize: 12, fontWeight: FontWeight.normal)),
          ],
        ),
        actions: [
          DropdownButton<AppLanguage>(
            value: widget.currentLanguage,
            icon: const Icon(Icons.language, color: AppTheme.secondaryColor),
            underline: Container(),
            items: const [
              DropdownMenuItem(value: AppLanguage.fr, child: Text('FR', style: TextStyle(fontSize: 13))),
              DropdownMenuItem(value: AppLanguage.en, child: Text('EN', style: TextStyle(fontSize: 13))),
              DropdownMenuItem(value: AppLanguage.ar, child: Text('AR', style: TextStyle(fontSize: 13))),
            ],
            onChanged: (lang) {
              if (lang != null) widget.onLanguageChanged(lang);
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      drawer: AppDrawer(
        sessionData: widget.sessionData,
        currentLanguage: widget.currentLanguage,
        onLanguageChanged: widget.onLanguageChanged,
        onSignOut: widget.onSignOut,
      ),
      body: Column(
        children: [
          // Search & Filter Header Container
          Container(
            color: AppTheme.secondaryColor.withOpacity(0.06),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search Input Field
                TextField(
                  controller: _searchController,
                  onChanged: (val) {
                    setState(() {
                      _searchQuery = val;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: loc.translate('search_agency_hint'),
                    prefixIcon: const Icon(Icons.search, color: AppTheme.secondaryColor),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // City Filter Horizontal Scroll Chips
                SizedBox(
                  height: 36,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _cities.length,
                    itemBuilder: (context, index) {
                      final city = _cities[index];
                      final isSelected = _selectedCity == city;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: FilterChip(
                          selected: isSelected,
                          label: Text(
                            city == 'Tous' ? loc.translate('all_cities') : city,
                            style: TextStyle(
                              color: isSelected ? Colors.white : AppTheme.textPrimaryColor,
                              fontSize: 12,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                          backgroundColor: Colors.white,
                          selectedColor: AppTheme.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(
                              color: isSelected ? AppTheme.primaryColor : Colors.grey.shade300,
                            ),
                          ),
                          onSelected: (selected) {
                            setState(() {
                              _selectedCity = city;
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // Agencies List View
          Expanded(
            child: filteredStores.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.storefront_outlined, size: 64, color: Colors.grey.shade400),
                          const SizedBox(height: 12),
                          Text(
                            loc.translate('no_agencies_found'),
                            style: const TextStyle(color: AppTheme.textSecondaryColor, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredStores.length,
                    itemBuilder: (context, index) {
                      final agency = filteredStores[index];
                      return _buildAgencyCard(context, agency, loc);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildAgencyCard(BuildContext context, AgencyStore agency, AppLocalizations loc) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AgencyStoreDetailScreen(agency: agency),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: Logo, Name, City & Verified Badge
              Row(
                children: [
                  Container(
                    width: 54,
                    height: 54,
                    decoration: BoxDecoration(
                      color: AppTheme.secondaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        agency.logoEmoji,
                        style: const TextStyle(fontSize: 28),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                agency.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: AppTheme.textPrimaryColor,
                                ),
                              ),
                            ),
                            if (agency.isVerified) ...[
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade50,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(Icons.verified, color: Colors.blueAccent, size: 14),
                                    const SizedBox(width: 4),
                                    Text(
                                      loc.translate('verified'),
                                      style: const TextStyle(fontSize: 10, color: Colors.blueAccent, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ]
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '📍 ${agency.city} • ${agency.address}',
                          style: const TextStyle(fontSize: 12, color: AppTheme.textSecondaryColor),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              '${agency.rating}',
                              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              ' (${agency.reviewCount} avis)',
                              style: const TextStyle(fontSize: 11, color: AppTheme.textSecondaryColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(height: 1),
              const SizedBox(height: 12),

              // Car Photo Preview Gallery Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    loc.translate('car_gallery_preview'),
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.secondaryColor),
                  ),
                  Text(
                    '${agency.fleet.length} ${loc.translate('vehicles_available')}',
                    style: const TextStyle(fontSize: 11, color: AppTheme.textSecondaryColor),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              SizedBox(
                height: 80,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: agency.fleet.length,
                  itemBuilder: (context, fIndex) {
                    final vehicle = agency.fleet[fIndex];
                    return Container(
                      width: 110,
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppTheme.backgroundColor,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(vehicle.thumbnailEmoji, style: const TextStyle(fontSize: 22)),
                          const SizedBox(height: 4),
                          Text(
                            vehicle.name,
                            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            '${vehicle.price} DH${loc.translate('per_day')}',
                            style: const TextStyle(fontSize: 9, color: AppTheme.primaryColor, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),

              // Button: Visit Store
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AgencyStoreDetailScreen(agency: agency),
                      ),
                    );
                  },
                  icon: const Icon(Icons.storefront, size: 16),
                  label: Text(loc.translate('visit_store')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
