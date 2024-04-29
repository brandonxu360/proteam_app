import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:proteam_app/core/const/firebase_storage_const.dart';

class StorageProviderRemoteDataSource {
  static final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  // Upload the file to firebase storage bucket and return the url
  static Future<String> updateProfileImage(
      {required File file, required String uid}) async {


    final ref =
        _firebaseStorage.ref().child('${FirebaseStorageConst.pfp}/$uid');

    final uploadTask = ref.putData(
        await file.readAsBytes(), SettableMetadata(contentType: 'image/png'));

    final imageUrl =
        (await uploadTask.whenComplete(() {})).ref.getDownloadURL();

    return await imageUrl;
  }

  // Get the download URL of the profile image if it exists
  static Future<String?> getProfileImageUrl(String uid) async {
    try {
      final ref =
          _firebaseStorage.ref().child('${FirebaseStorageConst.pfp}/$uid');
      final downloadUrl = await ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      // Return null if the profile image doesn't exist
      return null;
    }
  }

  // Delete the profile image associated with the user
  static Future<void> deleteProfileImage(String uid) async {
    final ref =
        _firebaseStorage.ref().child('${FirebaseStorageConst.pfp}/$uid');
    await ref.delete();
  }
}
