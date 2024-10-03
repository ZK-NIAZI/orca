class ProfileModel {
  final String? id;
  final String name;
  final String gender;
  final String orientation;
  final String seeingInterest;
  final String about;
  final String relationship;
  final String age;
  final String? imageUrl;
  final List<String> intersets;

  ProfileModel({

    this.id,
    required this.name,
    required this.gender,
    required this.orientation,
    required this.seeingInterest,
    required this.about,
    required this.relationship,
    required this.age,
    this.imageUrl,
    required this.intersets,
  });

  // Convert a ProfileModel instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'gender': gender,
      'orientation': orientation,
      'seeingInterest': seeingInterest,
      'about': about,
      'relationship': relationship,
      'age': age,
      'imageUrl': imageUrl,
      'intersets': intersets,
    };
  }

  // Create a ProfileModel instance from a JSON map
  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      name: json['name'],
      gender: json['gender'],
      orientation: json['orientation'],
      seeingInterest: json['seeingInterest'],
      about: json['about'],
      relationship: json['relationship'],
      age: json['age'],
      imageUrl: json['imageUrl'],
      intersets: List<String>.from(json['intersets'],


      ),
    );
  }

}
