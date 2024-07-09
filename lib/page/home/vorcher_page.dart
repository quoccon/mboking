import 'package:flutter/material.dart';

class VorcherPage extends StatefulWidget {
  const VorcherPage({super.key});

  @override
  State<VorcherPage> createState() => _VorcherPageState();
}

class _VorcherPageState extends State<VorcherPage> {
  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      body: Text("vorcher"),
    );
  }
}
