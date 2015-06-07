var mqtt = require('mqtt')

client = mqtt.createClient(1883, '192.168.6.74');

client.subscribe('messages');
client.publish('messages', 'Hello mqtt');

client.on('message', function (topic, message) {
  console.log(topic,message);
});
client.options.reconnectPeriod = 0;
client.end();
