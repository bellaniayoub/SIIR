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
      description: 'Agence de référence à Casablanca spécialisée dans la location de véhicules citadins et berlines d\'affaires avec livraison gratuite à l\'aéroport Mohammed V.',
      fleet: [
        {
          'name': 'Dacia Logan 2024',
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
          'image': '🚙',
        },
        {
          'name': 'Renault Clio 5',
          'category': 'Citadine',
          'price': 300,
          'fuel': 'Essence',
          'transmission': 'Manuelle',
          'image': '🚘',
        },
      ],
    ),
    AgencyStore(
      id: 'ag-002',
      name: 'Bahia RENT Marrakech',
      city: 'Marrakech',
      address: 'Avenue Guadeloupe, Guéliz, Marrakech',
      phone: '+212 524 98 76 54',
      whatsapp: '+212 662 98 76 54',
      rating: 4.9,
      reviewCount: 215,
      isVerified: true,
      logoEmoji: '🕌',
      description: 'Service d\'excellence à Marrakech. Flotte révisée, assistance 24/7 et livraison gratuite aux hôtels, riads et à l\'aéroport Marrakech-Ménara.',
      fleet: [
        {
          'name': 'Peugeot 208 GT',
          'category': 'Citadine',
          'price': 320,
          'fuel': 'Diesel',
          'transmission': 'Manuelle',
          'image': '🚗',
        },
        {
          'name': 'Hyundai Tucson 4x4',
          'category': 'SUV',
          'price': 650,
          'fuel': 'Diesel',
          'transmission': 'Automatique',
          'image': '🚙',
        },
        {
          'name': 'Fiat 500 Cabriolet',
          'category': 'Citadine',
          'price': 350,
          'fuel': 'Essence',
          'transmission': 'Automatique',
          'image': '🏎️',
        },
      ],
    ),
    AgencyStore(
      id: 'ag-003',
      name: 'Atlas Horizon Rabat',
      city: 'Rabat',
      address: 'Avenue de France, Agdal, Rabat',
      phone: '+212 537 44 55 66',
      whatsapp: '+212 663 44 55 66',
      rating: 4.9,
      reviewCount: 98,
      isVerified: true,
      logoEmoji: '🏛️',
      description: 'Spécialiste de la mobility premium et berlines exécutives à Rabat pour diplomates, hommes d\'affaires et voyageurs exigeants.',
      fleet: [
        {
          'name': 'Volkswagen Golf 8',
          'category': 'Berline',
          'price': 500,
          'fuel': 'Diesel',
          'transmission': 'Automatique',
          'image': '🚗',
        },
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
      address: 'Avenue Mohammed VI, Tanger Port',
      phone: '+212 539 11 22 33',
      whatsapp: '+212 664 11 22 33',
      rating: 5.0,
      reviewCount: 87,
      isVerified: true,
      logoEmoji: '⚓',
      description: 'Location de voitures de prestige et SUV 4x4 à Tanger. Service VIP au port Tanger Med et à l\'aéroport Ibn Battouta.',
      fleet: [
        {
          'name': 'Range Rover Sport',
          'category': '4x4 Premium',
          'price': 1800,
          'fuel': 'Diesel',
          'transmission': 'Automatique',
          'image': '🚙',
        },
        {
          'name': 'Mercedes Classe C',
          'category': 'Berline Prestige',
          'price': 1200,
          'fuel': 'Diesel',
          'transmission': 'Automatique',
          'image': '🚘',
        },
      ],
    ),
    AgencyStore(
      id: 'ag-005',
      name: 'Souss Ocean Cars Agadir',
      city: 'Agadir',
      address: 'Boulevard Hassan II, Agadir',
      phone: '+212 528 22 33 44',
      whatsapp: '+212 665 22 33 44',
      rating: 4.7,
      reviewCount: 110,
      isVerified: true,
      logoEmoji: '🏖️',
      description: 'Agence de confiance à Agadir pour vos déplacements touristiques et balnéaires. Tarifs compétitifs et service personnalisé.',
      fleet: [
        {
          'name': 'Dacia Duster 4x4',
          'category': 'SUV',
          'price': 400,
          'fuel': 'Diesel',
          'transmission': 'Manuelle',
          'image': '🚙',
        },
        {
          'name': 'Kia Picanto',
          'category': 'Citadine',
          'price': 220,
          'fuel': 'Essence',
          'transmission': 'Manuelle',
          'image': '🚗',
        },
      ],
    ),
  ];
}
