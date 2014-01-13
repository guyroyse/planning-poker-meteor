Template.navbar.events =
  'click #navbarHome':    -> Router.go 'home'
  'click #signIn':        -> Meteor.loginWithTwitter()
  'click #signOut':       -> Meteor.logout()

