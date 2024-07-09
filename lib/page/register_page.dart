import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbooking/blocs/auth/auth_cubit.dart';
import 'package:mbooking/page/verifyOTP.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: const Scaffold(
        body: RegisterPage(),
      ),
    );
  }
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController username = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isHidePass = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Đăng ký"),
        centerTitle: true,
      ),
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 50, // Bán kính của CircleAvatar
                      backgroundImage: NetworkImage(
                          "https://cdn1.iconfinder.com/data/icons/project-management-8/500/worker-512.png"), // Hình ảnh của CircleAvatar
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20.0)),
                      // Loại bỏ góc bo tròn
                      color: Colors.grey[200], // Màu nền mong muốn
                    ),
                    child: TextField(
                      controller: username,
                      style: TextStyle(color: Colors.black), // Màu văn bản
                      decoration: InputDecoration(
                        hintText: 'Nhập tên người dùng',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none, // Loại bỏ viền
                        contentPadding: EdgeInsets.all(
                            16), // Khoảng cách giữa nội dung và viền
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20.0)),
                      // Loại bỏ góc bo tròn
                      color: Colors.grey[200], // Màu nền mong muốn
                    ),
                    child: TextField(
                      controller: phone,
                      keyboardType: TextInputType.phone,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      style: TextStyle(color: Colors.black),
                      // Màu văn bản
                      decoration: InputDecoration(
                        hintText: 'Nhập số điện thoại',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none, // Loại bỏ viền
                        contentPadding: EdgeInsets.all(
                            16), // Khoảng cách giữa nội dung và viền
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20.0)),
                      // Loại bỏ góc bo tròn
                      color: Colors.grey[200], // Màu nền mong muốn
                    ),
                    child: TextField(
                      controller: email,
                      style: TextStyle(color: Colors.black), // Màu văn bản
                      decoration: InputDecoration(
                        hintText: 'Nhập email',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none, // Loại bỏ viền
                        contentPadding: EdgeInsets.all(
                            16), // Khoảng cách giữa nội dung và viền
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20.0)),
                      // Loại bỏ góc bo tròn
                      color: Colors.grey[200], // Màu nền mong muốn
                    ),
                    child: TextField(
                      controller: password,
                      obscureText: isHidePass,
                      style: const TextStyle(color: Colors.black),
                      // Màu văn bản
                      decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                            onTap: () {
                              isHidePass = !isHidePass;
                            },
                            child: isHidePass
                                ? Image.asset("assets/images/eye.png")
                                : Image.asset("assets/images/eye-off.png")),
                        hintText: 'Nhập password',
                        hintStyle: const TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                        // Loại bỏ viền
                        contentPadding: const EdgeInsets.all(
                            16), // Khoảng cách giữa nội dung và viền
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () async {
                      String? avatar = "https://cdn1.iconfinder.com/data/icons/project-management-8/500/worker-512.png";
                      int? phoneNumber = int.tryParse(phone.text);
                      context.read<AuthCubit>().register(username.text, avatar, phoneNumber!, email.text, password.text);

                      // Listen for state changes
                      final authCubit = context.read<AuthCubit>();
                      authCubit.stream.listen((state) {
                        if (state is AuthLoaded) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return const AlertDialog(
                                title: Text("Registration Successful"),
                                content: Text("Your registration was successful."),
                              );
                            },
                          );
                          Future.delayed(Duration(seconds: 2), () {
                            Navigator.of(context).pop(); // Close the dialog after 2 seconds
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>  ConfirmOtp(auth: state.auth)));
                          });
                        }
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      height: 60,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          color: Color(0xfffcc434)),
                      child: const Center(
                        child: Text(
                          "Tiếp tục",
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
                          const SizedBox(
                            width: 10,
                          ),
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
                          const SizedBox(
                            width: 10,
                          ),
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
          );
        },
      ),
    );
  }
}
