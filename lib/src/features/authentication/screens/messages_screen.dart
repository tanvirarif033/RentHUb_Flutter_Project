import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gap/gap.dart';

class messages_screen extends StatefulWidget {
  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<messages_screen> {
  final TextEditingController _messageController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  CollectionReference _messages = FirebaseFirestore.instance.collection('messages');

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
        'sender': 'User', // You can replace this with the actual sender's name or ID
        'timestamp': FieldValue.serverTimestamp(),
      });
      _messageController.clear();
    }
  }
}