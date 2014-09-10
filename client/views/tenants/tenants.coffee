Template.spaceTenants.events
  'click #newTenantButton': ->
#    UI.insert(UI.render(Template.newTenant),document.body)
    $("#tenantsList").addClass("hidden")
    $("#newTenant").removeClass("hidden")
  "click #deleteTenantButton": (e, instance) ->
    Meteor.call "removeTenant", this, (error, result) ->
      alert "tenant deleted."
      console.log "current route: #{Router.current.route}"
      if Router.current.route == 1
        Router.go "/tenants"

Template.spaceTenants.helpers

Template.tenantsList.helpers
  tenants: -> Tenants.find({space_id: Router.current().params._id})
  building_id: -> Router.current().params._building_id
  space_id: -> Router.current().params._id

Template.tenantWidget.helpers
  contact: -> Contacts.findOne(_id: this.contact_id)

Template.tenantWidget.rendered = ->
  console.log "Widget shown"
  console.log this.data