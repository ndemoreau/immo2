# ---------------------------------------------------- +/
#
# ## Doctypes ##
#
# All code related to the Doctypes collection goes here. 
#
# /+ ---------------------------------------------------- 
@Doctypes = new Meteor.Collection("doctypes",
  schema:
    name:
      type: String
      label: "Name"
      max: 50

    category:
      type: String
      label: "Category"
      optional: true
      max: 50

    content:
      type: String
      label: "Content"
      optional: true

    creation_date:
      type: Date
      label: "Creation date"
      defaultValue: new Date()
)

# Allow/Deny

Doctypes.allow
  insert: (doctypeId, doc) ->
    can.createDoctype(doctypeId)
    true
  update:  (doctypeId, doc, fieldNames, modifier) ->
    can.editDoctype(doctypeId, doc)
    true
  remove:  (doctypeId, doc) ->
#    can.removeDoctype(doctypeId, doc)
    return true
