SimpleSchema.debug = true


AutoForm.hooks
  insertBuildingForm:
    after:
      insert: (error, result, template) ->
        unless result is false
          $('#newBuilding').modal('hide')
          building = Buildings.findOne(result)
          Notifications.success 'Building created: ' + Meteor.call('name', building)
  insertSpaceForm:
    after:
      insert: (error, result, template) ->
        console.log result + Spaces.find().count()
        unless result is false
          space = Spaces.findOne(result)
          $('#newSpace').modal('hide')
          building = Buildings.update(space.building_id,{$inc: {nbr_spaces: 1}})
          Notifications.success 'Space created: ' + space.name

  insertTenantForm:
    after:
      insert: (error, result, template) ->
        unless result is false
          $('#newTenant').modal('hide')
          tenant = Tenants.findOne(result)
          Notifications.success 'New tenant created: ' + tenant.firstname + " " + tenant.lastname
          $("#newTenant").addClass("hidden")
          $("#tenantsList").removeClass("hidden")
        else if not error.invalidKeys
          Notifications.error error

  insertDoctypeForm:
    after:
      insert: (error, result, template) ->
        unless result is false
          doctype = Doctypes.findOne(result)
          Notifications.success 'New Document template created: ' + doctype.name
        else if not error.invalidKeys
          Notifications.alert error
        Router.go("doctypes")
      update: (error, result, template) ->
        console.log "updating..."
        unless result is false
          doctype = Doctypes.findOne(Router.current().params._id)
          Notifications.success 'Document template updated: ' + doctype.name
        else
          Notifications.error error
        Router.go("doctypes")


  insertContactForm:
    after:
      insert: (error, result, template) ->
        unless result is false
          contact = Contacts.findOne(result)
          if Router.current().route.name == "buildingSpaceTenants"
            $("[name=contact_id] option[value='#{contact._id}']").attr("selected", "selected")
            $('.chosen-select').trigger 'chosen:updated'
            $('.chosen-single span').html(contact.firstname + " " +contact.lastname)
          Notifications.success 'New Contact created: ' + contact.lastname
          this.resetForm();
          $('#newContact').modal('hide')
        else if not error.invalidKeys
          Notifications.error error
      update: (error, result, template) ->
        unless result is false
          contact = Contacts.findOne(Router.current().params._id)
          Notifications.success 'Contact updated: ' + contact.lastname
        else
          Notifications.error error


Meteor.startup ->
  _.extend Notifications.defaultOptions,
    timeout: 10000

  return


