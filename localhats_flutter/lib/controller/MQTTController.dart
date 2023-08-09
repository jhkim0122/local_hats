import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localhats_flutter/utils/MQTTClientManager.dart';
import 'package:mqtt_client/mqtt_client.dart';

class MQTTController extends GetxController with WidgetsBindingObserver {
  final mqttClientManager = MQTTClientManager();
  final String pubTopic = "test/counter";
  final TextEditingController messageController = TextEditingController();
  String response = "";
  static const topic = 'topic/name';

  MQTTController() {
    mqttClientManager.connect().then((_) {
      if(mqttClientManager.client.connectionStatus! == MqttConnectionState.connected){
        mqttClientManager.subscribe(pubTopic);
        setupUpdatesListener();
      }
    });
  }

  Future<void> postMessage() async {
    try {
      mqttClientManager.publishMessage(topic, messageController.text);
      print("publish message: ${messageController.text}, topic : $topic");
      response = "publish message: ${messageController.text}, topic : $topic";
    } catch (e) {
      this.response = 'Error: $e';
    }
    update();
  }

  void setupUpdatesListener() {
    mqttClientManager
        .getMessagesStream()!
        .listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      final recMess = c![0].payload as MqttPublishMessage;
      final pt = MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      response = pt;
      print('MQTTClient::Message received on topic: <${c[0].topic}> is $pt\n');
    });
  }

  @override
  void onClose() {
    super.onClose();
    WidgetsBinding.instance.removeObserver(this);
    mqttClientManager.client.autoReconnect = false;
    mqttClientManager.disconnect();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print('state = $state');
  }
}