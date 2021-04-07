class EducationModel {
  bool isFilled;
  String uUID;
  List<Education> education;

  EducationModel({this.isFilled, this.uUID, this.education});

  EducationModel.fromJson(Map<String, dynamic> json) {
    isFilled = json['isFilled'] as bool;
    uUID = json['UUID'] as String;
    if (json['education'] != null) {
      education = <Education>[];
      json['education'].forEach((v) {
        education.add(Education.fromJson(v as Map<String, dynamic>));
      });
    }
  }
}

class Education {
  String id;
  String uUID;
  String description;
  String endDate;
  String startDate;
  String field;
  String logo;
  String name;
  String type;

  Education(
      {this.id,
      this.uUID,
      this.description,
      this.endDate,
      this.startDate,
      this.field,
      this.logo,
      this.name,
      this.type});

  Education.fromJson(Map<String, dynamic> json) {
    id = json['_id'] as String;
    uUID = json['UUID'] as String;
    description = json['description'] as String;
    endDate = json['endDate'] as String;
    startDate = json['startDate'] as String;
    field = json['field'] as String;
    logo = json['logo'] as String;
    name = json['name'] as String;
    type = json['type'] as String;
  }
}
