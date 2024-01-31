
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class ChatRoom extends StatelessWidget {
  final Map<String, dynamic> userMap;
  final String chatRoomId;

  ChatRoom({required this.chatRoomId, required this.userMap});

  final TextEditingController _message = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  File? imageFile;

  Future getImage() async {
    ImagePicker _picker = ImagePicker();

    await _picker.pickImage(source: ImageSource.gallery).then((xFile) {
      if (xFile != null) {
        imageFile = File(xFile.path);
        uploadImage();
      }
    });
  }

  Future<void> uploadImage() async {
    String fileName = Uuid().v4();

    if (fileName.isNotEmpty) {
      // Your code for uploading the image and adding it to Firestore
    } else {
      print("Error: Empty document ID");
    }




    try {
      await _firestore
          .collection('chatroom')
          .doc(chatRoomId)
          .collection('chats')
          .doc(fileName)
          .set({
        "sendby": _auth.currentUser!.displayName,
        "message": "", // Leave it empty initially for images
        "type": "img",
        "time": FieldValue.serverTimestamp(),
      });

      var ref = FirebaseStorage.instance.ref().child('images').child(
          "$fileName.jpg");

      await ref.putFile(imageFile!);

      String imageUrl = await ref.getDownloadURL();
      await _firestore
          .collection('chatroom')
          .doc(chatRoomId)
          .collection('chats')
          .doc(fileName)
          .update({"message": imageUrl});

      print(imageUrl);
    } catch (error) {
      print("Error uploading image: $error");

      // If an error occurs during image uploading, delete the Firestore document
      await _firestore
          .collection('chatroom')
          .doc(chatRoomId)
          .collection('chats')
          .doc(fileName)
          .delete();

    }
  }

  void onSendMessage() async {
    if (_message.text.isNotEmpty) {
      Map<String, dynamic> message = {
        "sendby": _auth.currentUser!.displayName,
        "message": _message.text,
        "type": "text",
        "time": FieldValue.serverTimestamp(),
        "seen": false,
      };

      _message.clear();
      DocumentReference docRef = await _firestore
          .collection('chatroom')
          .doc(chatRoomId)
          .collection('chats')
          .add(message);

      // Assume the message is sent by the current user, simulate "seen" by updating the document
      await docRef.update({'seen': true});
    } else {
      print("Enter Some Text");
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;


    return Scaffold(
    appBar: AppBar(
    title: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Text(userMap['username']),
    Text(userMap['email']),
    StreamBuilder<DocumentSnapshot>(
    stream: _firestore.collection("users").doc(userMap['uid']).snapshots(),
    builder: (context, snapshot) {
    if (snapshot.hasData && snapshot.data!.exists) {
    var userData = snapshot.data!.data() as Map<String, dynamic>;
    String status = userData.containsKey('status') ? userData['status'] : '';
    return Text(
    status.isNotEmpty ? 'Online' : 'Offline',
    style: TextStyle(fontSize: 14),
    );
    } else {
    return Text('Offline', style: TextStyle(fontSize: 14));
    }
    },
    ),
    ],
    ),
    ),
    body: SingleChildScrollView(
    child: Column(
    children: [
    Container(
    height: size.height / 1.25,
    width: size.width,
    child: StreamBuilder<QuerySnapshot>(
    stream: _firestore
        .collection('chatroom')
        .doc(chatRoomId)
        .collection('chats')
        .orderBy("time", descending: false)
        .snapshots(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
    return ListView.builder(
    itemCount: snapshot.data!.docs.length,
    itemBuilder: (context, index) {
    Map<String, dynamic> map = snapshot.data!.docs[index].data() as Map<String, dynamic>;
    return messages(size, map, context);
    },
    );
    } else {
    return Container();
    }
    },
    ),
    ),
    Container(
    height: size.height / 10,
    width: size.width,
    alignment: Alignment.center,
    child: Container(
    height: size.height / 12,
    width: size.width / 1.1,
    child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    Container(
    height: size.height / 17,
    width: size.width / 1.3,
    child: TextField(
    controller: _message,
    decoration: InputDecoration(
    suffixIcon: IconButton(
    onPressed: () => getImage(),
    icon: Icon(Icons.photo),
    ),
    hintText: "Send Message",
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    ),
    ),
    ),
    ),
    IconButton(
    icon: Icon(Icons.send),
    onPressed: onSendMessage,
    ),
    ],
    ),
    ),
    ),
    ],
    ),
    ),
    );
  }


