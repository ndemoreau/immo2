Template.invoice.rendered = ->


Template.invoice.events
  "click .delete": (e, instance) ->
    invoice = this
    e.preventDefault()
    Meteor.call "removeInvoice", invoice, (error, result) ->
      alert "invoice deleted."
      Router.go "/invoices"

Template.invoice.helpers
  created_on: ->
    day = new Date(this.creation_date);
    moment(day).fromNow();


