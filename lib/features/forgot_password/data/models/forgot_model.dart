class ForgotModel {
  final String email;

  ForgotModel({required this.email});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
    };
  }
}
