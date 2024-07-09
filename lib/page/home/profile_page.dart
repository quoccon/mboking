import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isFaceIdEnable = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        image: const DecorationImage(
                            image: NetworkImage(
                                "https://scontent.fhan14-3.fna.fbcdn.net/v/t39.30808-6/325392697_701126025015105_5069459955929585400_n.jpg?stp=cp6_dst-jpg&_nc_cat=110&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=gnLH9K4DIGoQ7kNvgFqSjv0&_nc_ht=scontent.fhan14-3.fna&oh=00_AYBroGVYT8ARoC3_DnnziUwkHaQb1qspEpuO3GwCErMIWQ&oe=6689F2E8"))),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "David Quoccon",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            "assets/images/phone.png",
                            color: const Color(0xffdedede),
                            width: 20,
                            height: 20,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          const Text(
                            "0962580083",
                            style: TextStyle(
                                fontSize: 15, color: const Color(0xffdedede)),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            "assets/images/mail.png",
                            color: const Color(0xffdedede),
                            width: 20,
                            height: 20,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          const Text(
                            "qn329218@gmail.com",
                            style: TextStyle(
                                fontSize: 15, color: const Color(0xffdedede)),
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              const CustomWidget(
                  iconPath: "assets/images/ticket.png",
                  title: "Vorcher của bạn"),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                color: Colors.grey,
              ),
              const SizedBox(
                height: 10,
              ),
              const CustomWidget(
                  iconPath: "assets/images/wallet-cards.png",
                  title: "Lịch sử thanh toán"),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                color: Colors.grey,
              ),
              const SizedBox(
                height: 10,
              ),
              const CustomWidget(
                  iconPath: "assets/images/languages.png",
                  title: "Thay đổi ngôn ngữ"),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                color: Colors.grey,
              ),
              const SizedBox(
                height: 10,
              ),
              const CustomWidget(
                  iconPath: "assets/images/lock-keyhole.png",
                  title: "Đổi mật khẩu"),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                color: Colors.grey,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/images/scan-face.png",
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        const Text(
                          "Face ID/Touch ID",
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                  ),
                  Switch(
                    value: _isFaceIdEnable,
                    onChanged: (value){
                      setState(() {
                        _isFaceIdEnable = value;
                      });
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomWidget extends StatelessWidget {
  final String iconPath;
  final String title;

  const CustomWidget({super.key, required this.iconPath, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Image.asset(
                iconPath,
                color: Colors.white,
              ),
              const SizedBox(
                width: 15,
              ),
              Text(
                title,
                style: TextStyle(fontSize: 18),
              )
            ],
          ),
        ),
        Image.asset(
          "assets/images/chevron.png",
          color: Colors.white,
        )
      ],
    );
  }
}
