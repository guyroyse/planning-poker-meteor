RoomsCollection = new Meteor.Collection('rooms')

@RoomAdapter =

  newRoom: (name, creator) ->
    RoomsCollection.insert
      name: name
      members: [ creator ]

  findRoomById: (id) ->
    RoomsCollection.findOne
      _id: id

  findRoomsForMember: (member) ->
    RoomsCollection.find
      members:
        $in: [ member ]

  addUserToRoom: (roomId, userId) ->
    RoomsCollection.update { _id: roomId },
      $addToSet:
        occupants: userId

  removeUserFromOtherRooms: (roomId, userId) ->
    rooms = RoomsCollection.find { _id: { $ne: roomId } }
    rooms.forEach (room) ->
      newOccupants = room.occupants.filter (id) -> id isnt userId
      RoomsCollection.update { _id: room._id }, { $set: { occupants: newOccupants } }


@UserAdapter =

  findUserById: (id) ->
    Meteor.users.findOne
      _id: id


@SessionAdapter =

  room: (roomId) ->
    Session.set 'room', roomId if roomId
    Session.get 'room'

