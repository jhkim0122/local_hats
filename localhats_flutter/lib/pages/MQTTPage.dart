import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localhats_flutter/utils/WebNavigation.dart';

import '../controller/MQTTController.dart';

class MQTTPage extends GetView<MQTTController> {

  static const routeName = "/mqtt";
  final MQTTController controller = Get.put(MQTTController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MQTTController>(
      builder: (_) {
        return Scaffold(
          appBar: WebNavigation(routeName),
          body: SingleChildScrollView(child:Padding(
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
                    controller.postMessage();
                  },
                  child: Padding(padding:EdgeInsets.symmetric(vertical:12), child:Text('Send Message')),
                ),
                SizedBox(height: 16),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: controller.numberController,
                  decoration: InputDecoration(
                    labelText: 'Enter Number',
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    controller.postNumber();
                  },
                  child: Padding(padding:EdgeInsets.symmetric(vertical:12), child:Text('Send Number')),
                ),
                SizedBox(height: 24),
                Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.transparent,
                        border: Border.all(color:Colors.black, width:1)
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:[
                          Text('Log'),
                          Padding(
                              padding:EdgeInsets.only(left:8.0, top:8.0),
                              child:SelectableText(controller.response)
                          ),
                        ])
                ),
              ],
            ),
          )),
        );
      },
    );
  }
}
