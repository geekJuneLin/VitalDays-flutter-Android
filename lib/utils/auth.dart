import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final _auth = FirebaseAuth.instance;

  // get the current user
  Stream<FirebaseUser> get user {
    return _auth.onAuthStateChanged;
  }

  Future<FirebaseUser> getCurrentUser() {
    return _auth.currentUser();
  }

  // sign in with email and password
  Future<FirebaseUser> signIn(String email, String pass) async {
    try {
      AuthResult result =
          await _auth.signInWithEmailAndPassword(email: email, password: pass);
      if (result != null) {
        return result.user;
      } else {
        return null;
      }
    } catch (e) {
      print("sign in with email and password with errors: $e");
    }
  }

  // sign out method
  void signOut() async {
    await _auth.signOut();
  }
}
