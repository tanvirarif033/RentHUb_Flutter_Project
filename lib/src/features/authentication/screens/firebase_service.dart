import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Create a user document in Firestore
  Future<void> createUser(String uid, String username, String email) async {
    await _firestore.collection('users').doc(uid).set({
      'uid': uid,
      'username': username,
      'email': email,
      'status': 'Online', // Initial status when creating the user
    });
  }

  // Update user status in Firestore
  Future<void> updateUserStatus(String uid, String status) async {
    await _firestore.collection('users').doc(uid).update({
      'status': status,
    });
  }

  // Example usage
  Future<void> exampleUsage() async {
    // Assuming user is logged in
    User? currentUser = _auth.currentUser;

    if (currentUser != null) {
      // Create a new user document (run this only once when a new user registers)
      await createUser(currentUser.uid, 'JohnDoe', 'john.doe@example.com');

      // Update user status (call this when user logs in, goes offline, etc.)
      await updateUserStatus(currentUser.uid, 'Online');

      // Retrieve user data (optional)
      DocumentSnapshot userSnapshot =
      await _firestore.collection('users').doc(currentUser.uid).get();
      Map<String, dynamic>? userData = userSnapshot.data() as Map<String, dynamic>?;

      if (userData != null) {
        print('User Data: $userData');
      } else {
        print('User not found');
      }
    }
  }
}

