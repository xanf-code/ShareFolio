import 'dart:io';
import 'dart:math';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class UtilsService {
  Future<String> uploadFile(File _image, String path) async {
    final firebase_storage.Reference storageReference =
        firebase_storage.FirebaseStorage.instance.ref(path);

    final firebase_storage.UploadTask uploadTask =
        storageReference.putFile(_image);

    await uploadTask.whenComplete(() => null);
    String returnURL = '';
    await storageReference.getDownloadURL().then((fileURL) {
      returnURL = fileURL;
    });
    return returnURL;
  }

  Future<File> urlToFile(String imageUrl) async {
    final rng = Random();
    final Directory tempDir = await getTemporaryDirectory();
    final String tempPath = tempDir.path;
    final File file =
        File('$tempPath' + (rng.nextInt(100)).toString() + '.png');
    final http.Response response = await http.get(Uri.parse(imageUrl));
    await file.writeAsBytes(response.bodyBytes);
    return file;
  }
}
