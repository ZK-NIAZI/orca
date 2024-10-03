class SignUpModel {
  final String? id;
  final String name;
  final String email;
  final String password;

  SignUpModel({
    required this.name,
    required this.email,
    required this.password,
    this.id
  });

  // Convert SignUpModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'id': id,
    };
  }

  // Create SignUpModel from JSON
  factory SignUpModel.fromJson(Map<String, dynamic> json) {
    return SignUpModel(
      name: json['name'],
      email: json['email'],
      password: json['password'],
      id: json['id'],
    );
  }

  static SignUpModel empty =
      SignUpModel(name: '', email: '', password: '',id: '');
}
