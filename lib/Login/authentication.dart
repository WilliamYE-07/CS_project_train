import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  get user => _auth.currentUser;
  get uid => user.uid;

  get currentUser => user;

  String getUID() {
    return user.uid;
  }

  Future signOut() async {
    await _auth.signOut();
  }
}