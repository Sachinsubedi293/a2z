class ProfileModel {
  final String email;
  final String first_name;
  final String last_name;
  final String bio;
  final String? avatar; 

  ProfileModel({
    required this.email,
    required this.first_name,
    required this.last_name,
    required this.bio,
    this.avatar,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'first_name': first_name,
      'last_name': last_name,
      'bio': bio,
      'avatar': avatar, 
    };
  }

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      email: json['email'] as String,
      first_name: json['first_name'] as String,
      last_name: json['last_name'] as String,
      bio: json['bio'] as String,
      avatar: json['avatar'] as String?,
    );
  }

  ProfileModel copyWith({
    String? email,
    String? firstName,
    String? lastName,
    String? avatar,
    String? bio,
  }) {
    return ProfileModel(
      email: email ?? this.email,
      first_name: firstName ?? first_name,
      last_name: lastName ?? last_name,
      avatar: avatar ?? this.avatar,
      bio: bio ?? this.bio,
    );
  }
}
