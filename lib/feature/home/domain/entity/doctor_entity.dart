class DoctorEntity {
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

  const DoctorEntity(
      this.patients, {
    required this.id,
    required this.name,
    required this.image,
    required this.speciality,
    required this.rating,
    required this.reviews,
    required this.price,
    required this.experienceYears,
    required this.isAvailable,
  });
}
