@Rooms = new Meteor.Collection('rooms')

@mustBeSignedIn = ->
  unless Meteor.user()
    @render 'login'
    @stop()


currentRoom = ->
  Rooms.findOne
    _id: Session.get 'room'

createRoom = (name) ->
  Rooms.insert
    name: $('#roomName').val()
    invitees: [Meteor.userId()]
    occupants: [Meteor.userId()]

if Meteor.isClient

  Template.navbar.events =
    'click #navbarHome': ->   Router.go 'home'
    'click #signIn': ->       Meteor.loginWithTwitter()
    'click #signOut': ->      Meteor.logout()

  Template.home.events =
    'click #joinRoom': ->
    'click #createRoom': ->   Router.go 'create'
    'click #editProfile': ->
    'click #signIn': ->       Meteor.loginWithTwitter()

  Template.login.events =
    'click #signIn': ->       Meteor.loginWithTwitter()

  Template.create.events =
    'submit #createRoom' : ->
      roomName = $('#roomName').val()
      roomId = createRoom roomName
      Session.set 'room', roomId
      Router.go 'room'
      false

  Template.room.room = ->
    currentRoom()

  Template.room.occupants = ->
    currentRoom().occupants.map (id) ->
      occupant = Meteor.users.findOne
        _id: id
      occupant.profile.name

