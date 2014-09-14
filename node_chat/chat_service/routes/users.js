var express = require('express');
var router = express.Router();

/* GET users listing. */
router.get('/', function(req, res) {

	var topic = req.param('topic');
	var payload = req.param('payload');
	console.log(topic);
	console.log(payload);

  res.send('respond with a resource');
});

module.exports = router;
