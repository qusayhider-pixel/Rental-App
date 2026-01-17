class ProfileModel {
  final String name;
  final String avatar;
  final String dateOfBirth;
  final String phone;
  final int numberOfProperties;
  final int numberOfReservations;

  ProfileModel({
    required this.name,
    required this.avatar,
    required this.dateOfBirth,
    required this.phone,
    required this.numberOfProperties,
    required this.numberOfReservations,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      name: json['name'],
      avatar: json['avatar'],
      dateOfBirth: json['date_of_birth'],
      phone: json['phone'],
      numberOfProperties: json['number_of_properties'],
      numberOfReservations: json['number_of_rented_properties'],
    );
  }
}
