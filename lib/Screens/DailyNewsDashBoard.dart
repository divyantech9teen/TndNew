import 'package:flutter/material.dart';
import 'package:the_national_dawn/Common/Constants.dart';
import 'package:the_national_dawn/GuestScreens/GuestHome.dart';
import 'package:the_national_dawn/GuestScreens/TndTvScreen.dart';
import 'package:the_national_dawn/GuestScreens/VideoScreen.dart';

import 'ExploreScreen.dart';
import 'FollowingScreen.dart';

class DailyNewsDashBoard extends StatefulWidget {
  @override
  _DailyNewsDashBoardState createState() => _DailyNewsDashBoardState();
}

class _DailyNewsDashBoardState extends State<DailyNewsDashBoard> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    GuestHome(),
    FollowingScreen(),
    TndTvScreen(),
    ExploreScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Dashboard"),
      //   centerTitle: true,
      // ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'News',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view),
            label: 'Category',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_collection_rounded),
            label: 'Video',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: appPrimaryMaterialColor,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
