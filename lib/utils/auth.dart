import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthBase {
  Future<FirebaseUser> signIn(String email, String password);
  Future<FirebaseUser> signUp(String email, String password);
  Future<FirebaseUser> getCurrent();
  Future<void> signOut();
}

class Auth implements AuthBase {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Future<FirebaseUser> getCurrent() {
    return auth.currentUser();
  }

  @override
  Future<FirebaseUser> signIn(String email, String password) async {
    FirebaseUser user = (await auth.signInWithEmailAndPassword(
            email: email, password: password))
        .user;
    return user;
  }

  @override
  Future<void> signOut() {
    return auth.signOut();
  }

  @override
  Future<FirebaseUser> signUp(String email, String password) async {
    FirebaseUser user = (await auth.createUserWithEmailAndPassword(
            email: email, password: password))
        .user;
    return user;
  }
}
