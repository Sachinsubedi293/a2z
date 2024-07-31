class RegisterModel {
  final String email;
  final String password;
  final bool allowMail;

  RegisterModel({required this.email, required this.password, required this.allowMail});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'allow_mail': allowMail,
    };
  }
}
