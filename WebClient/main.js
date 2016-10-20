$(document).ready(function() {
    var socketServer = 'http://192.168.1.8/';
    var socket = io.connect(socketServer);
    var user;
    
    socket.on('connect', function() {
        $('#error').hide();
        $('#error').html('');
        $('#noerror').show();
        
        // in case the server is coming back online for an active user
        if(user) {
            socket.emit('user', name);
        }
    });

    socket.io.on('connect_error', function(err) {
        $('#error').html(err + '<br>Chat server offline');
        $('#error').show();
        $('#noerror').hide();
    });

    socket.on('welcome', function(data) {
        $('#log').append('<div><strong>' + data.text + '</strong></div>');
    });
    
    socket.on('otherUserConnect', function(data) {
        $('#log').append('<div><strong>' + data + ' connected</strong></div>');
    });

    socket.on('otherUserDisconnect', function(data) {
        $('#log').append('<div><strong>' + data + ' disconnected</strong></div>');
    });

    socket.on('message', function(data) {
        $('#log').append('<div><strong>' + data.user + ': ' + data.message + '</strong></div>');
    })

    $('#user-save').click(function() {
        var username = $('#user-name');
        var txt = username.val().trim();
        if(txt.length > 0) {
            name = txt;
            username.prop('disabled', true);
            $(this).hide();
            $('#controls').show();
            $('#message').prop('disabled', false);
            $('#send').prop('disabled', false);
            user = name;
            socket.emit('user', user);
        }
    });

    $('#send').click(function() {
        var input = $('#message');
        var text = input.val().trim();
        if(text.length > 0) {
            socket.emit('message', text);
        }
        input.val('');
    });


});
