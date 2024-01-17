import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../constants/sizes.dart';
import 'demo login.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _value = 1;
  @override
  void initState() {
    super.initState();
    _value = 1; // Set an initial value
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        margin: const EdgeInsets.all(1),
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(3.0),
                    child: SizedBox(
                      width: 125,
                      child: OutlinedButton.icon(
                        icon: const Icon(Icons.feed_outlined),
                        onPressed: () {},
                        label: const Text("Feed"),
                      ),
                    ),
                  ),
                  const Gap(10),
                  Container(
                    padding: const EdgeInsets.all(3.0),
                    child: SizedBox(
                      width: 125,
                      child: OutlinedButton.icon(
                        icon: const Icon(Icons.content_paste_search_outlined),
                        onPressed: () {
                          showModalBottomSheet(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            context: context,
                            isScrollControlled: true,
                            builder: (context) => Container(
                              height: MediaQuery.of(context).size.height*0.35,
                              padding: const EdgeInsets.all(tDefaultSize),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Sort By",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Radio(
                                        value: 1,
                                        groupValue: _value,
                                        onChanged: (value) {
                                          setState(() {
                                            _value = value as int;
                                          });
                                          Navigator.pop(context);
                                        },
                                      ),
                                      const Gap(10),
                                      const Text("Newest"),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Radio(
                                        value: 2,
                                        groupValue: _value,
                                        onChanged: (value) {
                                          setState(() {
                                            _value = value as int;
                                          });
                                          Navigator.pop(context);
                                        },
                                      ),
                                      const Gap(10),
                                      const Text("Price (Low to High)"),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Radio(
                                        value: 3,
                                        groupValue: _value,
                                        onChanged: (value) {
                                          setState(() {
                                            _value = value as int;
                                          });
                                          Navigator.pop(context);
                                        },
                                      ),
                                      const Gap(10),
                                      const Text("Price (High to Low)"),
                                    ],
                                  ),
                                  const Gap(15),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context); // Close the modal
                                    },
                                    child: const Text('Close'),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        label: const Text("Sort"),
                      ),
                    ),
                  ),
                  const Gap(10),
                  Container(
                    padding: const EdgeInsets.all(3.0),
                    child: SizedBox(
                      width: 125,
                      child: OutlinedButton.icon(
                        icon: const Icon(Icons.location_on_outlined),
                        onPressed: () {},
                        label: const Text("Location"),
                      ),
                    ),
                  ),
                  const Gap(10),
                  Container(
                    padding: const EdgeInsets.all(3.0),
                    child: SizedBox(
                      width: 125,
                      child: OutlinedButton.icon(
                        icon: const Icon(Icons.manage_search_outlined),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context)=>const FilterPage()));
                        },
                        label: const Text("Filter"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
