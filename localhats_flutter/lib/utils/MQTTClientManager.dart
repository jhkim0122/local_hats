import 'dart:io';

import 'package:mqtt_client/mqtt_browser_client.dart';
import 'package:mqtt_client/mqtt_client.dart';

class MQTTClientManager {
  MqttBrowserClient  client = MqttBrowserClient .withPort('ws://localhost/', '', 3000, maxConnectionAttempts:1);

  Future<int> connect() async {
    client.logging(on: true);
    client.keepAlivePeriod = 60000000000;
    client.onConnected = onConnected;
    client.onDisconnected = onDisconnected;
    client.onSubscribed = onSubscribed;
    client.pongCallback = pong;
    client.setProtocolV311();
    client.autoReconnect = true;
    client.websocketProtocols = ['mqtt'];

    final connMessage = MqttConnectMessage()
        .withClientIdentifier("flutter-web-client")
        .startClean().withWillQos(MqttQos.atMostOnce);
    client.connectionMessage = connMessage;
    client.logging(on:false);

    try {
      await client.connect();
      if(client.connectionStatus == MqttConnectionState.connected)
        print('MQTTClient::Connected');
    } on NoConnectionException catch (e) {
      print('MQTTClient::Client exception - $e');
      client.disconnect();
    } on SocketException catch (e) {
      print('MQTTClient::Socket exception - $e');
      client.disconnect();
    }

    return 0;
  }

  void disconnect(){
    client.disconnect();
  }

  void subscribe(String topic) {
    client.subscribe(topic, MqttQos.atLeastOnce);
  }

  void onConnected() {
    print('MQTTClient::Connected');
  }

  void onDisconnected() {
    print('MQTTClient::Disconnected');
  }

  void onSubscribed(String topic) {
    print('MQTTClient::Subscribed to topic: $topic');
  }

  void pong() {
    // print('MQTTClient::Ping response received');
  }

  void publishMessage(String topic, String message, ) {
    final builder = MqttClientPayloadBuilder();
    builder.addString(message);
    client.publishMessage(topic, MqttQos.atLeastOnce, builder.payload!);
  }

  Stream<List<MqttReceivedMessage<MqttMessage>>>? getMessagesStream() {
    return client.updates;
  }
}