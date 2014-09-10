Template.transaction.events
  "click .close-transaction": ->
      $(".transaction").addClass "bounceOutRight"
      Router.go "transactions"
  "keyup #contact_id": (e)->
      Session.set("contact_id_filter",$(e.target).val())
  "click .filtered_contacts": (e) ->
      contact_id = $(e.target).attr("id")
      Transaction.update(@_id, $set(contact_id: contact_id))
      Notifications.success 'Contact contact assigned!'
  "click .delete-contact": (e) ->
    Meteor.call "updateTransaction", Router.current().params._id, {contact_id: null}, "removeContact", (err) ->
      Notifications.error err

Template.transaction.helpers
  contact_id_filtered: -> Session.get("contact_id_filter")
  contact: -> Contacts.findOne(@contact_id)

Template.contactsSearchList.events
   "click .filtered-contact": (e) ->
      contact_id = $(e.target).attr("id")
      Meteor.call "updateTransaction", Router.current().params._id, {contact_id: contact_id}, "assignContact", (err) ->
        Notifications.error err


Template.contactsSearchList.helpers
  filtered_contacts: ->
    console.log Session.get "contact_id_filter"
    if Session.get "contact_id_filter"
      expression = new RegExp Session.get("contact_id_filter"), "i"
      console.log expression
      return Contacts.find({$or:[
          {firstname: expression},
          {lastname: expression},
          {email: expression},
        ]})
  total: ->
    Template.contactsSearchList.filtered_contacts().count()
