import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localhats_flutter/utils/MQTTClientManager.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'dart:convert' show utf8;

class MQTTController extends GetxController with WidgetsBindingObserver {
  final mqttClientManager = MQTTClientManager();
  final TextEditingController messageController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  String response = "";
  static const topicMessage = 'topic/message';
  static const topicNumber = "topic/number";
  static const topicTime = "topic/time";
  static const topicResponse = "response";

  MQTTController() {
    mqttClientManager.connect(init).then((_){
      response += "[🔔Flutter-Web] Connected to MQTT broker";
    });
  }

  void init() {
    mqttClientManager.subscribe(topicTime);
    mqttClientManager.subscribe(topicResponse);
    setupUpdatesListener();
  }

  Future<void> postMessage() async {
    try {
      mqttClientManager.publishMessage(topicMessage, messageController.text);
      print("publish message: ${messageController.text}, topic : $topicMessage");
      response += "\n[🔔Flutter-Web] publish message: ${messageController.text}, topic : $topicMessage";
    } catch (e) {
      this.response += '\nError: $e';
    }
    update();
  }

  Future<void> postNumber() async {
    try {
      mqttClientManager.publishMessage(topicNumber, numberController.text);
      print("publish message: ${numberController.text}, topic : $topicNumber");
      response += "\n[🔔Flutter-Web] publish message: ${numberController.text}, topic : $topicNumber";
    } catch (e) {
      this.response += '\nError: $e';
    }
    update();
  }

  void setupUpdatesListener() {
    mqttClientManager.client.updates!
        .listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      final recMess = c![0].payload as MqttPublishMessage;
      final pt = utf8.decode(recMess.payload.message);
      response += '\n$pt';
      print('Received on topic: <${c[0].topic}> : $pt');
      update();
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