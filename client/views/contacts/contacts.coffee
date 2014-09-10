Template.contacts.helpers
  total: -> Contacts.find().count()

Template.contacts.events
  'click #newContactButton': ->
    $("#newContact").modal("show")

