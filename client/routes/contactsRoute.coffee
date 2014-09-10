ContactController = RouteController.extend(template: "contacts")
Router.map ->
  @route "contacts",
    path: "/contacts"
    waitOn: ->
      subs.subscribe "allContacts"

    data: ->
      contacts: Contacts.find()

  @route "contact",
    path: "/contacts/:_id"
    waitOn: ->
      subs.subscribe "allContacts"

    data: ->
      contact: Contacts.findOne(@params._id)
      contacts: Contacts.find()
