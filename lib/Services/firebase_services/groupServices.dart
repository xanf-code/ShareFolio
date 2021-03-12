import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_storage/firebase_storage.dart';

class groupServices {
  String groupID = Uuid().v4();

  Future createPublicGroup(groupName, groupBio, groupType, groupAdmin,
      groupAdminName, bannerImage, profileImage) async {
    await FirebaseFirestore.instance
        .collection("publicGroups")
        .doc(groupID)
        .set({
      "groupID": groupID,
      "groupName": groupName,
      "groupBio": groupBio,
      "groupType": groupType,
      "groupImage": profileImage ??
          "https://i.pinimg.com/originals/76/94/84/769484dafbe89bf2b8a22379658956c4.jpg",
      "groupBanner": bannerImage ??
          "https://www.mub.eps.manchester.ac.uk/graphene/wp-content/themes/uom-theme/assets/images/default-banner.jpg",
      "groupAdmin": groupAdmin,
      "groupAdminName": groupAdminName,
      "members": [],
    });
  }

  Future createPrivateGroup(groupName, groupBio, groupType, currentUser,
      groupAdminName, bannerImage, profileImage) async {
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
        "groupImage": profileImage,
        "groupBanner": bannerImage,
        "groupAdmin": currentUser,
        "groupAdminName": groupAdminName,
        "members": [],
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
}
