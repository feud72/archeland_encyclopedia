import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  final FirebaseAuth _auth;

  AuthRepository(this._auth);

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
}

final firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

final authRepositoryProvider = Provider<AuthRepository>(
    (ref) => AuthRepository(ref.watch(firebaseAuthProvider)));

final authStateChangesProvider = Provider<Stream<User?>>(
    (ref) => ref.watch(authRepositoryProvider).authStateChanges());
