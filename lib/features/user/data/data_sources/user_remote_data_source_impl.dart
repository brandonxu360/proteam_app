import 'package:proteam_app/core/const/firebase_collection_const.dart';
import 'package:proteam_app/features/user/data/data_sources/user_remote_data_source.dart';
import 'package:proteam_app/features/user/data/models/user_model.dart';
import 'package:proteam_app/features/user/domain/entities/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Remote data source for users - uses firebase auth and firebase firestore
class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  // Firebase instances to interact with
  FirebaseAuth firebaseAuth;
  FirebaseFirestore firebaseFirestore;

  UserRemoteDataSourceImpl(
      {required this.firebaseAuth, required this.firebaseFirestore});

  // Create a user in the firebase firestore users collection using the UserEntity input
  // UID will be used as the user document path
  @override
  Future<void> createUser(UserEntity user) async {
    // Get the collection for users
    final userCollection =
        firebaseFirestore.collection(FirebaseCollectionConst.users);

    // Convert user entity to user model
    final newUser = UserModel(
            uid: user.uid,
            username: user.username,
            email: user.email,
            pfpUrl: user.pfpUrl)
        .toDocument();

    // Try to update or create user in collection
    try {
      userCollection.doc(user.uid).get().then((userDoc) {
        if (!userDoc.exists) {
          userCollection.doc(user.uid).set(newUser);
        } else {
          userCollection.doc(user.uid).update(newUser);
        }
      });
    } catch (e) {
      throw Exception('Error occurred while creating user');
    }
  }

  @override
  Future<String> getCurrentUID() async {
    return firebaseAuth.currentUser!.uid;
  }

  @override
  Future<UserEntity> getSingleUser(String uid) async {
    // Get the user of the input uid
    final userSnapshot = await firebaseFirestore
        .collection(FirebaseCollectionConst.users)
        .doc(uid)
        .get();

    if (userSnapshot.exists) {
      // Map the user document to a user model
      return UserModel.fromSnapshot(userSnapshot);
    } else {
      throw Exception('User document not found');
    }
  }

  @override
  Future<String?> isSignedIn() async {
    return firebaseAuth.currentUser?.uid;
  }

  // Attempt sign in with email and password
  @override
  Future<String> signInWithEmail(String email, String password) async {
    try {
      // Try sign in through firebase auth
      final cred = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      // Return the uid of the user that was signed in
      return cred.user!.uid;
    }
    // Auth Exceptions - wrong credentials, account doesn't exist, etc
    on FirebaseAuthException {
      rethrow;
    }

    // General exceptions - something unexpected went wrong with firebase
    catch (e) {
      throw Exception('Unknown server error encountered');
    }
  }

  @override
  Future<void> signOut() {
    return firebaseAuth.signOut();
  }

  @override
  Future<String> registerWithEmail(String email, String password) async {
    try {
      final credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Return the uid
      return credential.user!.uid;
    }
    // Auth exceptions - email already in use, etc.
    on FirebaseAuthException {
      rethrow;

      // General exceptions - something unexpected went wrong with firebase
    } catch (e) {
      throw Exception('Unknown server error encountered');
    }
  }

  @override
  Future<void> updateUser(UserEntity user) async {
    // Get the collection for users
    final userCollection =
        firebaseFirestore.collection(FirebaseCollectionConst.users);

    Map<String, dynamic> userInfo = {};

    if (user.username != '') {
      userInfo['username'] = user.username;
    }

    if (user.pfpUrl != '' && user.pfpUrl != null) {
      userInfo['pfpUrl'] = user.pfpUrl;
    }

    userCollection.doc(user.uid).update(userInfo);
  }
}
