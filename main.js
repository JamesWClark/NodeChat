$(document).ready(function() {
    var socketServer = 'http://localhost/';
    var socket = io.connect(socketServer);
    
    socket.on('welcome', function(data) {
        $('#log').append('<div><strong>' + data.text + '</strong></div>');
    });
})