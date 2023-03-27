import 'package:archeland_encyclopedia/src/database/firebase/firestore_data_source.dart';
import 'package:archeland_encyclopedia/src/features/authentication/domain/app_user.dart';
import 'package:archeland_encyclopedia/src/utils/email_encryption.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AuthRepository {
  final FirebaseAuth _auth;
  final FirestoreDataSource _firestore;
  final accountFirestorePath = '/accounts';
  Future<AppUser?> get appUser => fetchAppUser();

  AuthRepository(this._auth, this._firestore);

  Stream<User?> authStateChanges() => _auth.authStateChanges();
  User? get currentUser => _auth.currentUser;

  // Todo: 로그인 기능
  Future<UserCredential> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? account = await googleSignIn.signIn();
    final GoogleSignInAuthentication? authentication =
        await account?.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
        idToken: authentication?.idToken,
        accessToken: authentication?.accessToken);
    return await _auth.signInWithCredential(credential);
  }

  Future<void> signInAnonymously() {
    return _auth.signInAnonymously();
  }

  Future<void> signOut() {
    return _auth.signOut();
  }

  Future<AppUser?> fetchAppUser() async {
    if (currentUser == null) return Future.value(null);
    final email = encodeEmail(currentUser!.email!);
    final result = await _firestore.fetchDocument<AppUser?>(
        path: '$accountFirestorePath/$email',
        builder: (data, documentId) {
          if (data != null) {
            return AppUser.fromJson(data);
          } else {
            return null;
          }
        });
    return result;
  }

  Future<bool> setAccount(String server, String username) async {
    if (currentUser == null) return Future.value(false);
    final email = currentUser!.email!;
    final appUser = AppUser(server: server, username: username);
    await _firestore.setData(
        path: '$accountFirestorePath/${encodeEmail(email)}',
        data: appUser.toJson());
    await Hive.box<String>('account').put('server', server);
    await Hive.box<String>('account').put('username', username);

    return Future.value(true);
  }
}

final firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

final authRepositoryProvider = Provider<AuthRepository>((ref) => AuthRepository(
    ref.watch(firebaseAuthProvider), ref.watch(firestoreDataSourceProvider)));

final authStateChangesProvider = Provider<Stream<User?>>(
    (ref) => ref.watch(authRepositoryProvider).authStateChanges());
