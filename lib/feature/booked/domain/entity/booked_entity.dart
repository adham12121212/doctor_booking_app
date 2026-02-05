class BookedEntity {
  final String image;
  final String doctorName;
  final String patientName;
  final String day;
  final String time;
  final String patientUid;
  final String doctorUid;

  BookedEntity({
    required this.image,
    required this.doctorName,
    required this.day,
    required this.time,
    required this.patientUid,
    required this.doctorUid,
    required this.patientName
  });

  toMap() {
    return {
      'image': image,
      'doctorName': doctorName,
      'day': day,
      'time': time,
      'patientUid': patientUid,
      'doctorUid': doctorUid,
      'patientName':patientName
    };
  }
}
