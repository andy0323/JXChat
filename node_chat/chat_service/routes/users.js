var express = require('express');
var router = express.Router();
var mqtt = require('mqtt')

/* GET users listing. */
router.get('/', function(req, res) {
	
	// 解决跨域问题
  res.header("Access-Control-Allow-Origin", "*");   

	var topic = req.param('topic');
	var payload = req.param('payload');
	
	sendMsg(res, topic, payload);
});

function sendMsg(res, topic, payload) {
	client = mqtt.createClient(1883, '192.168.6.74');

	client.publish(topic, payload);

	client.on('message', function (topic, message) {
		res.send(topic + ' say: ' + message);
	});

	client.end();
}

module.exports = router;

