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
      'app_subtitle': 'La marketplace des agences de location au Maroc',
      'client_b2c': 'Client (B2C)',
      'agency_b2b': 'Agence (B2B)',
      'client_login_desc': 'Connectez-vous pour découvrir les agences vérifiées',
      'agency_login_desc': 'Accédez à votre espace boutique agence',
      'mock_dev_access': 'Accès Développeur Test Local',
      'cgu_notice': 'En vous connectant, vous acceptez nos CGU & Charte de Confidentialité.',
      'agencies_home': 'Agences de location',
      'my_profile': 'Mon Profil',
      'sign_out': 'Déconnexion',
      'language': 'Langue',
      'all_cities': 'Toutes les villes',
      'verified': 'Vérifiée',
      'vehicles_available': 'véhicules disponibles',
      'car_gallery_preview': 'Aperçu des véhicules en boutique',
      'visit_store': 'Visiter la boutique',
      'contact_agency': 'Contacter la boutique agence',
      'whatsapp': 'WhatsApp',
      'call': 'Appeler',
      'fleet': 'Véhicules disponibles en boutique',
      'role_connected': 'Rôle connecté',
      'per_day': '/ jour',
      'book_now': 'Réserver',
      'reservation_requested': 'Demande d\'information envoyée pour',
      'about_agency': 'À propos de cette agence',
      'search_agency_hint': 'Rechercher une agence ou une ville...',
      'no_agencies_found': 'Aucune agence trouvée dans cette catégorie.',
    },
    AppLanguage.en: {
      'app_title': 'SIIR Marketplace',
      'app_subtitle': 'Moroccan Car Rental Agency Marketplace',
      'client_b2c': 'Client (B2C)',
      'agency_b2b': 'Agency (B2B)',
      'client_login_desc': 'Sign in to discover verified agencies',
      'agency_login_desc': 'Access your agency store dashboard',
      'mock_dev_access': 'Local Developer Test Access',
      'cgu_notice': 'By connecting, you accept our Terms & Privacy Policy.',
      'agencies_home': 'Rental Agencies',
      'my_profile': 'My Profile',
      'sign_out': 'Sign Out',
      'language': 'Language',
      'all_cities': 'All Cities',
      'verified': 'Verified',
      'vehicles_available': 'vehicles available',
      'car_gallery_preview': 'Store Fleet Preview',
      'visit_store': 'Visit Store',
      'contact_agency': 'Contact Agency Store',
      'whatsapp': 'WhatsApp',
      'call': 'Call',
      'fleet': 'Available Vehicles in Store',
      'role_connected': 'Connected Role',
      'per_day': '/ day',
      'book_now': 'Book Now',
      'reservation_requested': 'Inquiry sent for',
      'about_agency': 'About this agency',
      'search_agency_hint': 'Search agency or city...',
      'no_agencies_found': 'No agencies found in this selection.',
    },
    AppLanguage.ar: {
      'app_title': 'سير - SIIR',
      'app_subtitle': 'سوق وكالات كراء السيارات بالمغرب',
      'client_b2c': 'زبون (B2C)',
      'agency_b2b': 'وكالة (B2B)',
      'client_login_desc': 'سجل الدخول لاكتشاف الوكالات المعتمدة',
      'agency_login_desc': 'الدخول إلى متجر لوحة تحكم الوكالة',
      'mock_dev_access': 'دخول تجريبي للمطور المحلي',
      'cgu_notice': 'بتسجيل الدخول، فإنك توافق على الشروط وسياسة الخصوصية.',
      'agencies_home': 'وكالات الكراء',
      'my_profile': 'ملفي الشخصي',
      'sign_out': 'تسجيل الخروج',
      'language': 'اللغة',
      'all_cities': 'جميع المدن',
      'verified': 'معتمدة',
      'vehicles_available': 'سيارات متوفرة',
      'car_gallery_preview': 'معاينة سيارات المتجر',
      'visit_store': 'زيارة المتجر',
      'contact_agency': 'الاتصال بمتجر الوكالة',
      'whatsapp': 'واتساب',
      'call': 'اتصال',
      'fleet': 'السيارات المتوفرة بالمتجر',
      'role_connected': 'الحساب الحالي',
      'per_day': '/ يوم',
      'book_now': 'حجز الآن',
      'reservation_requested': 'تم إرسال طلب استفسار لـ',
      'about_agency': 'معلومات عن الوكالة',
      'search_agency_hint': 'البحث عن وكالة أو مدينة...',
      'no_agencies_found': 'لم يتم العثور على وكالات في هذا البحث.',
    },
  };

  String translate(String key) {
    return _localizedValues[language]?[key] ?? _localizedValues[AppLanguage.fr]?[key] ?? key;
  }
}
