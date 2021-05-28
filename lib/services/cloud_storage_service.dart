import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class CloudStorageService {
  static CloudStorageService instance = CloudStorageService();
  late FirebaseStorage _storage;

  CloudStorageService() {
    _storage = FirebaseStorage.instance;
  }

  Future<String?> uploadToStorage(File file) async {
    late String fileFormat;
    List<String> splitList = file.path.toString().split('.');
    fileFormat = splitList[splitList.length - 1];
    late String imageURL;
    Reference reference = _storage.ref("uploads").child(
        "${DateTime.now().millisecondsSinceEpoch.toString()}.$fileFormat");
    UploadTask uploadTask = reference.putFile(file);

    uploadTask.whenComplete(() async {
      try {
        imageURL = await reference.getDownloadURL();
      } catch (onError) {
        print(onError);
      }
    });
    return imageURL;
  }
}
