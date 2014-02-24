# Ruby websocket example
This is project use sinatra to implement simple websocket server.

## Instalation

``` bash
# Clone project
git clone git@github.com:groteck/ruby-websocket.git

# Move to folder project
cd ruby-websocket

# Install project gems
bundle install
```

## Server

``` bash
# Start server with foreman gem
foreman start
```

## Deploy to heroku

``` bash
# Create heroku project
heroku create

# Deploy poject heroku
git push heroku master
```

## Use in your js project
Throw alert with javascript on message for all clients:

``` javascript

$(function() {
  var controllersConnection, wsUri;
  
  // wsUri var for server url 
  wsUri = "ws://appname.herokuapp.com/";

  // Function for conect with the server
  controllersConnection = function(wsUri) {
    // Init websocket
    window.socket = new WebSocket(wsUri);
    // Reset conection with server.
    return socket.onclose = function() {
      return setTimeout((function() {
        return controllersConnection(wsUri);
      }), 5000);
    };
  };
  return controllersConnection(wsUri);
 
  # Send messaje to server 
  $('selector').click(function() {
    return socket.send("message");
  });

  # Throw alert when receive a message
  socket.onmessage = function(evt) {
    if (evt.data === 'message') {
      return alert(evt.data);
    }
  };
});

```
