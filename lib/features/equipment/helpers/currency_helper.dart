class CurrencyHelper {
  static String getCurrencySymbol(String? countryIdentifier) {
    if (countryIdentifier == null) {
      return '€'; // Default symbol
    }
    switch (countryIdentifier) {
      case 'BD':
      case 'Bangladesh':
        return '৳';
      case 'IN':
      case 'India':
        return '₹';
      case 'US':
      case 'United States':
        return '\$';
      case 'GB':
      case 'United Kingdom':
        return '£';
      case 'CA':
      case 'Canada':
        return '\$';
      case 'AU':
      case 'Australia':
        return '\$';
      case 'DE':
      case 'Germany':
        return '€';
      case 'FR':
      case 'France':
        return '€';
      case 'IT':
      case 'Italy':
        return '€';
      case 'ES':
      case 'Spain':
        return '€';
      case 'JP':
      case 'Japan':
        return '¥';
      case 'CN':
      case 'China':
        return '¥';
      default:
        return '€';
    }
  }
}
