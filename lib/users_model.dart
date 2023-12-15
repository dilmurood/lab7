class Users {
  final String firstName;
  final String lastName;
  final String email;
  final String pictureURL;

  Users({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.pictureURL,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      firstName: json['name']['first'],
      lastName: json['name']['last'],
      email: json['email'],
      pictureURL: json['picture']['thumbnail'],
    );
  }
}