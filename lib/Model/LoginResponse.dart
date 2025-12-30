

class LoginResponse {
  final String token;
  final String firstname;
  final String lastname;
  final String phone;
  final String avatar ;


  LoginResponse({
    required this.token,
    required this.firstname,
    required this.lastname,
    required this.phone,
    required this.avatar
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      token: json['data']['token'],
      firstname: json['data']['first name'],
      lastname: json['data']['last name'],
      phone: json['data']['phone'],
      avatar: json['data']['avatar'],
    );
  }
}
