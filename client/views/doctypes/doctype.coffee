Template.doctype.rendered = ->


Template.doctype.events
  "click .delete": (e, instance) ->
    doctype = this
    e.preventDefault()
    Meteor.call "removeDoctype", doctype, (error, result) ->
      alert "doctype deleted."
      Router.go "/doctypes"

Template.doctype.helpers
  created_on: ->
    day = new Date(this.creation_date);
    moment(day).fromNow();


