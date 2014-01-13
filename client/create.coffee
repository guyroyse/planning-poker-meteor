Template.create.events =
  'submit #createRoom' : ->
    roomName = $('#roomName').val()
    roomId = Rooms.create roomName
    Rooms.join roomId
    Router.go 'room'
    false

