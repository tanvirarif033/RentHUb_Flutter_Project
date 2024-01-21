import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'chatroom.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with WidgetsBindingObserver {
  Map<String, dynamic>? userMap;
  bool isLoading = false;
  final TextEditingController _search = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    setStatus("Online");
  }

  void setStatus(String status) async {
    await _firestore.collection('users').doc(_auth.currentUser!.uid).update({
      "status": status,
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      setStatus("Online");
    } else {
      setStatus("Offline");
    }
  }

  String chatRoomId(String currentUserUid, String otherUserUid) {
    if (currentUserUid != null &&
        otherUserUid != null &&
        currentUserUid.isNotEmpty &&
        otherUserUid.isNotEmpty) {
      List<String> uids = [currentUserUid, otherUserUid];
      uids.sort();
      return "${uids[0]}_${uids[1]}";
    }
    return "";
  }

  Future<void> onSearch() async {
    setState(() {
      isLoading = true;
    });

    final query = _search.text.trim();
    if (query.isEmpty) {
      setState(() {
        isLoading = false;
      });
      return;
    }

    try {
      final querySnapshot = await _firestore
          .collection('users')
          .where("username", isEqualTo: query)
          .limit(1)
          .get();

      setState(() {
        isLoading = false;
      });

      if (querySnapshot.docs.isNotEmpty) {
        userMap = querySnapshot.docs[0].data() as Map<String, dynamic>;

        if (userMap != null) {
          String roomId = chatRoomId(
            _auth.currentUser?.uid ?? "",
            userMap!['uid'] ?? "",
          );

          if (roomId.isNotEmpty) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ChatRoom(
                  chatRoomId: roomId,
                  userMap: userMap!,
                ),
              ),
            );
          } else {
            print("Error: Empty chat room ID");
          }
        } else {
          print("Error: userMap is null");
        }
      } else {
        print("User not found");
      }
    } catch (error) {
      print("Error searching for user: $error");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Chat Screen"),
      ),
      body: isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : Column(
        children: [
          SizedBox(height: size.height / 20),
          Container(
            height: size.height / 14,
            width: size.width,
            alignment: Alignment.center,
            child: Container(
              height: size.height / 14,
              width: size.width / 1.15,
              child: TextField(
                controller: _search,
                decoration: InputDecoration(
                  hintText: "Search",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: size.height / 50),
          ElevatedButton(
            onPressed: onSearch,
            child: Text("Search"),
          ),
          SizedBox(height: size.height / 20),
          if (userMap != null)
            ListTile(
              onTap: () {
                String roomId = chatRoomId(
                  _auth.currentUser?.displayName ?? "",
                  userMap!['username'] ?? "",
                );

                if (roomId.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChatRoom(
                        chatRoomId: roomId,
                        userMap: userMap!,
                      ),
                    ),
                  );
                } else {
                  print("Error: Empty chat room ID");
                }
              },
              leading: Icon(Icons.account_box, color: Colors.black),
              title: Text(
                userMap!['username'] ?? "",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
              subtitle: Text(userMap!['email'] ?? ""),
              trailing: Icon(Icons.chat, color: Colors.black),
            ),
        ],
      ),
    );
  }
}
