import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'pages/MQTTPage.dart';
import 'pages/HTTPPage.dart';
import 'pages/MainPage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
        ),
        initialRoute: "/",
        getPages: [
          GetPage(name: "/", page: () => const MainPage()),
          GetPage(name: "/http", page: () => HTTPPage()),
          GetPage(name: "/mqtt", page: () => MQTTPage()),
          // GetPage(
          //     name: "/detail/:id",
          //     page: () => DetailView(),
          //     transition: Transition.downToUp)
        ]
    );
  }
}