class SignUpResponse {
  // final String token;
  final String firstname;
  final String lastname;
  final String phone;
  final String birth;
  final String? avatar ;

  SignUpResponse({
    this.avatar,
    // required this.token,
    required this.firstname,
    required this.lastname, required this.phone,
    required this.birth
  });

  factory SignUpResponse.fromJson(Map<String, dynamic> json) {
    return SignUpResponse(
      // token: json['access_token'],
      firstname: json['user']['first_name'],
      lastname: json['user']['last_name'],
      phone: json['user']['phone'],
      avatar: json['user']['avatar'],
      birth: json['user']['date_of_birth']
    );
  }
}
