import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rent_hub_flutter_project/src/features/authentication/screens/toast.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> signUpWithEmailAndPassword(
      String username, String email, String password) async {
    try {
      UserCredential credential =
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      credential.user!.updateDisplayName(username);

      await _firestore.collection('users').doc(_auth.currentUser!.uid).set({
        "username": username,
        "email": email,
        "status": "Unavailable",
        "uid": _auth.currentUser!.uid,
      });
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        showToast(message: 'The email address is already in use');
      } else {
        showToast(message: 'An error occurred: ${e.code}');
      }
      return null;
    }
  }

  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential =
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      var userDocument = await _firestore.collection('users').doc(_auth.currentUser!.uid).get();

      credential.user!.updateDisplayName(userDocument['username']);

      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        showToast(message: "Invalid email or password");
      } else {
        showToast(message: 'An error occurred: ${e.code}');
      }
      return null;
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}