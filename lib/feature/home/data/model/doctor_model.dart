import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entity/doctor_entity.dart';

part 'doctor_model.g.dart';

@JsonSerializable()
class DoctorModel {
  final int id;
  final String name;
  final String image;
  final String speciality;
  final double rating;
  final int reviews;
  final double price;
  final int experienceYears;
  final bool isAvailable;
  final int patients;

  const DoctorModel({
    required this.id,
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

  factory DoctorModel.fromJson(Map<String, dynamic> json) =>
      _$DoctorModelFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorModelToJson(this);

  factory DoctorModel.fromFirestore(
      Map<String, dynamic> json,
      int docId,
      ) {
    return DoctorModel(
      id: docId,
      name: json['name'],
      image: json['image'],
      speciality: json['speciality'],
      rating: (json['rating'] as num).toDouble(),
      reviews: json['reviews'],
      price: (json['price'] as num).toDouble(),
      experienceYears: json['experienceYears'],
      isAvailable: json['isAvailable'],
      patients: json['patients'],
    );
  }


  /// Convert Model → Entity
  DoctorEntity toEntity() {
    return DoctorEntity(
      id: id,
      name: name,
      image: image,
      speciality: speciality,
      rating: rating,
      reviews: reviews,
      price: price,
      experienceYears: experienceYears,
      isAvailable: isAvailable,
      patients,
    );
  }





}
