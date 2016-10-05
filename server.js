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
    
    socket.on('otherUserConnect', function(data) {
        $('#log').append('<div><strong>' + data + ' connected</strong></div>');
    });
    
    socket.on('disconnect', function() {
        if(!socket.user) {
            return;
        }
        if(users.indexOf(socket.user) > -1) {
            console.log(socket.user + ' disconnected');
            users.splice(users.indexOf(socket.user), 1);
            socket.broadcast.emit('otherUserDisconnect', socket.user);
        }
    });
    
    socket.on('message', function(data) {
        io.sockets.emit('message', {
            user: socket.user,
            message: data
        });
    });
});
