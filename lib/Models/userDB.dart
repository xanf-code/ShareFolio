class UserModel {
  String name;
  String email;
  String uid;
  String profileImage;
  String status;

  UserModel({
    this.name,
    this.email,
    this.uid,
    this.profileImage,
    this.status,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'uid': uid,
        'profileImage': profileImage,
        'status': status,
      };
}
