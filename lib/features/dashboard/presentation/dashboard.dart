import 'package:flutter/material.dart';
import 'package:school_app/core/utils/color_const.dart';

import 'package:school_app/features/homepage/presentation/home.dart';
import 'package:school_app/features/notification/presentation/notifications.dart';
import 'package:school_app/features/profile/presentation/profile.dart';
import 'package:school_app/features/settings/presentation/settings.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<Widget> widgetList = [
    HomePage(),
    Profile(),
    Settings(),
    Notifications(),
  ];
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgetList[index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,

        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.black,

        onTap: (value) {
          setState(() {
            index = value;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),

          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),

          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: "Notificationss",
          ),
        ],
      ),
    );
  }
}
