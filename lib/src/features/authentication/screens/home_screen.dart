import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class home_screen extends StatefulWidget{
  @override
  State<home_screen> createState() => _home_screenState();
}

class _home_screenState extends State<home_screen> {
  int current = 0;
  PageController pageController = PageController();
  /// List of Tab Bar Item
  List<String> items1 = [
    "Feed",
    "Location",
    "Filter",
    "Sort",
    "Activity",
  ];
  /// List of body icon
  List<IconData> icons = [
    Icons.feed,
    Icons.swap_horiz_outlined,
    Icons.location_on_outlined,
    Icons.content_paste_search_outlined,
    Icons.swap_horiz_outlined,
    Icons.local_activity,

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        margin: const EdgeInsets.all(1),
        child: Column(
          children: [
            /// Tab Bar
            SizedBox(
              width: double.infinity,
              height: 80,
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: items1.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (ctx, index) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              current = index;
                            });
                            pageController.animateToPage(
                              current,
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.ease,
                            );
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.all(5),
                            width: 100,
                            height: 55,
                            decoration: BoxDecoration(
                              color: current == index
                                  ? Colors.white70
                                  : Colors.white54,
                              borderRadius: current == index
                                  ? BorderRadius.circular(12)
                                  : BorderRadius.circular(7),
                              border: current == index
                                  ? Border.all(
                                  color: Colors.deepPurpleAccent,
                                  width: 2.5)
                                  : null,
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    icons[index],
                                    size: current == index ? 23 : 20,
                                    color: current == index
                                        ? Colors.black
                                        : Colors.grey.shade400,
                                  ),
                                  Text(
                                    items1[index],
                                    style: GoogleFonts.ubuntu(
                                      fontWeight: FontWeight.w500,
                                      color: current == index
                                          ? Colors.black
                                          : Colors.grey.shade400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: current == index,
                          child: Container(
                            width: 5,
                            height: 5,
                            decoration: const BoxDecoration(
                                color: Colors.deepPurpleAccent,
                                shape: BoxShape.circle),
                          ),
                        )
                      ],
                    );
                  }),
            ),

            /// MAIN BODY
            Container(
              margin: const EdgeInsets.only(top: 30),
              width: double.infinity,
              height: 550,
              child: PageView.builder(
                itemCount: icons.length,
                controller: pageController,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        icons[current],
                        size: 200,
                        color: Colors.deepPurpleAccent,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "${items1[current]} Tab Content",
                        style: GoogleFonts.ubuntu(
                            fontWeight: FontWeight.w500,
                            fontSize: 30,
                            color: Colors.deepPurpleAccent),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),


    );
  }

}