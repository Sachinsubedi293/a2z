class ProfileEntity {
  final String email;
  final String first_name;
  final String last_name;
  final String bio;
  final String? avatar;

  ProfileEntity({
    required this.email,
    required this.first_name,
    required this.last_name,
    required this.bio,
    this.avatar,
  });
}
