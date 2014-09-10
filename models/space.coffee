# ---------------------------------------------------- +/
#
# ## Spaces ##
#
# All code related to the Spaces collection goes here. 
#
# /+ ---------------------------------------------------- 
@Spaces = new Meteor.Collection("spaces",
  schema:
    building_id:
      type: String
      label: "Building"
      max: 50

    name:
      type: String
      label: "Name"
      optional: true
      max: 50

    rent:
      type: Number
      label: "Rent"
      optional: true

    charges:
      type: Number
      label: "Charges"
      optional: true

    contract_type:
      type: String
      label: "Contract type"
      optional: true
      allowedValues: ["Not furnished", "Furnished"]

    creation_date:
      type: Date
      label: "Creation date"
      defaultValue: new Date()
)

#Spaces.simpleSchema().messages({
#    "regEx zip": "Your Zip Code can only be numeric and should have 5 characters!",
#});

# Allow/Deny
Spaces.allow
  insert: (spaceId, doc) ->
    can.createSpace spaceId

  update: (spaceId, doc, fieldNames, modifier) ->
    can.editSpace spaceId, doc

  remove: (userId, doc) ->
    !!userId

Spaces.helpers
  fullname: ->
    participant = Participants.findOne(@participant_id)
    participant.firstname + " " + participant.lastname

  subscription_date: ->
    moment(Date(@creation_date)).format "DD MMMM"


# Methods
Meteor.methods
  createSpace: (space) ->

    #    if(can.createSpace(Meteor.space()))
    id = Spaces.insert(space)
    id

  removeSpace: (space) ->

    #    if(can.removeSpace(Meteor.space(), space)){
    #      console.log("removing space" + space._id);
    Spaces.remove space._id
    return


#    }else{
#      throw new Meteor.Error(403, 'You do not have the rights to delete this space.')
#    }