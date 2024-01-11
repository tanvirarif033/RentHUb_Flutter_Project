import 'dart:io';  // Import the 'File' class from the 'dart:io' library
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:gap/gap.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';


class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  CollectionReference _messages = FirebaseFirestore.instance.collection('messages');
  CollectionReference _users = FirebaseFirestore.instance.collection('users');
  String _currentUser = 'User1'; // Replace this with the actual username
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: _messages.orderBy('timestamp').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return ListView(
                  children: snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic>? data = document.data() as Map<String, dynamic>?;
                    if (data == null) {
                      return ListTile(
                        title: Text('Error: Invalid Data'),
                        subtitle: Text('Error'),
                      );
                    }

                    String message = data['message'] ?? 'No message';
                    String sender = data['sender'] ?? 'Unknown sender';
                    String imageUrl = data['imageUrl'] ?? '';

                    return ListTile(

                      title: Text(sender,style: Theme.of(context).textTheme.headlineMedium),
                      subtitle: Text(message,style: Theme.of(context).textTheme.titleLarge),

                    );
                  }).toList(),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      hintStyle: TextStyle(color: Colors.blue,fontSize: 18),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    _sendMessage();
                  },
                ),

                IconButton(
                  icon: Icon(Icons.image),
                  onPressed: () async {
                    _pickImage();
                  },
                ),
              ],
            ),
          ),
          Gap(8) ,
        ],
      ),

    );
  }

  void _sendMessage() {
    String message = _messageController.text.trim();
    if (message.isNotEmpty) {
      _messages.add({
        'message': message,
        'sender': _currentUser,

        'timestamp': FieldValue.serverTimestamp(),
      });
      _messageController.clear();
    }
  }


  void _searchUser() async {
    String username = _searchController.text.trim();
    if (username.isNotEmpty) {
      QuerySnapshot querySnapshot = await _users.where('username', isEqualTo: username).get();
      if (querySnapshot.docs.isNotEmpty) {
        String recipient = querySnapshot.docs[0]['username'];
        _startChatWithUser(recipient);
      } else {
        // User not found
        _showSnackBar('User not found');
      }
    }
  }

  void _startChatWithUser(String recipient) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatScreen(),
        settings: RouteSettings(
          arguments: {
            'currentUser': _currentUser,
            'recipient': recipient,
          },
        ),
      ),
    );
  }
  void _pickImage() async {
    final picker = ImagePicker();
    XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _uploadImage(File(pickedFile.path));
    }
  }



  void _uploadImage(File imageFile) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference storageRef = _storage.ref().child('images/$fileName');
    UploadTask uploadTask = storageRef.putFile(imageFile);

    await uploadTask.whenComplete(() {
      print('Image uploaded successfully!');
    });

    String imageUrl = await storageRef.getDownloadURL();
    print('Image URL: $imageUrl');

    _sendMessageWithImage(imageUrl);
  }

  void _sendMessageWithImage(String imageUrl) {
    print('Sending message with image URL: $imageUrl');

    _messages.add({
      'message': '', // You can include an empty message or any text related to the image.
      'imageUrl': imageUrl,
      'sender': _currentUser,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }



  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }
}