// Updated messages widget
  Widget messages(Size size, Map<String, dynamic> map, BuildContext context) {
    String senderName = map['sendby'] ?? ''; // Default to empty string if null
    DateTime timestamp = map['time'] != null ? (map['time'] as Timestamp).toDate() : DateTime.now();
    bool isCurrentUser = senderName == _auth.currentUser!.displayName;


    return Column(
    crossAxisAlignment: isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
    children: [
    Container(
    width: size.width,
    alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
    child: Text(
    senderName,
    style: TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: isCurrentUser ? Colors.lightBlue : Colors.green,
    ),
    ),
    ),
    map['type'] == "text"
    ? Container(
    width: size.width,
    alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
    child: Column(
    crossAxisAlignment: isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
    children: [
    Container(
    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(15),
    color: isCurrentUser ? Colors.red : Colors.green,
    ),
    child: Text(
    map['message'] ?? '', // Default to empty string if null
    style: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Colors.white,
    ),
    ),
    ),
    // Add timestamp for text messages
    Padding(
    padding: EdgeInsets.only(left: isCurrentUser ? 0 : 8, right: isCurrentUser ? 8 : 0),
    child: Text(
    timestamp.toString(),
    style: TextStyle(
    fontSize: 10,
    color: Colors.grey,
    ),
    ),
    ),
    // Add "seen" indicator
    if (isCurrentUser && map['seen'] != null && map['seen'] == true)
    Padding(
    padding: EdgeInsets.only(left: 8),
    child: Text(
    "Seen",
    style: TextStyle(
    fontSize: 12,
    color: Colors.blue,
    ),
    ),
    ),
    ],
    ),
    )
        : InkWell(
    onTap: () {
    if (map['message'] != null) {
    Navigator.of(context).push(
    MaterialPageRoute(
    builder: (_) => ShowImage(
    imageUrl: map['message'],
    ),
    ),
    );
    }
    },
    child: Container(
    height: size.height / 2.5,
    width: size.width,
    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
    alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
    child: SingleChildScrollView(
    child: Column(
    crossAxisAlignment: isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
    children: [
    Container(
    height: size.height / 2.5,
    width: size.width / 2,
    decoration: BoxDecoration(border: Border.all()),
    alignment: Alignment.center,
    child: map['message'] != null && map['message'] != ''
    ? isNetworkUrl(map['message'])
    ? Image.network(
    map['message'],
    fit: BoxFit.cover,
    )
        : Image.file(
    File(map['message']),
    fit: BoxFit.cover,
    )
        : CircularProgressIndicator(),
    ),
    // Add timestamp for image messages
    Padding(


    padding: EdgeInsets.only(left: isCurrentUser ? 0 : 8, right: isCurrentUser ? 8 : 0),
    child: Text(
    timestamp.toString(),
    style: TextStyle(
    fontSize: 10,
    color: Colors.grey,
    ),
    ),
    ),
    // Add "seen" indicator
    if (isCurrentUser && map['seen'] != null && map['seen'] == true)
    Padding(
    padding: EdgeInsets.only(left: 8),
    child: Text(
    "Seen",
    style: TextStyle(
    fontSize: 12,
    color: Colors.blue,
    ),
    ),
    ),
    ],
    ),
    ),
    ),
    ),
    ],
    );
    }


}

class ShowImage extends StatelessWidget {
  final String imageUrl;

  const ShowImage({required this.imageUrl, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        color: Colors.black,
        child: Image.network(imageUrl),
      ),
    );
  }
}

bool isNetworkUrl(String url) {
  return Uri.parse(url).isAbsolute;
}