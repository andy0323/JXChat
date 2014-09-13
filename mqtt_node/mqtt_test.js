var mqtt = require('mqtt')

client = mqtt.createClient(1883, '192.168.1.11');

client.subscribe('presence');
client.publish('presence', 'Hello mqtt');

client.on('message', function (topic, message) {
  console.log(message);
});

client.end();
