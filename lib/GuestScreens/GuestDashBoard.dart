import 'package:flutter/material.dart';
import 'package:the_national_dawn/Common/Constants.dart';

import 'GridScreen.dart';
import 'GuestHome.dart';
import 'GuestProfile.dart';
import 'GuestSearchScreen.dart';
import 'TndTvScreen.dart';
import 'VideoScreen.dart';

class GuestDashBoard extends StatefulWidget {
  @override
  _GuestDashBoardState createState() => _GuestDashBoardState();
}

class _GuestDashBoardState extends State<GuestDashBoard> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    GuestHome(),
    GridScreen(),
    GuestSearchScreen(),
    TndTvScreen(),
    GuestProfile()
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
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view),
            label: 'Category',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
           BottomNavigationBarItem(
            icon: Icon(Icons.video_collection_rounded),
            label: 'Video',
           ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
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
