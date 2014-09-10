# ---------------------------------------------------- +/
#
# ## Tenants ##
#
# All code related to the Tenants collection goes here.
#
# /+ ----------------------------------------------------


Schemas.Tenant = new SimpleSchema
  space_id:
    type: String
    label: "Space"
    max: 50

  contact_id:
    type: String
    label: "Contact"
    max: 50

  entry_date:
    type: Date
    label: "Entry date"
    optional: true
    max: 50

  exit_date:
    type: Date
    label: "Exit date"
    optional: true
    max: 50
#      autoValue: () ->
#        this.field("entry_date")

  rent:
    type: Number
    decimal: true
    label: "Rent by month"
    optional: true


  charges:
    type: Number
    decimal: true
    label: "Charges by month"
    optional: true
    defaultValue: ->
      if @space_id
        space = Spaces.findOne(@space_id)
        space.rent
      else
        1000
  contract_type:
    type: String
    label: "Type of contract"
    allowedValues: ["Not furnished", "Furnished"]
    optional: true
    max: 50

  contract_duration:
    type: Number
    label: "contract duration in months"
    optional: true

  creation_date:
    type: Date
    label: "Creation date"
    defaultValue: new Date()






@Tenants = new Meteor.Collection "tenants"

Tenants.attachSchema(Schemas.Tenant)


#Tenants.simpleSchema().messages({
#    "regEx zip": "Your Zip Code can only be numeric and should have 5 characters!",
#});

# Allow/Deny
Tenants.allow
  insert: (tenantId, doc) ->
    can.createTenant tenantId

  update: (tenantId, doc, fieldNames, modifier) ->
    can.editTenant tenantId, doc

  remove: (userId, doc) ->
    !!userId

Tenants.helpers
  fullname: ->
    unless @contact_id
      @firstname + " " + @lastname
    else
      contact = Contacts.findOne(@contact_id)
      contact.firstname + " " + contact.lastname

  subscription_date: ->
    moment(Date(@creation_date)).format "DD MMMM"


# Methods
Meteor.methods
  createTenant: (tenant) ->

    #    if(can.createTenant(Meteor.tenant()))
    id = Tenants.insert(tenant)
    id

  removeTenant: (tenant) ->

    #    if(can.removeTenant(Meteor.tenant(), tenant)){
    #      console.log("removing tenant" + tenant._id);
    Tenants.remove tenant._id
    return


#    }else{
#      throw new Meteor.Error(403, 'You do not have the rights to delete this tenant.')
#    }