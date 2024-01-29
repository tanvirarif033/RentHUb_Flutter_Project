import 'package:flutter/material.dart';
import 'package:rent_hub_flutter_project/src/features/authentication/screens/property_list_screen.dart';
import 'package:rent_hub_flutter_project/src/features/authentication/screens/rent_property_screen.dart';

class PostSuccessScreen extends StatefulWidget {
  const PostSuccessScreen({Key? key}) : super(key: key);

  @override
  State<PostSuccessScreen> createState() => _PostSuccessScreenState();
}

class _PostSuccessScreenState extends State<PostSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Congratulations!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                'Property details posted successfully',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                    MaterialPageRoute(builder: (context) => RentPropertyScreen()),
                  );
                },
                child: Text('Post More'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                    MaterialPageRoute(builder: (context) => PropertyListScreen()),
                  );
                },
                child: Text('Return Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
