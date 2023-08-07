import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class MainController extends GetxController {
  final TextEditingController messageController = TextEditingController();
  final String url = 'http://localhost:3000/message';
  String response = "";

  void init() {

  }

  Future<void> sendMessage() async {
    try {
      final response = await http.post(Uri.parse(url), body: {'message': messageController.text});
      this.response = response.body;
    } catch (e) {
      this.response = 'Error: $e';
    }
    update();
  }
}