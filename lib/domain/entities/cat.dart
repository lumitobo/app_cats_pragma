
class Cat {
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

  const Cat({
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

  String get getImage {

    if(referenceImageId != null){
      return 'https://cdn2.thecatapi.com/images/$referenceImageId.jpg';
    }
    else{
      return 'https://images.pexels.com/photos/45201/kitty-cat-kitten-pet-45201.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1';
    }

  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'countryCode': countryCode,
      'description': description,
      'intelligence': intelligence,
      'origin': origin,
      'countryCodes': countryCodes,
      'life_span': lifeSpan,
      'adaptability': adaptability,
      'reference_image_id': referenceImageId
    };
  }
}
