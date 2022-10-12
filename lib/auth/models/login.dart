class Login {

  String email;
  String password;
  String token;

  Login({
    required this.email,
    required this.password,
    required this.token,
  });

  factory Login.fromJson(Map<String, dynamic> json) => Login(
        email: json["email"],
        password: json["password"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "token": token,
      };
}