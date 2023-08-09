import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HTTPController extends GetxController {
  final TextEditingController messageController = TextEditingController();
  final String url = 'http://localhost:3000';
  String response = "";

  void init() {

  }

  Future<void> postMessage() async {
    try {
      final response = await http.post(Uri.parse("$url/message"), body: {'message': messageController.text});
      this.response = response.body;
    } catch (e) {
      this.response = 'Error: $e';
    }
    update();
  }

  Future<void> getMessage() async {
    try {
      final response = await http.get(Uri.parse("$url/time"));
      this.response = response.body;
    } catch (e) {
      this.response = 'Error: $e';
    }
    update();
  }
}