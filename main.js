$(document).ready(function() {
    var socketServer = 'http://localhost/';
    var socket = io.connect(socketServer);
    
    socket.on('welcome', function(data) {
        $('#log').append('<div><strong>' + data.text + '</strong></div>');
    });
    
    var name;
    
    $('#user-save').click(function() {
        console.log('click');
        var username = $('#user-name');
        var txt = username.val().trim();
        console.log(txt);
        if(txt.length > 0) {
            name = txt;
            username.prop('disabled', true);
            $(this).hide();
            $('#controls').show();
            $('#message').prop('disabled', false);
            $('#send').prop('disabled', false);
            socket.emit('user', name);
        }
    })
})