import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LogoutScreen extends StatelessWidget {
  const LogoutScreen({Key? key}) : super(key: key);

  Future<void> _signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, 'LogIn'); // Replace '/login' with your actual login route
  }

  void _showConfirmationSnackbar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('Confirm logout'),
      action: SnackBarAction(
        label: 'Yes',
        onPressed: () => _signOut(context),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Log Out',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _showConfirmationSnackbar(context),
          child: Text('Logout'),
        ),
      ),
    );
  }
}
