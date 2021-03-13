import 'package:cloud_firestore/cloud_firestore.dart';

class GroupModel {
  Timestamp timestamp;
  String groupAdmin;
  String groupAdminName;
  String groupBanner;
  String groupBio;
  String groupID;
  String groupImage;
  String groupName;
  String groupType;
  dynamic members;
  String tags;

  GroupModel({
    this.timestamp,
    this.groupAdmin,
    this.groupAdminName,
    this.groupBanner,
    this.groupBio,
    this.groupID,
    this.groupImage,
    this.groupName,
    this.groupType,
    this.members,
    this.tags,
  });

  Map<String, dynamic> toJson() => {
        'Timestamp': timestamp,
        'groupAdmin': groupAdmin,
        'groupAdminName': groupAdminName,
        'groupBanner': groupBanner,
        'groupBio': groupBio,
        'groupID': groupID,
        'groupImage': groupImage,
        'groupName': groupName,
        'groupType': groupType,
        'members': members,
        'tag': tags,
      };

  GroupModel.fromSnapshot(DocumentSnapshot snapshot)
      : timestamp = snapshot['TimeStamp'],
        groupAdmin = snapshot['groupAdmin'],
        groupAdminName = snapshot['groupAdminName'],
        groupBanner = snapshot['groupBanner'],
        groupBio = snapshot['groupBio'],
        groupID = snapshot['groupID'],
        groupImage = snapshot['groupImage'],
        groupName = snapshot['groupName'],
        groupType = snapshot['groupType'],
        members = snapshot['members'],
        tags = snapshot['tags'];
}
