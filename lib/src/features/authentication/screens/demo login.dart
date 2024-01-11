import 'package:flutter/material.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({Key? key}) : super(key: key);

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  List<bool> isSelected = [false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Property Types',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red, // Change the color of the box

                    border: Border.all(
                      color: Colors.black,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: ToggleButtons(
                    isSelected: isSelected,
                    onPressed: (index) {
                      setState(() {
                        // Toggle the state for the selected index
                        isSelected[index] = !isSelected[index];
                      });
                    },
                    color: Colors.grey,
                    selectedColor: Colors.blue,
                    children: [
                      _buildToggleButton('Family'),
                      _buildToggleButton('Bachelor'),
                      _buildToggleButton('Office'),
                      _buildToggleButton('Sublet'),
                      _buildToggleButton('Hostel'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildToggleButton(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Text(
        label,
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
