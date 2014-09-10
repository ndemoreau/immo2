Template.contact.rendered = ->


Template.contact.events
  "click .delete": (e, instance) ->
    contact = this
    e.preventDefault()
    Meteor.call "removeContact", contact, (error, result) ->
      alert "contact deleted."
      Router.go "/contacts"

Template.contact.helpers
  created_on: ->
    day = new Date(this.creation_date);
    moment(day).fromNow();


