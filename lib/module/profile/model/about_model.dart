class AboutModel {
  final String about;
  final String relationship;
  final String age;

  AboutModel({
    required this.about,
    required this.relationship,
    required this.age,
  });

  // Convert a JSON map to an AboutModel instance
  factory AboutModel.fromJson(Map<String, dynamic> json) {
    return AboutModel(
      about: json['about'] as String,
      relationship: json['relationship'] as String,
      age: json['age'] as String,
    );
  }

  // Convert an AboutModel instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'about': about,
      'relationship': relationship,
      'age': age,
    };
  }
}
