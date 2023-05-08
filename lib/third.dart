import 'package:flutter/material.dart';

class ThirdPage extends StatefulWidget {
  const ThirdPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('第三界面'),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Container(),
    );
  }
}
