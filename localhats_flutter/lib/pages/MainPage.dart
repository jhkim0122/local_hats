import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/MainController.dart';

class MainPage extends GetView<MainController> {

  final MainController controller = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      init: MainController(),
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Flutter to Node.js Communication'),
          ),
          body: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: controller.messageController,
                  decoration: InputDecoration(
                    labelText: 'Enter message',
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    controller.sendMessage();
                  },
                  child: Text('Send Message'),
                ),
                SizedBox(height: 16),
                Text('Response: ${controller.response}'),
              ],
            ),
          ),
        );
      },
    );
  }
}
