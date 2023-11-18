import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageMethods {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future<String> uploadImageToStorage(
      Uint8List image, String name, bool isPost) async {
    Reference reference = _firebaseStorage
        .ref()
        .child(name)
        .child(_firebaseAuth.currentUser!.uid);
    UploadTask uploadTask = reference.putData(image);
    TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);

    String downloadUrl = await snapshot.ref.getDownloadURL();

    return downloadUrl;
  }
}
