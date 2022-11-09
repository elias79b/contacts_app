import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:contacts_app/screens/home_screen.dart';
import 'package:contacts_app/utils/network.dart';
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
    Network.checkInternet();
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

