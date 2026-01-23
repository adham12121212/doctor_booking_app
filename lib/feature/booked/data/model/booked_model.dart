
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entity/booked_entity.dart';
part 'booked_model.g.dart';

@JsonSerializable()
class BookedModel extends BookedEntity{

  BookedModel({required super.doctorName, required super.day, required super.time});

   factory BookedModel.fromJson(Map<String, dynamic> json) =>
      _$BookedModelFromJson(json);

   Map<String, dynamic> toJson() => _$BookedModelToJson(this);

  factory BookedModel.fromEntity(BookedEntity entity) => BookedModel(
    doctorName: entity.doctorName,
    day: entity.day,
    time: entity.time,
  );


  BookedEntity toEntity() => BookedEntity(
    doctorName: doctorName,
    day: day,
    time: time,
  );


}