class BookedEntity {

  final String doctorName;
  final String day;
  final String time;

  BookedEntity({required this.doctorName, required this.day, required this.time});

  toMap(){
    return {
      'doctorName': doctorName,
      'day': day,
      'time': time,
    };
  }

}
