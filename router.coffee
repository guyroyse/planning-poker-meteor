Router.configure
  layoutTemplate:   'layout'
  notFoundTemplate: 'notfound'

Router.map ->
  this.route 'home',
    path: '/'
  this.route 'room'
