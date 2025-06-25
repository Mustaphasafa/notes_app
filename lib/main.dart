import 'package:flutter/material.dart';
import 'package:fluttercourse/home.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences shared ;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
shared = await SharedPreferences.getInstance();

  runApp(
    MyApp(),
  );
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(

      home: Home(),
        );
  }
}
