

class LoginResponse {
  final String token;
  final String firstname;
  final String lastname;
  final String phone;
  final String? avatar ;


  LoginResponse({
    required this.token,
    required this.firstname,
    required this.lastname,
    required this.phone,
     this.avatar
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      token: json['access_token'],
      firstname: json['user']['first_name'],
      lastname: json['user']['last_name'],
      phone: json['user']['phone'],
      avatar: json['user']['avatar'],
    );
  }
}
