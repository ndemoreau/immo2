Schemas.Building = new SimpleSchema
  name:
    type: String
    label: "Name"
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

  nbr_spaces:
    type: Number
    label: "number spaces"
    optional: true


  creation_date:
    type: Date
    label: "Creation date"
    defaultValue: new Date()


@Buildings = new Meteor.Collection "buildings"

Buildings.attachSchema(Schemas.Building)

Buildings.simpleSchema().messages
  "regEx zip": "Your Zip Code can only be numeric and should have 5 characters!",

# Allow/Deny

#Buildings.allow({
#  insert: function(buildingId, doc){
#    return can.createBuilding(buildingId);
#  },
#  update:  function(buildingId, doc, fieldNames, modifier){
#    return can.editBuilding(buildingId, doc);
#  },
#  remove:  function(buildingId, doc){
#    return can.removeBuilding(buildingId, doc);
#  }
#});

# Methods
Meteor.methods
  createBuilding: (building) ->
    
    #    if(can.createBuilding(Meteor.building()))
    p = building
    p["creation_date"] = new Date()
    id = Buildings.insert(p)
    return id

  removeBuilding: (building) ->
    
    #    if(can.removeBuilding(Meteor.building(), building)){
    #      console.log("removing building" + building._id);
    Buildings.remove building._id
    return


#    }else{
#      throw new Meteor.Error(403, 'You do not have the rights to delete this building.')
#    }