import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HTTPController extends GetxController {
  final headers = {
    "Access-Control-Allow-Origin": "*",
    'Content-Type': 'application/json',
    'Accept': '*/*'
  };
  final TextEditingController messageController = TextEditingController();
  final String url = 'localhost:4000';
  String response = "";

  void init() {

  }

  Future<void> postMessage() async {
    try {
      final response = await http.post(
          Uri.http(url, "message"),
          headers: headers,
          body: jsonEncode({'message': messageController.text}));
      this.response = response.body;
    } catch (e) {
      this.response = 'Error: $e';
      print(e);
    }
    update();
  }

  Future<void> getMessage() async {
    try {
      final response = await http.get(
        Uri.http(url,"time"),
        headers: headers,);
      this.response = response.body;
    } catch (e) {
      this.response = 'Error: $e';
    }
    update();
  }
}