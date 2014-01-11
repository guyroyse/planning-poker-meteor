Meteor.startup ->

  Accounts.loginServiceConfiguration.remove
    service:      'twitter'

  Accounts.loginServiceConfiguration.insert
    service:      'twitter'
    consumerKey:  Meteor.settings.twitter.consumerKey
    secret:       Meteor.settings.twitter.secret

