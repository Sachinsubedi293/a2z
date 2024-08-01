import 'package:hive_flutter/hive_flutter.dart';

part 'profile_res_model.g.dart';

@HiveType(typeId: 1)
class ProfileResModel {
  @HiveField(0)
  String? email;
  
  @HiveField(1)
  String? firstName;
  
  @HiveField(2)
  String? lastName;
  
  @HiveField(3)
  String? avatar;
  
  @HiveField(4)
  String? bio;

  var accessToken;

  ProfileResModel({
    this.email,
    this.firstName,
    this.lastName,
    this.avatar,
    this.bio,
  });

  ProfileResModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    avatar = json['avatar'];
    bio = json['bio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['avatar'] = avatar;
    data['bio'] = bio;
    return data;
  }

  // Add copyWith method
  ProfileResModel copyWith({
    String? email,
    String? firstName,
    String? lastName,
    String? avatar,
    String? bio,
  }) {
    return ProfileResModel(
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      avatar: avatar ?? this.avatar,
      bio: bio ?? this.bio,
    );
  }
}
