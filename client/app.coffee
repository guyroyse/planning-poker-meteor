Template.header.title = ->
  "Guy's Planning Poker"

Template.header.tagline = ->
  'Shuffle up and Deal!'

Template.login.events =
  'click #signIn': ->
    Meteor.loginWithTwitter()
  'click #signOut': ->
    Meteor.logout()
