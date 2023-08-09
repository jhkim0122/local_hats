const mqtt = require('mqtt');

// MQTT 설정
const mqttBroker = 'mqtt://localhost:1883'; // Mosquitto 브로커 주소
const client = mqtt.connect(mqttBroker);

const topic = 'topic/name';
const message = 'test message';

client.on('connect', () => {
    console.log(`Connected to MQTT broker`);
    client.subscribe(topic);
    client.subscribe("topic/object")
    if (client.connected === true) {
        console.log(`Publish message on topic ${topic} : ${message}`);
        client.publish(topic, message);
        client.publish("test/counter", "20");
    }
});


// receive a message from the subscribed topic
client.on('message', (topic, message) => {
    console.log(`Received message on topic ${topic}: ${message.toString()}`);
});


// error handling
client.on('error',(error) => {
    console.error(error);
    process.exit(1);
});

