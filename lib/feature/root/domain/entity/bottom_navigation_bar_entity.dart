class BottomNavigationBarEntity {
  final String activeImage, inactiveImage;
  final String name;
  BottomNavigationBarEntity({
    required this.activeImage,
    required this.inactiveImage,
    required this.name,
  });
}

List<BottomNavigationBarEntity> bottomNavigationBarEntity = [
  BottomNavigationBarEntity(
    activeImage: 'assets/bottom_nav_icons/home-fill.svg',
    inactiveImage: 'assets/bottom_nav_icons/home-fill.svg',
    name: 'Home',
  ),
  BottomNavigationBarEntity(
    activeImage: 'assets/bottom_nav_icons/saved.svg',
    inactiveImage: 'assets/bottom_nav_icons/saved.svg',
    name: 'Appointment',
  ),
  BottomNavigationBarEntity(
    activeImage: 'assets/bottom_nav_icons/profile.svg',
    inactiveImage: 'assets/bottom_nav_icons/profile.svg',
    name: 'Settings',
  ),
];
