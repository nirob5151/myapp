
class LocationService {
  final Map<String, List<String>> _divisions = {
    'Bangladesh': [
      'Barisal',
      'Chittagong',
      'Dhaka',
      'Khulna',
      'Mymensingh',
      'Rajshahi',
      'Rangpur',
      'Sylhet',
    ],
    'India': [
      'Andhra Pradesh',
      'Arunachal Pradesh',
      'Assam',
      'Bihar',
      'Chhattisgarh',
      'Goa',
      'Gujarat',
      'Haryana',
      'Himachal Pradesh',
      'Jharkhand',
      'Karnataka',
      'Kerala',
      'Madhya Pradesh',
      'Maharashtra',
      'Manipur',
      'Meghalaya',
      'Mizoram',
      'Nagaland',
      'Odisha',
      'Punjab',
      'Rajasthan',
      'Sikkim',
      'Tamil Nadu',
      'Telangana',
      'Tripura',
      'Uttar Pradesh',
      'Uttarakhand',
      'West Bengal',
    ],
  };

  List<String> getCountries() {
    return _divisions.keys.toList();
  }

  List<String> getDivisions(String country) {
    return _divisions[country] ?? [];
  }
}
