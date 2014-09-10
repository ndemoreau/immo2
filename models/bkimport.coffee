@Bkimports = new Meteor.Collection("bkimports",
  schema:
    account_nbr:
      type: String
      label: "IBAN Account"
      max: 50

    entry_nbr:
      type: Number
      label: "Entry Nbr"

    value_date:
      type: Date
      label: "Value date"

    amount:
      type: Number
      label: "Amount"

    description:
      type: String
      label: "Description"
      optional: true
      max: 250

    matching_id:
      type: String
      label: "matching_id"
      optional: true


    creation_date:
      type: Date
      label: "Creation date"
      defaultValue: new Date()

)

# Allow/Deny

#Bkimports.allow({
#  insert: function(bkimportId, doc){
#    return can.createBkimport(bkimportId);
#  },
#  update:  function(bkimportId, doc, fieldNames, modifier){
#    return can.editBkimport(bkimportId, doc);
#  },
#  remove:  function(bkimportId, doc){
#    return can.removeBkimport(bkimportId, doc);
#  }
#});

# Methods
Meteor.methods
  createBkimport: (bkimport) ->

    #    if(can.createBkimport(Meteor.bkimport()))
    p = bkimport
    p["creation_date"] = new Date()
    id = Bkimports.insert(p)
    return id

  removeBkimport: (bkimport) ->

    #    if(can.removeBkimport(Meteor.bkimport(), bkimport)){
    #      console.log("removing bkimport" + bkimport._id);
    Bkimports.remove bkimport._id
    return


#    }else{
#      throw new Meteor.Error(403, 'You do not have the rights to delete this bkimport.')
#    }