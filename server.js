var express = require('express');
var app = express();
var http = require('http').Server(app);

app.use('/', express.static(__dirname));

var server = http.listen(80, function() {
    console.log('hosting from ' + __dirname);
    console.log('server listening on http://localhost/');
});