if Buildings.find().count() is 0
  Buildings.insert
    name: "Champéry"
    address: "Rue Baucq 2"
    zip: 1050
    city: "Brussels"

if Spaces.find().count() is 0
  Spaces.insert
    building_id: Buildings.findOne()._id
    name: "Rez"
    rent: 600
    charges: 150
    contract_type: "Furnished"
  Spaces.insert
    building_id: Buildings.findOne()._id
    name: "1er"
    rent: 500
    charges: 100
    contract_type: "Furnished"

if Contacts.find().count() is 0
  Contacts.insert
    firstname: "Tim"
    lastname: "Howard"
    address: "Grand Street 1"
    zip: 1000
    city: "Brussels"
    country: "Belgium"
    email: "tim@howard.com"
  Contacts.insert
    firstname: "Tom"
    lastname: "Howard"
    address: "Grand Street 10"
    zip: 1000
    city: "Brussels"
    country: "Belgium"
    email: "tom@howard.com"

if Tenants.find().count() is 0
  Tenants.insert
    space_id: Spaces.find().fetch()[0]._id
    contact_id: Contacts.find().fetch()[0]._id
    entry_date: new Date("2014-06-01")
    contract_duration: 3
    exit_date: new Date("2014-09-30")
    rent: 800
    charges: 150
    contract_type: "Furnished"

  Tenants.insert
    space_id: Spaces.find().fetch()[1]._id
    contact_id: Contacts.find().fetch()[1]._id
    entry_date: "2014-06-01"
    contract_duration: 3
    exit_date: "2014-09-30"
    rent: 800
    charges: 150
    contract_type: "Furnished"




#
#  Participants.insert({
#      firstname: "Mike",
#      lastname: "Smith",
#      email: "mike@smith.com",
#      howknow: "Friend"
#  });

#
#if (Meteor.users.find().count() === 0) {
#
#    Accounts.createUser({
#        username: 'admin',
#        email: "admin@creativa.com",
#        password: "Ines"
#    });
#}