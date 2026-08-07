import 'package:flutter/material.dart';

enum AppLanguage { fr, en, ar }

class AppLocalizations {
  final AppLanguage language;

  AppLocalizations(this.language);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations) ??
        AppLocalizations(AppLanguage.fr);
  }

  TextDirection get textDirection =>
      language == AppLanguage.ar ? TextDirection.rtl : TextDirection.ltr;

  String get languageName {
    switch (language) {
      case AppLanguage.fr:
        return 'Français';
      case AppLanguage.en:
        return 'English';
      case AppLanguage.ar:
        return 'العربية';
    }
  }

  static const Map<AppLanguage, Map<String, String>> _localizedValues = {
    AppLanguage.fr: {
      'app_title': 'SIIR Marketplace',
      'app_subtitle': 'La marketplace de location de voitures',
      'client_b2c': 'Client (B2C)',
      'agency_b2b': 'Agence (B2B)',
      'client_login_desc': 'Connectez-vous pour louer un véhicule',
      'agency_login_desc': 'Accédez à votre espace agence vérifiée',
      'mock_dev_access': 'Accès Développeur Test Local',
      'cgu_notice': 'En vous connectant, vous acceptez nos CGU & Charte de Confidentialité.',
      'vehicles': 'Véhicules',
      'agencies': 'Boutiques Agences',
      'chat': 'Traducteur Chat',
      'my_profile': 'Mon Profil',
      'my_store': 'Ma Boutique Agence',
      'sign_out': 'Déconnexion',
      'language': 'Langue',
      'search_title': 'Rechercher un véhicule au Maroc',
      'pickup_city': 'Ville de départ',
      'category': 'Catégorie',
      'fuel': 'Carburant',
      'transmission': 'Transmission',
      'all': 'Tous',
      'vehicles_found': 'véhicules trouvés à',
      'no_vehicles': 'Aucun véhicule disponible avec ces filtres.',
      'managed_by': 'Boutique agence:',
      'per_day': '/ jour',
      'book_now': 'Réserver',
      'reservation_requested': 'Réservation demandée pour',
      'chat_banner': 'SIIR traduit automatiquement les messages entre l\'agence et le client en temps réel.',
      'smart_translator': 'Traducteur Intelligent',
      'type_message': 'Écrire un message...',
      'agency_stores_title': 'Agences de location vérifiées',
      'agency_stores_subtitle': 'Découvrez les boutiques certifiées à travers le Maroc',
      'verified': 'Vérifiée',
      'vehicles_available': 'véhicules disponibles',
      'contact_agency': 'Contacter l\'agence',
      'whatsapp': 'WhatsApp',
      'call': 'Appeler',
      'fleet': 'Flotte disponible',
      'role_connected': 'Rôle connecté',
    },
    AppLanguage.en: {
      'app_title': 'SIIR Marketplace',
      'app_subtitle': 'The Car Rental Marketplace',
      'client_b2c': 'Client (B2C)',
      'agency_b2b': 'Agency (B2B)',
      'client_login_desc': 'Sign in to rent a vehicle',
      'agency_login_desc': 'Access your verified agency space',
      'mock_dev_access': 'Local Developer Test Access',
      'cgu_notice': 'By connecting, you accept our Terms & Privacy Policy.',
      'vehicles': 'Vehicles',
      'agencies': 'Agency Stores',
      'chat': 'Chat Translator',
      'my_profile': 'My Profile',
      'my_store': 'My Agency Store',
      'sign_out': 'Sign Out',
      'language': 'Language',
      'search_title': 'Find a vehicle in Morocco',
      'pickup_city': 'Pickup City',
      'category': 'Category',
      'fuel': 'Fuel',
      'transmission': 'Transmission',
      'all': 'All',
      'vehicles_found': 'vehicles found in',
      'no_vehicles': 'No vehicles available with these filters.',
      'managed_by': 'Agency store:',
      'per_day': '/ day',
      'book_now': 'Book Now',
      'reservation_requested': 'Booking requested for',
      'chat_banner': 'SIIR automatically translates messages between agency and client in real time.',
      'smart_translator': 'Smart Translator',
      'type_message': 'Type a message...',
      'agency_stores_title': 'Verified Car Rental Agencies',
      'agency_stores_subtitle': 'Discover certified stores across Morocco',
      'verified': 'Verified',
      'vehicles_available': 'vehicles available',
      'contact_agency': 'Contact Agency',
      'whatsapp': 'WhatsApp',
      'call': 'Call',
      'fleet': 'Available Fleet',
      'role_connected': 'Connected Role',
    },
    AppLanguage.ar: {
      'app_title': 'سير - SIIR',
      'app_subtitle': 'السوق الذكي لكرات السيارات بالمغرب',
      'client_b2c': 'زبون (B2C)',
      'agency_b2b': 'وكالة (B2B)',
      'client_login_desc': 'قم بتسجيل الدخول لاستئجار سيارة',
      'agency_login_desc': 'الدخول إلى فضاء الوكالة المعتمدة',
      'mock_dev_access': 'دخول تجريبي للمطور المحلي',
      'cgu_notice': 'بتسجيل الدخول، فإنك توافق على الشروط وسياسة الخصوصية.',
      'vehicles': 'السيارات',
      'agencies': 'متجر الوكالات',
      'chat': 'المترجم الذكي',
      'my_profile': 'ملفي الشخصي',
      'my_store': 'متجر وكالتي',
      'sign_out': 'تسجيل الخروج',
      'language': 'اللغة',
      'search_title': 'البحث عن سيارة في المغرب',
      'pickup_city': 'مدينة الاستلام',
      'category': 'الفئة',
      'fuel': 'نوع الوقود',
      'transmission': 'ناقل الحركة',
      'all': 'الكل',
      'vehicles_found': 'سيارة متوفرة في',
      'no_vehicles': 'لا تتوفر سيارات تتماشى مع هذه الفلاتر.',
      'managed_by': 'متجر الوكالة:',
      'per_day': '/ يوم',
      'book_now': 'حجز الآن',
      'reservation_requested': 'تم طلب حجز',
      'chat_banner': 'يقوم تطبيق سير بترجمة الرسائل تلقائياً بين الوكالة والزبون في الوقت الفعلي.',
      'smart_translator': 'المترجم المباشر',
      'type_message': 'اكتب رسالة...',
      'agency_stores_title': 'وكالات كراء السيارات المعتمدة',
      'agency_stores_subtitle': 'اكتشف المتاجر الموثوقة في جميع أنحاء المغرب',
      'verified': 'معتمدة',
      'vehicles_available': 'سيارة متوفرة',
      'contact_agency': 'الاتصال بالوكالة',
      'whatsapp': 'واتساب',
      'call': 'اتصال',
      'fleet': 'الأسطول المتاح',
      'role_connected': 'الحساب الحالي',
    },
  };

  String translate(String key) {
    return _localizedValues[language]?[key] ?? _localizedValues[AppLanguage.fr]?[key] ?? key;
  }
}
