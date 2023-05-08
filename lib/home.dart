import 'dart:convert';

import 'package:chedemo/main.dart';
import 'package:chedemo/second.dart';
import 'package:chedemo/share_mgr.dart';
import 'package:chedemo/third.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // @override
  // void initState() {
  //   super.initState();
  //   var str = 'pass_info=${shareMgr.base64Encode(jsonEncode({
  //         'open_type': 0,
  //         'page_id': 10000
  //       }))}';
  //   pdebug(str);
  // }

  @override
  Widget build(BuildContext context) {
    shareMgr.init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        child: const Text('首页'),
      ),
    );
  }
}
