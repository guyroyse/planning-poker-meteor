@Rooms = new Meteor.Collection('rooms')

@mustBeSignedIn = ->
  unless Meteor.user()
    @render 'login'
    @stop()

UserAdapter =

  findUserById: (id) ->
    Meteor.users.findOne
      _id: id


RoomAdapter =

  newRoom: (name, creator) ->
    Rooms.insert
      name: name
      members: [ creator ]

  findRoomById: (id) ->
    Rooms.findOne
      _id: id

  findRoomsForMember: (member) ->
    Rooms.find
      members:
        $in: [ member ]

  addUserToRoom: (roomId, userId) ->
    Rooms.update { _id: roomId },
      $addToSet:
        occupants: userId

  removeUserFromOtherRooms: (roomId, userId) ->
    rooms = Rooms.find { _id: { $ne: roomId } }
    rooms.forEach (room) ->
      newOccupants = room.occupants.filter (id) -> id isnt userId
      Rooms.update { _id: room._id }, { $set: { occupants: newOccupants } }


SessionAdapter =

  room: (roomId) ->
    Session.set 'room', roomId if roomId
    Session.get 'room'


currentRoom = ->
  RoomAdapter.findRoomById SessionAdapter.room()

myRooms = ->
  RoomAdapter.findRoomsForMember Meteor.userId()

createRoom = (name) ->
  RoomAdapter.newRoom name, Meteor.userId()

joinRoom = (roomId) ->
  RoomAdapter.addUserToRoom roomId, Meteor.userId()
  RoomAdapter.removeUserFromOtherRooms roomId, Meteor.userId()
  SessionAdapter.room roomId

currentRoomOccupantNames = ->
  currentRoom().occupants.map (occupantId) ->
    occupant = UserAdapter.findUserById occupantId
    occupant.profile.name


if Meteor.isClient

  Template.navbar.events =
    'click #navbarHome':    -> Router.go 'home'
    'click #signIn':        -> Meteor.loginWithTwitter()
    'click #signOut':       -> Meteor.logout()

  Template.login.events =
    'click #signIn':        -> Meteor.loginWithTwitter()

  Template.home.events =
    'click #joinRoom':      -> Router.go 'join'
    'click #createRoom':    -> Router.go 'create'
    'click #editProfile':   ->
    'click #signIn':        -> Meteor.loginWithTwitter()

  Template.join.events =
    'click #createRoom':    -> Router.go 'create'

  Template.create.events =
    'submit #createRoom' : ->
      roomName = $('#roomName').val()
      roomId = createRoom roomName
      joinRoom roomId
      Router.go 'room'
      false

  Template.join.thereAreRooms = -> myRooms().count() > 0
  Template.join.rooms =         -> myRooms()

  Template.room.room =          -> currentRoom()
  Template.room.occupants =     -> currentRoomOccupantNames()

