import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:proteam_app/features/user/data/data_sources/user_remote_data_source.dart';
import 'package:proteam_app/features/user/data/data_sources/user_remote_data_source_impl.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late FakeFirebaseFirestore fakeFirebaseFirestore;
  late MockFirebaseAuth mockFirebaseAuth;

  late UserRemoteDataSource userRemoteDataSource;

  setUp(() {
    fakeFirebaseFirestore = FakeFirebaseFirestore();
    mockFirebaseAuth = MockFirebaseAuth();

    userRemoteDataSource = UserRemoteDataSourceImpl(
        firebaseAuth: mockFirebaseAuth,
        firebaseFirestore: fakeFirebaseFirestore);
  });

  group('sign in with email', () {
    const email = 'test@gmail.com';
    const password = 'testpassword';

    // registerWithEmail normal case - completes with void return
    test('should complete normally when call to [FirebaseAuth] is successful',
        () {
      // * Act and Assert

      // Assert that call completes successfully without any exceptions 
      expectLater(
        userRemoteDataSource.registerWithEmail(email, password),
        completes,
      );

      // Assert user has been automatically signed in as a successful registration
      expect(mockFirebaseAuth.currentUser, isNotNull);
      expect(mockFirebaseAuth.currentUser?.email, equals('test@gmail.com'));
    });
  });
}
