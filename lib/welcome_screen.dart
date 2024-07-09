import 'package:flutter/material.dart';
import 'package:mbooking/page/login_page.dart';
import 'package:mbooking/page/register_page.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset("assets/images/logo.png"),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Center(child: Image.asset("assets/images/image.png")),
            const SizedBox(
              height: 50,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>  const Register()));
              },
              child: Container(
                width: double.infinity,
                height: 60,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: Color(0xfffcc434)),
                child: const Center(
                  child: Text(
                    "Đăng ký",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const Login()));
              },
              child: Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                    color: Colors.black,
                    border: Border.all(width: 1, color: Colors.white)),
                child: const Center(
                  child: Text(
                    "Đăng nhập",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
             const Center(
               child: Text(
                "By sign in or sign up,you agree to our Terms of Service\nand Privac y Policy",
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xffb3b3b3)),
                           ),
             )
          ],
        ),
      ),
    );
  }
}
