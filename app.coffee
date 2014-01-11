@Rooms = new Meteor.Collection('rooms')

if Meteor.isClient

  Template.navbar.title = ->
    "Guy's Planning Poker"

  Template.navbar.events =
    'click #signIn': ->
      Meteor.loginWithTwitter()

    'click #signOut': ->
      Meteor.logout()

  Template.home.events =
    'click #joinRoom': ->

    'click #createRoom': ->
      console.log 'creating room'
      room = Rooms.insert
        invitees: [Meteor.userId()]
        occupants: [Meteor.userId()]
      Session.set 'room', room
      Router.go 'room'

    'click #editProfile': ->

  Template.room.occupants = ->
    room = Rooms.findOne
      _id: Session.get('room')
    room.occupants.map (id) ->
      occupant = Meteor.users.findOne
        _id: id
      occupant.profile.name

