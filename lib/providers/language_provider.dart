import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider extends ChangeNotifier {
  Locale _locale = const Locale('en');

  Locale get locale => _locale;

  LanguageProvider() {
    _loadSavedLanguage();
  }

  Future<void> _loadSavedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final String languageCode = prefs.getString('language_code') ?? 'en';
    _locale = Locale(languageCode);
    notifyListeners();
  }

  Future<void> setLocale(Locale locale) async {
    if (_locale == locale) return;

    _locale = locale;

    // Save to SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', locale.languageCode);

    notifyListeners();
  }
}





class LocalizationService {
  static final Map<String, Map<String, String>> _localizedStrings = {
'en': {
  'wish': 'Hello',
  'search_medicine': 'Search your Medicine',
  'order_medicine': 'Order your Medicine!',
  'delivery_line': 'We deliver medicines at your\ndoorstep in no time',
  'order_now': 'Order Now',
  'services': 'Services',
  'categories': 'Categories',
  'see_all': 'See All',
  'previous_orders': 'Previous Orders',
  'reorder': 'Re-Order',
  'details': 'Details',
  'periodic_plan': 'Periodic Meds Plan',
    'periodic_meds': 'Periodic Meds',
  'plan': 'Plan',
  'activate': 'Activate',
  'all_medicines': 'All Medicines',
  'filter': 'Filter',
  'order_placed': 'Order\nPlaced',
  'order_pickup': 'Order\nPickup',
  'order_delivery': 'Order\nDelivery',
  'order_eta': 'Your Order will be\ndelivery in 10 min.',
  'updated_ago': 'Updated 6 sec ago',
  'add_on': 'Add On',
  'home': 'Home',
  'cart': 'Cart',
  'continue': 'Continue',
  'welcome': 'Welcome',
  'slogan': 'Your Health Is Our Priority',
  'my_cart': 'My Cart',
  'enter_coupon': 'Enter Coupon Code',
  'qty': 'Qty',
  'total_items': 'Total Items',
  'sub_total': 'Sub Total',
  'platform_fee': 'Platform fee',
  'delivery_charge': 'Delivery charge',
  'total_payable': 'Total Payable',
  'checkout': 'Checkout',
  'delivery_address': 'Delivery address',
  'your_order': 'Your Order',
  'order_notes': 'Add notes about your order',
  'payment_method': 'Payment method',
  'voice_note': 'Voice Note',
  'stop': 'Stop',
  'proceed_to_pay': 'Proceed to Pay',
    'change_address': 'Change Address',
  'notifications': 'Notifications',
  'your_order_id': 'Your order ID:',
  'go_to_home': 'Go To Home',
  'profile': 'Profile',
  'account': 'Account',
  'personal_information': 'Personal Information',
  'order_history': 'Order History',
  'need_help': 'Need Help?',
  'contact_us': 'Contact Us',
  'logout': 'Logout',
  'name': 'Name',
  'mobile_number': 'Mobile Number',
  'email': 'Email',
  'save': 'Save',
  'ongoing': 'Ongoing',
  'cancel_order': 'Cancel Order',
  'navigate': 'Navigate',
},
'te': {
  'wish': 'హలో',
  'search_medicine': 'మీ మందును వెతకండి',
  'order_medicine': 'మీ మందులను ఆర్డర్ చేయండి!',
  'delivery_line': 'మేము మీ మందులను\nత్వరగా ఇంటికి తీసుకురాగలము',
  'order_now': 'ఇప్పుడే ఆర్డర్ చేయండి',
  'services': 'సేవలు',
  'categories': 'వర్గాలు',
  'see_all': 'అన్నీ చూడండి',
  'previous_orders': 'మునుపటి ఆర్డర్లు',
  'reorder': 'పునఃఆర్డర్',
  'details': 'వివరాలు',
  'periodic_plan': 'ఆవర్తన మందుల ప్లాన్',
  'periodic_meds': 'పునరావృత మందులు',
  'plan': 'ప్లాన్',
  'activate': 'సక్రియం చేయండి',
  'all_medicines': 'అన్ని మందులు',
  'filter': 'ఫిల్టర్',
  'order_placed': 'ఆర్డర్\nచేయబడింది',
  'order_pickup': 'ఆర్డర్\nపికప్',
  'order_delivery': 'ఆర్డర్\nడెలివరీ',
  'order_eta': 'మీ ఆర్డర్\n10 నిమిషాలలో డెలివరీ అవుతుంది.',
   'updated_ago': 'సెకన్ల క్రితం నవీకరించబడింది',
   'add_on': 'అడ్ ఆన్',
   'home': 'హోమ్',
  'cart': 'కార్ట్',
  'continue': 'కొనసాగించండి',
  'welcome': 'స్వాగతం',
  'slogan': 'మీ ఆరోగ్యం మా ప్రాధాన్యత',
    'my_cart': 'నా కార్ట్',
  'enter_coupon': 'కూపన్ కోడ్ నమోదు చేయండి',
  'qty': 'ప్రమాణం',
  'total_items': 'మొత్తం అంశాలు',
  'sub_total': 'ఉప మొత్తము',
  'platform_fee': 'ప్లాట్‌ఫారమ్ ఫీజు',
  'delivery_charge': 'డెలివరీ ఛార్జీ',
  'total_payable': 'మొత్తం చెల్లించాల్సింది',
  'checkout': 'చెకౌట్',
  'delivery_address': 'డెలివరీ చిరునామా',
  'your_order': 'మీ ఆర్డర్',
  'order_notes': 'మీ ఆర్డర్ గురించి గమనికలు జోడించండి',
  'payment_method': 'చెల్లింపు విధానం',
  'voice_note': 'వాయిస్ నోట్',
  'stop': 'ఆపు',
  'proceed_to_pay': 'చెల్లించడానికి కొనసాగించండి',
    'change_address': 'చిరునామా మార్చండి',
  'notifications': 'నోటిఫికేషన్‌లు',
  'your_order_id': 'మీ ఆర్డర్ ID:',
  'go_to_home': 'హోమ్‌కు వెళ్లండి',
  'profile': 'ప్రొఫైల్',
  'account': 'ఖాతా',
  'personal_information': 'వ్యక్తిగత సమాచారం',
  'order_history': 'ఆర్డర్ చరిత్ర',
  'need_help': 'సహాయం కావాలా?',
  'contact_us': 'మమ్మల్ని సంప్రదించండి',
  'logout': 'లాగ్ అవుట్',
  'name': 'పేరు',
  'mobile_number': 'మొబైల్ నంబర్',
  'email': 'ఇమెయిల్',
  'save': 'సేవ్ చేయండి',
  'ongoing': 'నడుస్తోంది',
   'cancel_order': 'ఆర్డర్ రద్దు చేయండి',
  'navigate': 'నావిగేట్ చేయండి',
},
'hi': {
  'wish': 'नमस्ते',
  'search_medicine': 'अपनी दवा खोजें',
  'order_medicine': 'अपनी दवा ऑर्डर करें!',
  'delivery_line': 'हम आपकी दवाएं\nबहुत जल्दी आपके घर पहुंचाते हैं',
  'order_now': 'अभी ऑर्डर करें',
  'services': 'सेवाएं',
  'categories': 'श्रेणियाँ',
  'see_all': 'सभी देखें',
  'previous_orders': 'पिछले ऑर्डर',
  'reorder': 'फिर से ऑर्डर करें',
  'details': 'विवरण',
  'periodic_plan': 'नियमित दवा योजना',
  'periodic_meds': 'आवधिक दवाएं',
  'plan': 'योजना',
  'activate': 'सक्रिय करें',
  'all_medicines': 'सभी दवाएं',
  'filter': 'फ़िल्टर',
  'order_placed': 'ऑर्डर\nकिया गया',
  'order_pickup': 'ऑर्डर\nपिकअप',
  'order_delivery': 'ऑर्डर\nडिलीवरी',
  'order_eta': 'आपका ऑर्डर\n10 मिनट में डिलीवर किया जाएगा।',
   'updated_ago': 'सेकंड पहले अपडेट किया गया',
   'add_on': 'ऐड ऑन',
   'home': 'होम',
  'cart': 'कार्ट',
  'continue': 'जारी रखें',
  'welcome': 'स्वागत है',
  'slogan': 'आपका स्वास्थ्य हमारी प्राथमिकता है',
    'my_cart': 'मेरा कार्ट',
  'enter_coupon': 'कूपन कोड दर्ज करें',
  'qty': 'मात्रा',
  'total_items': 'कुल आइटम',
  'sub_total': 'उप-योग',
  'platform_fee': 'प्लेटफ़ॉर्म शुल्क',
  'delivery_charge': 'डिलीवरी शुल्क',
  'total_payable': 'कुल देय राशि',
  'checkout': 'चेकआउट',
  'delivery_address': 'डिलीवरी पता',
  'your_order': 'आपका ऑर्डर',
  'order_notes': 'अपने ऑर्डर के बारे में नोट्स जोड़ें',
  'payment_method': 'भुगतान विधि',
  'voice_note': 'वॉयस नोट',
  'stop': 'रोकें',
  'proceed_to_pay': 'भुगतान करने के लिए आगे बढ़ें',
  'change_address': 'पता बदलें',
  'notifications': 'सूचनाएं',
  'your_order_id': 'आपका ऑर्डर ID:',
  'go_to_home': 'होम पर जाएं',
  'profile': 'प्रोफ़ाइल',
  'account': 'खाता',
  'personal_information': 'व्यक्तिगत जानकारी',
  'order_history': 'ऑर्डर इतिहास',
  'need_help': 'मदद चाहिए?',
  'contact_us': 'संपर्क करें',
  'logout': 'लॉगआउट',
  'name': 'नाम',
  'mobile_number': 'मोबाइल नंबर',
  'email': 'ईमेल',
  'save': 'सेव करें',
  'ongoing': 'चालू',
   'cancel_order': 'ऑर्डर रद्द करें',
  'navigate': 'नेविगेट करें',
}

  };

  static String translate(String key, String languageCode) {
    return _localizedStrings[languageCode]?[key] ??
        _localizedStrings['en']?[key] ??
        key;
  }
}

// 3. Create a translation helper widget (widgets/app_text.dart)

class AppText extends StatelessWidget {
  final String textKey;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  const AppText(
    this.textKey, {
    Key? key,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
  }) : super(key: key);

  static String translate(BuildContext context, String key) {
    final languageProvider =
        Provider.of<LanguageProvider>(context, listen: false);
    return LocalizationService.translate(
        key, languageProvider.locale.languageCode);
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final translatedText = LocalizationService.translate(
        textKey, languageProvider.locale.languageCode);

    return Text(
      translatedText,
      style: style,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}














