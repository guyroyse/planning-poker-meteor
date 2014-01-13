Template.join.thereAreRooms = -> Rooms.mine().count() > 0
Template.join.rooms =         -> Rooms.mine()

Template.join.events =
  'click #createRoom':    -> Router.go 'create'
  'click .joinRoom':      ->
    Rooms.join this._id
    Router.go 'room'

