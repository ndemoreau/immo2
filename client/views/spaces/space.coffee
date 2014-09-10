Template.space.rendered = ->


Template.space.events



Template.space.helpers
  created_on: ->
    day = new Date(this.creation_date)
    moment(day).fromNow()
  allowedValues: -> return {'Furnished': 'Furnished', 'Not Furnished': 'Not Furnished'}




