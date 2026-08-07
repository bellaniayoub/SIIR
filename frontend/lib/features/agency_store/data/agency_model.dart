class AgencyStore {
  final String id;
  final String name;
  final String city;
  final String address;
  final String phone;
  final String whatsapp;
  final double rating;
  final int reviewCount;
  final bool isVerified;
  final String logoEmoji;
  final String description;
  final List<Map<String, dynamic>> fleet;

  AgencyStore({
    required this.id,
    required this.name,
    required this.city,
    required this.address,
    required this.phone,
    required this.whatsapp,
    required this.rating,
    required this.reviewCount,
    required this.isVerified,
    required this.logoEmoji,
    required this.description,
    required this.fleet,
  });

  static final List<AgencyStore> mockStores = [
    AgencyStore(
      id: 'ag-001',
      name: 'Yacout Car Casablanca',
      city: 'Casablanca',
      address: 'Boulevard Anfa, Casablanca',
      phone: '+212 522 12 34 56',
      whatsapp: '+212 661 12 34 56',
      rating: 4.8,
      reviewCount: 142,
      isVerified: true,
      logoEmoji: '🏢',
      description: 'Agence leader à Casablanca spécialisée dans les véhicules berlines et citadines économiques avec livraison à l\'aéroport Mohammed V.',
      fleet: [
        {
          'name': 'Dacia Logan',
          'category': 'Berline',
          'price': 250,
          'fuel': 'Diesel',
          'transmission': 'Manuelle',
          'image': '🚗',
        },
        {
          'name': 'Dacia Sandero Stepway',
          'category': 'Citadine',
          'price': 280,
          'fuel': 'Diesel',
          'transmission': 'Manuelle',
          'image': '🚗',
        },
      ],
    ),
    AgencyStore(
      id: 'ag-002',
      name: 'Bahia RENT Marrakech',
      city: 'Marrakech',
      address: 'Avenue Mohammed V, Guéliz, Marrakech',
      phone: '+212 524 98 76 54',
      whatsapp: '+212 662 98 76 54',
      rating: 4.9,
      reviewCount: 215,
      isVerified: true,
      logoEmoji: '🕌',
      description: 'Service premium à Marrakech. Assistance 24/7 et livraison gratuite aux hôtels et à l\'aéroport Marrakech-Ménara.',
      fleet: [
        {
          'name': 'Renault Clio 5',
          'category': 'Citadine',
          'price': 300,
          'fuel': 'Essence',
          'transmission': 'Manuelle',
          'image': '🚗',
        },
        {
          'name': 'Peugeot 208',
          'category': 'Citadine',
          'price': 290,
          'fuel': 'Diesel',
          'transmission': 'Manuelle',
          'image': '🚗',
        },
      ],
    ),
    AgencyStore(
      id: 'ag-003',
      name: 'Atlas Horizon Rabat',
      city: 'Rabat',
      address: 'Agdal, Rabat',
      phone: '+212 537 44 55 66',
      whatsapp: '+212 663 44 55 66',
      rating: 4.9,
      reviewCount: 98,
      isVerified: true,
      logoEmoji: '🏛️',
      description: 'Spécialiste de la location de SUV et véhicules d\'affaires pour professionnels et touristes à Rabat.',
      fleet: [
        {
          'name': 'Hyundai Tucson',
          'category': 'SUV',
          'price': 600,
          'fuel': 'Diesel',
          'transmission': 'Automatique',
          'image': '🚙',
        },
      ],
    ),
    AgencyStore(
      id: 'ag-004',
      name: 'Lux Voyage Tanger',
      city: 'Tangier',
      address: 'Avenue Mohammed VI, Tanger',
      phone: '+212 539 11 22 33',
      whatsapp: '+212 664 11 22 33',
      rating: 5.0,
      reviewCount: 87,
      isVerified: true,
      logoEmoji: '⚓',
      description: 'Flotte haut de gamme à Tanger. Prise en charge au port Tanger Med et à l\'aéroport Ibn Battouta.',
      fleet: [
        {
          'name': 'Range Rover Sport',
          'category': '4x4 Premium',
          'price': 1800,
          'fuel': 'Diesel',
          'transmission': 'Automatique',
          'image': '🚙',
        },
      ],
    ),
  ];
}
