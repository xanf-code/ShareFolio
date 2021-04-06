class UserDataModel {
  bool isFilled;
  String name;
  String type;
  String bio;
  String location;
  String sId;
  String uUID;

  UserDataModel(
      {this.isFilled,
      this.name,
      this.type,
      this.bio,
      this.location,
      this.sId,
      this.uUID});

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      isFilled: json['isFilled'] as bool,
      name: json['Name'] as String,
      type: json['Type'] as String,
      bio: json['Bio'] as String,
      location: json['Location'] as String,
      sId: json['_id'] as String,
      uUID: json['UUID'] as String,
    );
  }
}
