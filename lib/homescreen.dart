import 'package:flutter/material.dart';
import 'package:mbooking/model/auth.dart';
import 'package:mbooking/page/home/home_page.dart';
import 'package:mbooking/page/home/notification_page.dart';
import 'package:mbooking/page/home/profile_page.dart';
import 'package:mbooking/page/home/vorcher_page.dart';

class Homescreen extends StatefulWidget {
  final Auth auth;
  const Homescreen({super.key, required this.auth});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int currentIndex = 0;
  late List<Widget> _page = [];

  @override
  void initState() {
    super.initState();
    _page = [
      Home(auth:widget.auth),
      VorcherPage(),
      NotificationPage(),
      ProfilePage()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _page[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.amber,
        items: const [
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage("assets/images/house.png"),color: Colors.white,),
            label: "Home"
          ),
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage("assets/images/ticket.png")),
              label: "Vorcher"
          ),
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage("assets/images/bell.png")),
              label: "Notification"
          ),
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage("assets/images/user-round.png")),
              label: "Profile"
          ),
        ],
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
