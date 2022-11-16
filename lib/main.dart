import 'dart:io';

import 'package:contacts_app/screens/home_screen.dart';
import 'package:contacts_app/screens/license_screen.dart';
import 'package:contacts_app/utils/network.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
void main() {
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    Network.checkInternet(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    print(Network.isConnected);
     return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'iransans'),
      title: 'دفترچه تلفن آنلاین',
      home: HomeScreen(),
    );
  }
}

