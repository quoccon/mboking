import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:AppBar(
        title: const Text("Thông báo"),
        centerTitle: true,
      ) ,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 100,
              color: const Color(0xff1c1c1c),
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 30, // Bán kính của CircleAvatar
                      backgroundImage: NetworkImage("https://cdn1.iconfinder.com/data/icons/project-management-8/500/worker-512.png"), // Hình ảnh của CircleAvatar
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
