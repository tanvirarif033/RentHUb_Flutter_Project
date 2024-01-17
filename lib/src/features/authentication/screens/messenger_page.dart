import 'package:flutter/material.dart';
import 'package:rent_hub_flutter_project/src/features/authentication/screens/chat_service.dart';
import 'package:rent_hub_flutter_project/src/features/authentication/screens/firebase_auth_services.dart';

class MessengerPage extends StatefulWidget {
  MessengerPage({Key? key}) : super(key: key);

  final ChatService _chatService = ChatService();
  final FirebaseAuthService _authService = FirebaseAuthService();

  @override
  State<MessengerPage> createState() => _MessengerPageState();
}

class _MessengerPageState extends State<MessengerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
      stream: widget._chatService.getUserStream(),
      builder: (context, AsyncSnapshot<List<UserData>> snapshot) {
        if (snapshot.hasError) {
          return const Text("Error");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading...");
        }
        List<UserData> userDataList = snapshot.data!;

        return ListView(
          children: userDataList.map<Widget>((userData) => _buildUserListItem(userData)).toList(),
        );
      },
    );
  }

  Widget _buildUserListItem(Map<String,dynamic>userData,BuildContext context) {
    return ListTile(
      title: Text(userData.username),
      // Add more details as needed
    );
  }
}
