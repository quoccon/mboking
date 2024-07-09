import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbooking/blocs/auth/auth_cubit.dart';
import 'package:mbooking/page/login_page.dart';

import '../model/auth.dart';

class ConfirmOtp extends StatelessWidget {
  final Auth auth;

  const ConfirmOtp({super.key, required this.auth});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
        body: Verifyotp(auth: auth),
      ),
    );
  }
}

class Verifyotp extends StatefulWidget {
  final Auth auth;

  const Verifyotp({Key? key, required this.auth}) : super(key: key);

  @override
  State<Verifyotp> createState() => _VerifyotpState();
}

class _VerifyotpState extends State<Verifyotp> {
  final List<TextEditingController> _otpController =
      List.generate(6, (index) => TextEditingController());
  late Timer _timer;
  int _secondsRemaining = 59;
  bool isVerify = false;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _timer.cancel(); // Hủy đồng hồ khi đã hết thời gian
          if(!isVerify){
            _showTimeoutDialog();
          }
        }
      });
    });
  }

  void _showTimeoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("OTP hết hạn"),
        content: const Text("Mã OTP của bạn đã hết hạn"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    for (var controller in _otpController) {
      controller.dispose();
    }
    _timer.cancel();
    super.dispose();
  }

  String _generateOtpString() {
    return _otpController.map((controller) => controller.text).join('');
  }

  @override
  Widget build(BuildContext context) {
    // Format thời gian còn lại dưới dạng mm:ss
    String timerText =
        '${(_secondsRemaining ~/ 60).toString().padLeft(2, '0')}:${(_secondsRemaining % 60).toString().padLeft(2, '0')}';
    String email = widget.auth?.email??"";
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Xác nhận mã OTP"),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Xác nhận mã OTP",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "You just need to enter the OTP sent to the registered email ${widget.auth.email ?? ""}",
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(6, (index) {
                    return Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white54, width: 2),
                          borderRadius: BorderRadius.circular(8)),
                      child: TextField(
                        controller: _otpController[index],
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        style:
                            const TextStyle(fontSize: 24, color: Colors.white),
                        decoration: const InputDecoration(
                          counterText: '',
                          border: InputBorder.none,
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Spacer(),
                    Text(
                      timerText,
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                GestureDetector(
                  onTap: () {
                    context.read<AuthCubit>().verify(email, _generateOtpString());
                    if(state is AuthLoaded){
                      isVerify = true;
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
                      Future.delayed(const Duration(seconds: 2), () {
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Đăng ký người dùng thành công",style: TextStyle(color: Colors.green),))
                        );// Close the dialog
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) =>  const Login()),
                        );
                      });
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      color: Color(0xfffcc434),
                    ),
                    child: const Center(
                      child: Text(
                        "Xác nhận",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
