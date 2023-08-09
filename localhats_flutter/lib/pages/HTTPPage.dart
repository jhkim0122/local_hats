
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localhats_flutter/utils/WebNavigation.dart';

import '../controller/MainController.dart';

class HTTPPage extends GetView<HTTPController> {

  static const routeName = "/http";
  final HTTPController controller = Get.put(HTTPController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HTTPController>(
      builder: (_) {
        return Scaffold(
          appBar: WebNavigation(routeName),
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
                          child: Padding(padding:EdgeInsets.symmetric(vertical:8), child:Text('Send')),
                        )
                    ),
                    SizedBox(width:10),
                    Expanded(
                      child:ElevatedButton(
                        onPressed: () {
                          controller.getMessage();
                        },
                        child: Padding(padding:EdgeInsets.symmetric(vertical:8), child:Text('Get')),
                      ),
                    ),

                  ]
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
                    Text('Response'),
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
