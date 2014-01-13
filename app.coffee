@Rooms =

  current: ->
    RoomAdapter.findRoomById SessionAdapter.room()

  currentOccupantNames: ->
    this.current().occupants.map (occupantId) ->
      occupant = UserAdapter.findUserById occupantId
      occupant.profile.name

  mine: ->
    RoomAdapter.findRoomsForMember Meteor.userId()

  create: (name) ->
    RoomAdapter.newRoom name, Meteor.userId()

  join: (roomId) ->
    RoomAdapter.addUserToRoom roomId, Meteor.userId()
    RoomAdapter.removeUserFromOtherRooms roomId, Meteor.userId()
    SessionAdapter.room roomId

