import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'chatroom.dart';

class chatpage extends StatefulWidget {
  const chatpage({super.key});

  @override
  State<chatpage> createState() => _chatpageState();
}


class _chatpageState extends State<chatpage>  with WidgetsBindingObserver{

  Map<String, dynamic> ? userMap;
  bool isLoading=false;
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
      // online
      setStatus("Online");
    } else {
      // offline
      setStatus("Offline");
    }
  }


  String chatRoomId(String currentUserUid, String otherUserUid) {
    if (currentUserUid != null &&
        otherUserUid != null &&
        currentUserUid.isNotEmpty &&
        otherUserUid.isNotEmpty) {
      List<String> uids = [currentUserUid, otherUserUid];
      uids.sort(); // Sort the UIDs to ensure consistency

      // Concatenate the sorted UIDs to create the unique chat room ID
      return "${uids[0]}_${uids[1]}";
    }

    // Return a default value if any of the conditions are not met
    return "default_chat_room_id";
  }








  void onSearch() async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;

    setState(() {
      isLoading = true;
    });

    await _firestore
        .collection('users')
        .where("username", isEqualTo: _search.text) // Use the correct field name
        .get()
        .then((value) {
      setState(() {
        isLoading = false;
      });
      if (value.docs.isNotEmpty) {
        setState(() {
          userMap = value.docs[0].data();
        });

        String roomId = chatRoomId(
          _auth.currentUser?.uid ?? "", // Current user's UID
          userMap!['uid'] ?? "", // Searched user's UID (assuming 'uid' is the field name)
        );

        if (roomId.isNotEmpty) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => ChatRoom(
              chatRoomId: roomId,
              userMap: userMap!,
            ),
          ));
        } else {
          print("Error: Empty chat room ID");
        }

      } else {
        // Handle the case where no matching user is found
        print("User not found");
      }
    });
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
        child: Container(
          height: size.height / 20,
          width: size.height / 20,
          child: CircularProgressIndicator(),
        ),
      )
          : Column(
        children: [
          SizedBox(
            height: size.height / 20,
          ),
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
          SizedBox(
            height: size.height / 50,
          ),
          ElevatedButton(
            onPressed: onSearch,
            child: Text("Search"),
          ),
          SizedBox(
            height: size.height / 20,
          ),
          if (userMap != null)
            ListTile(
              onTap: () {
                String roomId = chatRoomId(
                  _auth.currentUser?.displayName ?? "", // Null-aware operator
                  userMap!['username'] ?? "",
                );

                if (roomId.isNotEmpty) {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => ChatRoom(
                      chatRoomId: roomId,
                      userMap: userMap!,
                    ),
                  ));
                } else {
                  print("Error: Empty chat room ID");
                }
              },
              leading: Icon(Icons.account_box, color: Colors.black),
              title: Text(
                userMap!['username'] ?? "", // Null-aware operator
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
              subtitle: Text(userMap!['email'] ?? ""), // Null-aware operator
              trailing: Icon(Icons.chat, color: Colors.black),
            ),
        ],
      ),
    );
  }


}