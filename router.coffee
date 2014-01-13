mustBeSignedIn = ->
  unless Meteor.user()
    @render 'login'
    @stop()

Router.configure
  layoutTemplate:   'layout'
  notFoundTemplate: 'home'

Router.before mustBeSignedIn,
  except: [ 'login' ]

Router.map ->
  this.route 'home',
    path: '/'
  this.route 'room'
  this.route 'create'
  this.route 'join'

