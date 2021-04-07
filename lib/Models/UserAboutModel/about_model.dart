class AboutModel {
  bool isFilled;
  String name;
  String type;
  String bio;
  String location;
  String id;
  String uUID;

  AboutModel(
      {this.isFilled,
      this.name,
      this.type,
      this.bio,
      this.location,
      this.id,
      this.uUID});

  AboutModel.fromJson(Map<String, dynamic> json) {
    isFilled = json['isFilled'] as bool;
    name = json['Name'] as String;
    type = json['Type'] as String;
    bio = json['Bio'] as String;
    location = json['Location'] as String;
    id = json['_id'] as String;
    uUID = json['UUID'] as String;
  }
}
