Template.home.events =
  'click #joinRoom':      -> Router.go 'join'
  'click #createRoom':    -> Router.go 'create'
  'click #editProfile':   ->
  'click #signIn':        -> Meteor.loginWithTwitter()

