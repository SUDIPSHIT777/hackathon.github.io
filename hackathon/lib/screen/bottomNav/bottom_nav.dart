import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackathon/screen/home/home_screen.dart';
import 'package:hackathon/screen/resume_upload/resume_upload_screen.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  late PageController _pageController;
  int selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: selectedIndex);
  }

  void onButtonPressed(int index) {
    setState(() {
      selectedIndex = index;
    });
    _pageController.animateToPage(
      selectedIndex,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOutQuad,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              children: _listOfWidget,
            ),
          ),
        ],
      ),
      bottomNavigationBar: SlidingClippedNavBar.colorful(
        backgroundColor: Color(0xff051429),
        onButtonPressed: onButtonPressed,
        iconSize: 30,
        // activeColor: const Color(0xFF01579B),
        selectedIndex: selectedIndex,
        barItems: <BarItem>[
          BarItem(
            icon: CupertinoIcons.house_fill,
            title: 'Home',
            activeColor: Colors.blue,
            inactiveColor: Colors.orange,
          ),
          BarItem(
            icon: Icons.document_scanner,
            title: 'Analyze CV',
            activeColor: Colors.cyan,
            inactiveColor: Colors.lightGreen,
          ),
          BarItem(
            icon: Icons.smart_toy_outlined,
            title: 'Expert chat',
            activeColor: Colors.amber,
            inactiveColor: Colors.teal,
          ),
          BarItem(
            icon: Icons.person_outline_sharp,
            title: 'Profile',
            activeColor: Colors.cyan,
            inactiveColor: Colors.red,
          ),
        ],
      ),
      //   ),
    );
  }
}

// icon size:24 for fontAwesomeIcons
// icons size: 30 for MaterialIcons

List<Widget> _listOfWidget = <Widget>[
  HomeScreen(),
  ResumeUploadScreen(),
  HomeScreen(),
  HomeScreen(),
];
