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
            backgroundColor: Colors.transparent,
            elevation: 0.0,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children:[
                    Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            controller.postMessage();
                          },
                          child: Text('Send Message'),
                        )
                    ),
                    SizedBox(width:10),
                    Expanded(
                      child:ElevatedButton(
                        onPressed: () {
                          controller.getMessage();
                        },
                        child: Text('Receive Message'),
                      ),
                    ),

                  ]
                ),
                SizedBox(height: 16),
                SizedBox(height: 16),
                Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.transparent,
                    border: Border.all(color:Colors.deepOrange, width:1)
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                    Text('Response', style:TextStyle(color:Colors.deepOrange)),
                    Padding(
                      padding:EdgeInsets.only(left:8.0, top:8.0),
                      child:SelectableText(controller.response)
                    )
                  ])
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
