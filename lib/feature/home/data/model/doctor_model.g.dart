// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoctorModel _$DoctorModelFromJson(Map<String, dynamic> json) => DoctorModel(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  image: json['image'] as String,
  speciality: json['speciality'] as String,
  rating: (json['rating'] as num).toDouble(),
  reviews: (json['reviews'] as num).toInt(),
  price: (json['price'] as num).toDouble(),
  experienceYears: (json['experienceYears'] as num).toInt(),
  isAvailable: json['isAvailable'] as bool,
  patients: (json['patients'] as num).toInt(),
);

Map<String, dynamic> _$DoctorModelToJson(DoctorModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'speciality': instance.speciality,
      'rating': instance.rating,
      'reviews': instance.reviews,
      'price': instance.price,
      'experienceYears': instance.experienceYears,
      'isAvailable': instance.isAvailable,
      'patients': instance.patients,
    };
