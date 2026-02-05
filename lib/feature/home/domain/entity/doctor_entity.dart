
class DoctorEntity {
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



  DoctorEntity(
      {
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



}
