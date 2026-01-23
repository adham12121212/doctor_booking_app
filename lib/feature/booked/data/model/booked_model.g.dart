// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booked_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookedModel _$BookedModelFromJson(Map<String, dynamic> json) => BookedModel(
  doctorName: json['doctorName'] as String,
  day: json['day'] as String,
  time: json['time'] as String,
);

Map<String, dynamic> _$BookedModelToJson(BookedModel instance) =>
    <String, dynamic>{
      'doctorName': instance.doctorName,
      'day': instance.day,
      'time': instance.time,
    };
