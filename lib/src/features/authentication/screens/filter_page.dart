import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({Key? key}) : super(key: key);

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            'Filter',
            style: TextStyle(fontSize: 25),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.business),
                    SizedBox(width: 8.0),
                    Text(
                      'Property types',
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: ToggleSwitch(
                      labels: const ['family', 'Sublet', 'Office','Bachelor'],
                      fontSize: 18,
                      minWidth: 200, // Adjusted minWidth value
                      minHeight: 60,
                      activeBgColor: const [Colors.redAccent, Colors.redAccent, Colors.redAccent],
                      activeFgColor: Colors.black,
                      inactiveBgColor: Colors.white10,
                      inactiveFgColor: Colors.black,
                    ),
                  ),
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }
}
