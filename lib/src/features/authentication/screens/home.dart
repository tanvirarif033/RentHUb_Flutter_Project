// ... (other imports and classes)

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rent_hub_flutter_project/src/features/authentication/screens/send_notification.dart';
import 'package:rent_hub_flutter_project/src/features/authentication/screens/user.dart';
import 'package:rent_hub_flutter_project/src/features/authentication/screens/user_widget.dart';

import 'firebase_helper.dart';

class HomeScreen0 extends StatelessWidget {
  const HomeScreen0({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        centerTitle: true,
      ),
      body: Center(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseHelper.buildViews,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            final List<UserModel> models = [];
            final List<QueryDocumentSnapshot>? docs = snapshot.data?.docs;

            if (docs == null || docs.isEmpty) {
              return const Text('No data');
            }

            List<Widget> widgets = [];

            for (var doc in docs) {
              final data = doc.data() as Map<String, dynamic>;
              if (data['token'] != null && data['token'] is String) {
                models.add(UserModel.fromJson(data));

                final model = UserModel.fromJson(data);

                widgets.add(
                  UserWidget(
                    onClick: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SendNotificationScreen(
                          token: model.token,
                        ),
                      ),
                    ),
                    model: model,
                  ),
                );
              }
            }

            return SingleChildScrollView(
              child: Column(
                children: widgets,
              ),
            );
          },
        ),
      ),
    );
  }
}
