const mqtt = require('mqtt');

// MQTT 설정
const mqttBroker = 'mqtt://localhost:1886'; // Mosquitto 브로커 주소
const client = mqtt.connect(mqttBroker);

const topicMessage = 'topic/message';
const topicNumber = 'topic/number';
const topicTime = 'topic/time';
const response = 'response';

client.on('connect', () => {
    console.log(`Connected to MQTT broker`);
    client.subscribe(topicMessage);
    client.subscribe(topicNumber);
    if (client.connected === true) {
        // var message = "Connected to MQTT broker"
        // client.publish(topicMessage, message);
        // console.log(`Publish message on topic ${topicMessage} : ${message}`);
        setInterval(() => {
            const currentTime = new Date().toLocaleString();
            const message = currentTime;

            // 메시지 publish
            client.publish(topicTime, `[🖥Node] Publish message on topic ${topicTime} : ${message}`, (err) => {
                if (err) {
                    console.error('메시지 전송 실패:', err);
                } else {
                    console.log(`[🖥node] Publish message on topic ${topicTime} : ${message}`);
                }
            });
        }, 3000); // 3초 간격
    }
});


// receive a message from the subscribed topic
client.on('message', (topic, message) => {
    console.log(`Received on topic ${topic}: ${message.toString()}`);
    if (client.connected === true) {
        client.publish(response, `[🖥Node] Received on topic ${topic}: ${message.toString()}`);
        console.log(`Publish message on topic ${topic} : ${message}`);
    }
});


// error handling
client.on('error',(error) => {
    console.error(error);
    process.exit(1);
});

