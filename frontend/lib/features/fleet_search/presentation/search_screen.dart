import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class SearchScreen extends StatefulWidget {
  final Map<String, dynamic> sessionData;
  final VoidCallback onSignOut;

  const SearchScreen({
    super.key,
    required this.sessionData,
    required this.onSignOut,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _selectedCity = 'Casablanca';
  String _selectedCategory = 'Tous';
  String _selectedFuel = 'Tous';
  String _selectedTransmission = 'Tous';

  final List<String> _cities = ['Casablanca', 'Marrakech', 'Rabat', 'Tangier', 'Agadir', 'Fes'];
  final List<String> _categories = ['Tous', 'Citadine', 'Berline', 'SUV', '4x4 Premium'];
  final List<String> _fuels = ['Tous', 'Diesel', 'Essence', 'Hybride/Électrique'];
  final List<String> _transms = ['Tous', 'Automatique', 'Manuelle'];

  // Mock list of cars with Moroccan rental pricing
  final List<Map<String, dynamic>> _mockCars = [
    {
      'name': 'Dacia Logan',
      'category': 'Berline',
      'city': 'Casablanca',
      'price': 250, // MAD/day
      'fuel': 'Diesel',
      'transmission': 'Manuelle',
      'agency': 'Yacout Car S.A.R.L.',
      'rating': 4.7,
      'image': '🚗',
    },
    {
      'name': 'Renault Clio 5',
      'category': 'Citadine',
      'city': 'Marrakech',
      'price': 300,
      'fuel': 'Essence',
      'transmission': 'Manuelle',
      'agency': 'Bahia RENT Marrakech',
      'rating': 4.8,
      'image': '🚗',
    },
    {
      'name': 'Hyundai Tucson',
      'category': 'SUV',
      'city': 'Rabat',
      'price': 600,
      'fuel': 'Diesel',
      'transmission': 'Automatique',
      'agency': 'Atlas Horizon Cars',
      'rating': 4.9,
      'image': '🚙',
    },
    {
      'name': 'Range Rover Sport',
      'category': '4x4 Premium',
      'city': 'Tangier',
      'price': 1800,
      'fuel': 'Diesel',
      'transmission': 'Automatique',
      'agency': 'Lux Voyage Tanger',
      'rating': 5.0,
      'image': 'SUV',
    },
    {
      'name': 'Peugeot 208',
      'category': 'Citadine',
      'city': 'Agadir',
      'price': 280,
      'fuel': 'Diesel',
      'transmission': 'Manuelle',
      'agency': 'Souss Ocean Cars',
      'rating': 4.6,
      'image': '🚗',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final user = widget.sessionData['user'] as Map<String, dynamic>?;
    final userEmail = user?['email'] ?? 'Utilisateur SIIR';
    final userName = user?['name'] ?? 'Utilisateur';
    final role = widget.sessionData['role_assigned'] ?? 'Client';

    // Apply filtering on mock data
    final filteredCars = _mockCars.where((car) {
      final matchCity = car['city'] == _selectedCity;
      final matchCategory = _selectedCategory == 'Tous' || car['category'] == _selectedCategory;
      final matchFuel = _selectedFuel == 'Tous' || car['fuel'] == _selectedFuel;
      final matchTransm = _selectedTransmission == 'Tous' || car['transmission'] == _selectedTransmission;
      return matchCity && matchCategory && matchFuel && matchTransm;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('SIIR Marketplace'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: widget.onSignOut,
            tooltip: 'Déconnexion',
          ),
        ],
      ),
      body: Column(
        children: [
          // User Info Banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: AppTheme.secondaryColor.withOpacity(0.08),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppTheme.secondaryColor,
                  radius: 18,
                  child: Text(
                    userName.isNotEmpty ? userName[0].toUpperCase() : 'U',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Marhaban, $userName',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      Text(
                        'Rôle connecté : $role ($userEmail)',
                        style: const TextStyle(color: AppTheme.textSecondaryColor, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Filters section
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Rechercher un véhicule au Maroc',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.secondaryColor),
                    ),
                    const SizedBox(height: 16),

                    // City Selector Dropdown
                    const Text('Ville de départ', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _selectedCity,
                          isExpanded: true,
                          items: _cities.map((city) {
                            return DropdownMenuItem(value: city, child: Text(city));
                          }).toList(),
                          onChanged: (val) {
                            if (val != null) setState(() => _selectedCity = val);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Category & Fuel row filters
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Catégorie', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                              const SizedBox(height: 6),
                              DropdownButtonFormField<String>(
                                value: _selectedCategory,
                                decoration: const InputDecoration(contentPadding: EdgeInsets.symmetric(horizontal: 10)),
                                items: _categories.map((c) => DropdownMenuItem(value: c, child: Text(c, style: const TextStyle(fontSize: 12)))).toList(),
                                onChanged: (val) => setState(() => _selectedCategory = val!),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Carburant', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                              const SizedBox(height: 6),
                              DropdownButtonFormField<String>(
                                value: _selectedFuel,
                                decoration: const InputDecoration(contentPadding: EdgeInsets.symmetric(horizontal: 10)),
                                items: _fuels.map((f) => DropdownMenuItem(value: f, child: Text(f, style: const TextStyle(fontSize: 12)))).toList(),
                                onChanged: (val) => setState(() => _selectedFuel = val!),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Results listing
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${filteredCars.length} véhicules trouvés à $_selectedCity',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    if (filteredCars.isEmpty)
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 40.0),
                          child: Column(
                            children: [
                              Icon(Icons.directions_car_outlined, size: 64, color: Colors.grey.shade400),
                              const SizedBox(height: 12),
                              const Text(
                                'Aucun véhicule disponible avec ces filtres.',
                                style: TextStyle(color: AppTheme.textSecondaryColor),
                              ),
                            ],
                          ),
                        ),
                      )
                    else
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: filteredCars.length,
                        itemBuilder: (context, index) {
                          final car = filteredCars[index];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 16),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  // Mock car illustration
                                  Container(
                                    width: 70,
                                    height: 70,
                                    decoration: BoxDecoration(
                                      color: AppTheme.primaryColor.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Center(
                                      child: Text(
                                        car['image'],
                                        style: const TextStyle(fontSize: 32),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  // Detail specifications
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          car['name'],
                                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                        ),
                                        Text(
                                          'Géré par: ${car['agency']}',
                                          style: const TextStyle(fontSize: 12, color: AppTheme.textSecondaryColor),
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          children: [
                                            _buildBadge(car['fuel']),
                                            const SizedBox(width: 4),
                                            _buildBadge(car['transmission']),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Pricing & Booking Action
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        '${car['price']} DH',
                                        style: const TextStyle(
                                          color: AppTheme.primaryColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                      const Text('/ jour', style: TextStyle(fontSize: 11, color: AppTheme.textSecondaryColor)),
                                      const SizedBox(height: 12),
                                      ElevatedButton(
                                        onPressed: () {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content: Text('Réservation demandée pour ${car['name']}')),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                          minimumSize: const Size(60, 36),
                                        ),
                                        child: const Text('Réserver', style: TextStyle(fontSize: 12)),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppTheme.textSecondaryColor),
      ),
    );
  }
}
