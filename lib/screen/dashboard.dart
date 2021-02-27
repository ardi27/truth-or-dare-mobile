import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:truthordare/constants/Colors.dart';
import 'package:truthordare/screen/login_screen/login.dart';
import 'package:truthordare/screen/truth_or_dare/home.dart';
import 'package:truthordare/screen/truth_or_dare/profile.dart';
import 'package:truthordare/screen/truth_or_dare/submit_tod.dart';

class Dashboard extends StatefulWidget {
  final int initialPage;

  Dashboard({this.initialPage = 0});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialPage;
    _tabController =
        TabController(length: 3, vsync: this, initialIndex: widget.initialPage);
    _tabController.addListener(_handleTabSelection);
  }

  _handleTabSelection() {
    setState(() {
      _currentIndex = _tabController.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarDividerColor: Colors.white.withOpacity(0),
        statusBarColor: ColorBase.kPrimaryColor,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark));
    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        children: [
          Home(),
          SubmitTod(),
          Profile(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: ColorBase.kPrimaryColor,
        onTap: (index){
          setState(() {
            _currentIndex = index;
            _tabController.index = index;
          });
        },
        currentIndex: _currentIndex, // this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Truth or Dare',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Submit ToD',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile'
          )
        ],
      ),
    );
  }
}
