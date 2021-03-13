import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_storage/firebase_storage.dart';

class groupServices {
  String groupID = Uuid().v4();

  Future createPublicGroup(groupName, groupBio, groupType, groupAdmin,
      groupAdminName, bannerImage, profileImage, tags) async {
    await FirebaseFirestore.instance
        .collection("publicGroups")
        .doc(groupID)
        .set({
      "groupID": groupID,
      "groupName": groupName,
      "groupBio": groupBio,
      "groupType": groupType,
      "TimeStamp": Timestamp.now(),
      "groupImage": profileImage,
      "groupBanner": bannerImage,
      "groupAdmin": groupAdmin,
      "groupAdminName": groupAdminName,
      "members": [],
      "tag": tags,
    });
  }

  Future createPrivateGroup(groupName, groupBio, groupType, currentUser,
      groupAdminName, bannerImage, profileImage, tags) async {
    DocumentSnapshot docs = await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser)
        .get();
    if (docs.exists) {
      docs.reference.collection("groups").doc(groupID).set({
        "groupID": groupID,
        "groupName": groupName,
        "groupBio": groupBio,
        "groupType": groupType,
        "TimeStamp": Timestamp.now(),
        "groupImage": profileImage,
        "groupBanner": bannerImage,
        "groupAdmin": currentUser,
        "groupAdminName": groupAdminName,
        "members": [],
        "tag": tags,
      });
    }
  }

  // Image Download url
  String imageID = Uuid().v4();
  Future<String> uploadImage(
    mImageFile,
  ) async {
    UploadTask mStorageUploadTask = FirebaseStorage.instance
        .ref("groupBanner")
        .child("post_$imageID.jpg")
        .putFile(mImageFile);
    TaskSnapshot storageTaskSnapshot = await mStorageUploadTask;
    return await storageTaskSnapshot.ref.getDownloadURL();
  }

  Stream<QuerySnapshot> getPublicGroups(context) async* {
    yield* FirebaseFirestore.instance
        .collection("publicGroups")
        .orderBy('TimeStamp', descending: true)
        .snapshots();
  }
}
