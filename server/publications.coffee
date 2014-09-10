# Buildings

Meteor.publish "allBuildings", ->
  Buildings.find()

Meteor.publish "todayBuildings", ->
  Buildings.find creation_date:
    $gte: moment().startOf("day").toDate()
    $lt: moment().add("days", 1).toDate()



# Publish a single item
Meteor.publish "singleBuilding", (id) ->
  Buildings.find id


# Spaces
# Publish all items
Meteor.publish "allSpaces", ->
  Spaces.find()

# Publish all items for building
Meteor.publish "buildingSpaces", (building_id) ->
  Spaces.find({building_id: building_id})

# Tenants
# Publish all
Meteor.publish "allTenants", ->
  Tenants.find()

# Communications
# Publish all
Meteor.publish "allCommunications", ->
  Communications.find()

# Communications
# Publish all
Meteor.publish "allDoctypes", ->
  Doctypes.find()

# Images
# Publish all
Meteor.publish "allImages", ->
  Images.find()

# banks
# Publish all
Meteor.publish "allFsbanks", ->
  Fsbanks.find()

# transactions
# Publish all
Meteor.publish "allTransactions", ->
  Transactions.find()

# invoices
# Publish all
Meteor.publish "allInvoices", ->
  Invoices.find()

# contacts
# Publish all
Meteor.publish "allContacts", ->
  Contacts.find()

# bank imports
# Publish all
Meteor.publish "allBkimports", ->
  Bkimports.find()

