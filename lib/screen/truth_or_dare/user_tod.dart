import 'package:flutter/material.dart';
import 'package:truthordare/constants/Colors.dart';
import 'package:truthordare/constants/route_paths.dart';
import 'package:truthordare/screen/truth_or_dare/user_dare.dart';
import 'package:truthordare/screen/truth_or_dare/user_truth.dart';

class UserTod extends StatelessWidget {
  final int index;

  UserTod({this.index = 0});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: index,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.pushNamed(context, submitTodRoute);
          },
          backgroundColor: ColorBase.kPrimaryColor,
        ),
        appBar: AppBar(
          centerTitle: true,
          title: Text("List"),
          bottom: TabBar(
            isScrollable: false,
            tabs: [
              Tab(
                text: "Truth",
              ),
              Tab(
                text: "Dare",
              ),
            ],
            indicatorColor: Colors.white,
            indicatorWeight: 5,
          ),
        ),
        body: TabBarView(children: [
          UserTruth(),
          UserDare(),
        ]),
      ),
    );
  }
}
