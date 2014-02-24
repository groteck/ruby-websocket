require 'sinatra'
require 'faye/websocket'
require 'json'
Faye::WebSocket.load_adapter('thin')
@clients = []

App = lambda do |env|
  if Faye::WebSocket.websocket?(env)
    ws = Faye::WebSocket.new(env,
                             :headers => {'Access-Control-Allow-Origin' => '*'},
                             :ping    => 3,
                             :retry   => 10
                            )
    ws.on :open do |event|
      p [:open, ws.object_id]
      @clients << ws
    end

    ws.on :message do |event|
      p [:message, event.data]
      @clients.each {|client| client.send(event.data) unless client == ws }
    end

    ws.on :close do |event|
      p [:close, ws.object_id]
      @clients.delete(ws)
      ws = nil
    end

    ws.rack_response
  else
    if env["REQUEST_PATH"] == "/"
      [200, {}, "hio"]
    else
      [404, {}, '']
    end
  end
end
