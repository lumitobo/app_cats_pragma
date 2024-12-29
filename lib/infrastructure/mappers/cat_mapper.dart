import 'package:CatsBreed/domain/entities/cat.dart';
import 'package:CatsBreed/infrastructure/models/cat_model.dart';

class CatNetworkMapper {

  static Cat cataModelToEntity(CatModel cataFirestore) => Cat(
    id: cataFirestore.id,
    name: cataFirestore.name,
    origin: cataFirestore.origin,
    countryCodes: cataFirestore.countryCodes,
    countryCode: cataFirestore.countryCode,
    description: cataFirestore.description,
    intelligence: cataFirestore.intelligence,
    referenceImageId: cataFirestore.referenceImageId,
    adaptability: cataFirestore.adaptability,
    lifeSpan: cataFirestore.lifeSpan
  );

}