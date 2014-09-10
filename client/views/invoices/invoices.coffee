Template.invoices.helpers
  total: -> Invoices.find().count()

Template.invoices.events
  'click #newInvoiceButton': ->
    $("#newInvoice").modal("show")

  "click #generateRentInvoicesButton": (e, instance) ->
    space = "blabla"
    e.preventDefault()
    Meteor.call "generateRentInvoices", space, (error, result) ->
