# ---------------------------------------------------- +/
#
# ## Communications ##
#
# All code related to the Communications collection goes here. 
#
# /+ ---------------------------------------------------- 
@Communications = new Meteor.Collection("communications",
  schema:
    space_id:
      type: String
      label: "Space"
      max: 50

    firstname:
      type: String
      label: "First Name"
      optional: true
      max: 50

    lastname:
      type: String
      label: "Last Name"
      optional: true
      max: 50

    address:
      type: String
      label: "Address"
      max: 50

    address2:
      type: String
      label: "Address 2"
      max: 50
      optional: true

    email:
      type: String
      label: "E-mail"
      regEx: SimpleSchema.RegEx.Email
      optional: false
      max: 50

    phone:
      type: String
      label: "Phone"
      optional: true
      max: 50

    zip:
      type: String
      label: "Zip code"
      optional: true
      regEx: /^[0-9]{4,5}$/
      max: 50

    city:
      type: String
      label: "City"
      optional: true
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
      label: "Rent by month"
      optional: true
      max: 50

    costs:
      type: String
      label: "Costs by month"
      optional: true
      max: 50

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
      max: 50

    creation_date:
      type: Date
      label: "Creation date"
      defaultValue: new Date()
)

#Communications.simpleSchema().messages({
#    "regEx zip": "Your Zip Code can only be numeric and should have 5 characters!",
#});

# Allow/Deny
Communications.allow
  insert: (communicationId, doc) ->
    can.createCommunication communicationId

  update: (communicationId, doc, fieldNames, modifier) ->
    can.editCommunication communicationId, doc

  remove: (userId, doc) ->
    !!userId

# Methods
Meteor.methods
  createCommunication: (communication) ->

    #    if(can.createCommunication(Meteor.communication()))
    id = Communications.insert(communication)
    id

  removeCommunication: (communication) ->

    #    if(can.removeCommunication(Meteor.communication(), communication)){
    #      console.log("removing communication" + communication._id);
    Communications.remove communication._id
    return


#    }else{
#      throw new Meteor.Error(403, 'You do not have the rights to delete this communication.')
#    }