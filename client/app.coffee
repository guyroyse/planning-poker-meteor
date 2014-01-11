Template.hello.greeting = ->
  'Welcome to PlanningPoker'

Template.hello.events =
  'click input' : ->
    console.log 'You pressed the button'

