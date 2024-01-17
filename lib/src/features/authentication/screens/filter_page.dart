import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:rent_hub_flutter_project/src/constants/text_strings.dart';
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

        body: SingleChildScrollView(
          child: Container(
            //padding: const EdgeInsets.all(12),
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

                const SizedBox(height: 20,),
                const Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.money),
                        SizedBox(width: 8.0),
                        Text(
                          'Price Range',
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    TextField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(13),
                        prefixIcon: Icon(Icons.money),
                        labelText: tminprice,
                        hintText: tminprice,
                        border: OutlineInputBorder(),
                        filled: true,
                      ),
                    ),
                    Gap(5),
                    Text('To',style: TextStyle(fontWeight: FontWeight.bold),),
                    TextField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(13),
                        prefixIcon: Icon(Icons.mail_outline_outlined),
                        labelText: tmaxprice,
                        hintText: tmaxprice,
                        border: OutlineInputBorder(),
                        filled: true,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20),
                const Row(
                  children: [
                    Icon(Icons.bed_rounded),
                    SizedBox(width: 8.0),
                    Text(
                      'Bedrooms',
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ToggleSwitch(
                    labels: const ['1', '2', '3','4','5'],
                    fontSize: 18,
                    minWidth: 100, // Adjusted minWidth value
                    minHeight: 60,
                    activeBgColor: const [ Colors.redAccent, Colors.redAccent],
                    activeFgColor: Colors.black,
                    inactiveBgColor: Colors.white10,
                    inactiveFgColor: Colors.black,
                  ),
                ),

                SizedBox(height: 20),
                const Row(
                  children: [
                    Icon(Icons.bathroom),
                    SizedBox(width: 8.0),
                    Text(
                      'Bathrooms',
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ToggleSwitch(
                    labels: const ['1', '2', '3','4','5',],
                    fontSize: 15,
                    minWidth: 100, // Adjusted minWidth value
                    minHeight: 60,
                    activeBgColor: const [ Colors.redAccent, Colors.redAccent],
                    activeFgColor: Colors.black,
                    inactiveBgColor: Colors.white10,
                    inactiveFgColor: Colors.black,
                  ),
                ),

                const SizedBox(height: 40),

                // ElevatedButton to show properties
                SizedBox(
                  width: double.infinity,
                  child:ElevatedButton(
                    onPressed: () {

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Showing properties with selected filters'),
                        ),
                      );
                    },
                    child: const Text('Show Properties'),
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
