class CurrencyHelper {
  static String getCurrencySymbol(String countryCode) {
    switch (countryCode) {
      case 'BD':
        return '৳';
      case 'US':
        return '\$';
      case 'GB':
        return '£';
      case 'CA':
        return '\$';
      case 'AU':
        return '\$';
      case 'DE':
        return '€';
      case 'FR':
        return '€';
      case 'IT':
        return '€';
      case 'ES':
        return '€';
      case 'JP':
        return '¥';
      case 'CN':
        return '¥';
      case 'IN':
        return '₹';
      default:
        return '€';
    }
  }
}
