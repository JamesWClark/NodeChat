var express = require('express');
var app = express();
var http = require('http').Server(app);

app.use('/', express.static(__dirname));

var server = http.listen(80, function() {
    console.log('hosting from ' + __dirname);
    console.log('server listening on http://localhost/');
});

var users = [];

var io = require('socket.io').listen(server);

io.sockets.on('connection', function(socket) {
    socket.emit('welcome', { text : 'OH HAI' });
    
    socket.on('user', function(name) {
        console.log(name + ' connected');
        users.push(name);
        socket.user = name;
        console.log('users : ' + users.length);
        socket.broadcast.emit('otherUserConnect', name);
    });
});
