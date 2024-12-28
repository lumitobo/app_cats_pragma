

class CatModel {
  final String id;
  final String name;
  final String? referenceImageId;
  final String origin;
  final String countryCodes;
  final String countryCode;
  final String description;
  final int intelligence;
  final String? lifeSpan;
  final int? adaptability;

  CatModel({
    required this.id,
    required this.name,
    required this.origin,
    required this.countryCodes,
    required this.countryCode,
    required this.description,
    required this.intelligence,
    required this.referenceImageId,
    required this.adaptability,
    required this.lifeSpan
  });

  factory CatModel.fromJson(Map<String, dynamic> json) => CatModel(
    id: json['id'] ?? '',
    origin: json['origin'] ?? '',
    name: json['name'] ?? '',
    countryCode: json['countryCode'] ?? '',
    countryCodes: json['countryCodes'] ?? '',
    description: json['description'] ?? '',
    intelligence: json['intelligence'] ?? 0,
    lifeSpan: json['life_span'] ?? '',
    adaptability: json['adaptability'] ?? 0,
    referenceImageId: json["reference_image_id"],
  );

}


