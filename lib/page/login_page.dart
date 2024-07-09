import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbooking/blocs/auth/auth_cubit.dart';
import 'package:mbooking/homescreen.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: const Scaffold(
        body: LoginPage(),
      ),
    );
  }
}


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text("Đăng nhập"),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                          Radius.circular(20.0)),
                      // Loại bỏ góc bo tròn
                      color: Colors.grey[200], // Màu nền mong muốn
                    ),
                    child:  TextField(
                      controller: email,
                      style: const TextStyle(color: Colors.black), // Màu văn bản
                      decoration: const InputDecoration(
                        hintText: 'Nhập số điện thoại',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none, // Loại bỏ viền
                        contentPadding:
                        EdgeInsets.all(16), // Khoảng cách giữa nội dung và viền
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                          Radius.circular(20.0)),
                      // Loại bỏ góc bo tròn
                      color: Colors.grey[200], // Màu nền mong muốn
                    ),
                    child:  TextField(
                      controller: password,
                      style: const TextStyle(color: Colors.black), // Màu văn bản
                      decoration: const InputDecoration(
                        hintText: 'Nhập password',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none, // Loại bỏ viền
                        contentPadding:
                        EdgeInsets.all(16), // Khoảng cách giữa nội dung và viền
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      context.read<AuthCubit>().login(email.text, password.text);
                      if(state is AuthLoaded){
                        print('username == ${state.auth?.username??""}');
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              backgroundColor: Colors.transparent,
                              child: Container(
                                padding: const EdgeInsets.all(16.0),
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircularProgressIndicator(),
                                    SizedBox(height: 16.0),
                                    Text(
                                      'Please wait...',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );

                        Future.delayed(const Duration(seconds: 2),(){
                          Navigator.pop(context);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) =>   Homescreen(auth:state.auth)),
                          );
                        });
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      height: 60,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          color: Color(0xfffcc434)),
                      child: const Center(
                        child: Text(
                          "Đăng nhập",
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
                  const Center(
                    child: Text(
                      "OR",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: double.infinity,
                      height: 60,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          color: Color(0xff191919)),
                      child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("assets/images/fb.png"),
                              const SizedBox(width: 10,),
                              const Text(
                                "Facebook",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              )
                            ],
                          )),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: double.infinity,
                      height: 60,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          color: Color(0xff191919)),
                      child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("assets/images/gg.png"),
                              const SizedBox(width: 10,),
                              const Text(
                                "Google",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              )
                            ],
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
