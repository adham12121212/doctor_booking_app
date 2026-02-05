// =========================
// doctor_model.dart
// =========================
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entity/doctor_entity.dart';

part 'doctor_model.g.dart';

@JsonSerializable()
class DoctorModel {
  final String uid;
  final String name;
  final String image;
  final String speciality;
  final double rating;
  final int reviews;
  final double price;
  final int experienceYears;
  final bool isAvailable;
  final int patients;
  final String aboutText;


  const DoctorModel({
    required this.aboutText,
    required this.uid,
    required this.name,
    required this.image,
    required this.speciality,
    required this.rating,
    required this.reviews,
    required this.price,
    required this.experienceYears,
    required this.isAvailable,
    required this.patients,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) => _$DoctorModelFromJson(json);
  Map<String, dynamic> toJson() => _$DoctorModelToJson(this);

  /// Firestore docId is uid
  factory DoctorModel.fromFirestore(Map<String, dynamic> json, String uid) {
    return DoctorModel(
      uid: uid,
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      speciality: json['speciality'] ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      reviews: (json['reviews'] as num?)?.toInt() ?? 0,
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      experienceYears: (json['experienceYears'] as num?)?.toInt() ?? 0,
      isAvailable: json['isAvailable'] ?? true,
      patients: (json['patients'] as num?)?.toInt() ?? 0,
      aboutText:json['aboutText'] ?? ''
    );
  }

  DoctorEntity toEntity() => DoctorEntity(
    uid: uid,
    name: name,
    image: image,
    speciality: speciality,
    rating: rating,
    reviews: reviews,
    price: price,
    experienceYears: experienceYears,
    isAvailable: isAvailable,
    patients: patients,
    aboutText: aboutText
  );

  factory DoctorModel.fromEntity(DoctorEntity d) => DoctorModel(
    uid: d.uid,
    name: d.name,
    image: d.image,
    speciality: d.speciality,
    rating: d.rating,
    reviews: d.reviews,
    price: d.price,
    experienceYears: d.experienceYears,
    isAvailable: d.isAvailable,
    patients: d.patients,
    aboutText: d.aboutText
  );

  toMap(){
    return{
      'uid':uid,
      'aboutText':aboutText,
      'name':name,
      'image':image,
      'speciality':speciality,
      'rating':rating,
      'reviews':reviews,
      'price':price,
      'experienceYears':experienceYears,
      'isAvailable':isAvailable,
      'patients':patients,};
  }

}
