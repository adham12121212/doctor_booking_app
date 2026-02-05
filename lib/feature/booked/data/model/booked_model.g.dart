// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booked_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookedModel _$BookedModelFromJson(Map<String, dynamic> json) => BookedModel(
  doctorName: json['doctorName'] as String,
  day: json['day'] as String,
  time: json['time'] as String,
  image: json['image'] as String,
  patientUid: json['patientUid'] as String,
  doctorUid: json['doctorUid'] as String,
  patientName: json['patientName'] as String,
);

Map<String, dynamic> _$BookedModelToJson(BookedModel instance) =>
    <String, dynamic>{
      'image': instance.image,
      'doctorName': instance.doctorName,
      'patientName': instance.patientName,
      'day': instance.day,
      'time': instance.time,
      'patientUid': instance.patientUid,
      'doctorUid': instance.doctorUid,
    };
