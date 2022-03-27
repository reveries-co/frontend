import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:reveries_app/models/user.dart' as models;

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  models.User? _userFromFirebase(User? user) {
    if (user == null) {
      return null;
    }
    return models.User(user.uid, user.email);
  }

  models.User? get user {
    return _userFromFirebase(_firebaseAuth.currentUser);
  }

  Future<models.User?> signInWithEmailAndPassword(
      String email, String password) async {
    final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return _userFromFirebase(credential.user);
  }

  Future<models.User?> createUserWithEmailAndPassword(
      String email, String password) async {
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);

    return _userFromFirebase(credential.user);
  }

  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }

  Future<models.User?> authenticateWithGoogle(
      GoogleSignInAccount googleUser) async {
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final googleCredential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final UserCredential googleUserCredential =
        await FirebaseAuth.instance.signInWithCredential(googleCredential);
    return _userFromFirebase(googleUserCredential.user);
  }
}
