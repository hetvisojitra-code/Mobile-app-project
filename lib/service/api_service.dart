import 'dart:convert';

import 'package:http/http.dart' as http;

class CountryImage {
  CountryImage({
    required this.code,
    required this.name,
    required this.imageUrl,
  });

  final String code;
  final String name;
  final String imageUrl;

  factory CountryImage.fromJson(Map<String, dynamic> json) {
    final nameData = json['name'] as Map<String, dynamic>? ?? {};
    final flagsData = json['flags'] as Map<String, dynamic>? ?? {};

    return CountryImage(
      code: (json['cca2'] as String? ?? '').toUpperCase(),
      name: nameData['common'] as String? ?? '',
      imageUrl: flagsData['png'] as String? ?? '',
    );
  }
}

class ApiService {
  ApiService({http.Client? client}) : _client = client ?? http.Client();

  static const String _baseUrl = 'https://restcountries.com/v3.1';
  final http.Client _client;

  Future<List<CountryImage>> fetchCountryImagesByCodes(List<String> codes) async {
    if (codes.isEmpty) {
      return <CountryImage>[];
    }

    final normalizedCodes = codes.map((code) => code.trim().toLowerCase()).toList();
    final uri = Uri.parse(
      '$_baseUrl/alpha?codes=${normalizedCodes.join(',')}&fields=name,cca2,flags',
    );

    final response = await _client.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch countries: ${response.statusCode}');
    }

    final decoded = jsonDecode(response.body);
    if (decoded is! List) {
      return <CountryImage>[];
    }

    final countries = decoded
        .whereType<Map<String, dynamic>>()
        .map(CountryImage.fromJson)
        .toList();

    final byCode = <String, CountryImage>{
      for (final country in countries) country.code: country,
    };

    return codes
        .map((code) => byCode[code.toUpperCase()])
        .whereType<CountryImage>()
        .toList();
  }
}
