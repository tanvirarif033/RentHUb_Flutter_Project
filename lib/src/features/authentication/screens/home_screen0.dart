import 'package:flutter/material.dart';
import 'package:rent_hub_flutter_project/src/features/authentication/screens/about_us_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _value = 1;

  @override
  void initState() {
    super.initState();
  }

  List<String> catNames = ['Family', 'Bachelor', 'Office', 'Sublet', 'Hostel', 'More..'];
  List<Color> catColors = [
    Colors.blue, Colors.green, Colors.orange, Colors.red, Colors.purple, Colors.yellow,
  ];
  List<Icon> catIcons = [
    Icon(Icons.people),
    Icon(Icons.person),
    Icon(Icons.work),
    Icon(Icons.apartment),
    Icon(Icons.hotel),
    Icon(Icons.more),
  ];

  void _handleTap(String category) {
    // You can replace this with your actual navigation logic
    print('Pressed: $category');
    switch (category) {
      case 'Family':
        Navigator.push(context, MaterialPageRoute(builder: (context) => about_us_screen()));
        break;
      case 'Bachelor':
        Navigator.push(context, MaterialPageRoute(builder: (context) => about_us_screen()));
        break;
      case 'Office':
        Navigator.push(context, MaterialPageRoute(builder: (context) => about_us_screen()));
        break;
      case 'Sublet':
        Navigator.push(context, MaterialPageRoute(builder: (context) => about_us_screen()));
        break;
      case 'Hostel':
        Navigator.push(context, MaterialPageRoute(builder: (context) => about_us_screen()));
        break;
      case 'More..':
        Navigator.push(context, MaterialPageRoute(builder: (context) => about_us_screen()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(right: 15, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Categories',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.3,
              ),
              itemCount: catNames.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // Handle tap action for the icon
                    _handleTap(catNames[index]);
                  },
                  child: Column(
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          color: catColors[index],
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: catIcons[index],
                        ),
                      ),
                      // SizedBox(height: 10,), // Adjust spacing if needed
                      Text(
                        catNames[index],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: 20), // Add space between Categories and Recent Posts
            const Text(
              'Recent Posts', // Add this header
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            // Add your Recent Posts content here
          ],
        ),
      ),
    );
  }
}
