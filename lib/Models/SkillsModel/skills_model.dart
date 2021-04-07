class SkillsModel {
  bool isFilled;
  String uUID;
  List<String> skills;

  SkillsModel({this.isFilled, this.uUID, this.skills});

  SkillsModel.fromJson(Map<String, dynamic> json) {
    isFilled = json['isFilled'] as bool;
    uUID = json['UUID'] as String;
    skills = json['skills'].cast<String>() as List<String>;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isFilled'] = isFilled;
    data['UUID'] = uUID;
    data['skills'] = skills;
    return data;
  }
}
