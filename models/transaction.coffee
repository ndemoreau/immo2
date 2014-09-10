@Transactions = new Meteor.Collection("transactions",
  schema:
    account_nbr:
      type: String
      label: "IBAN Account"
      max: 50

    entry_nbr:
      type: Number
      label: "Entry Nbr"
      optional: true

    value_date:
      type: Date
      label: "Value date"

    amount:
      type: Number
      decimal: true
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

    contact_id:
      type: String
      label: "contact_id"
      optional: true

    status:
      type: String
      label: "Status"
      defaultValue: "Open"


    creation_date:
      type: Date
      label: "Creation date"
      autoValue: () ->
        if @isInsert
          new Date()
        else
          if @isUpsert
            $setOnInsert: new Date
          else
            this.unset()


)

# Allow/Deny

#Transactions.allow({
#  insert: function(transactionId, doc){
#    return can.createTransaction(transactionId);
#  },
#  update:  function(transactionId, doc, fieldNames, modifier){
#    return can.editTransaction(transactionId, doc);
#  },
#  remove:  function(transactionId, doc){
#    return can.removeTransaction(transactionId, doc);
#  }
#});

# Methods
Meteor.methods

  importTransactions: (file) ->
    reader = new FileReader
    console.log file
    reader.readAsText file
    reader.onload = (event) ->
      data = $.csv.toObjects(event.target.result)
      console.log "File read #{data}"
      _.map data, (transaction) ->
        console.log transaction
        t = {}
        selectValues = {}
        date = transaction["Value date"]
        date_array = date.split("/")
        new_date = date_array[2] + "-" + date_array[1] + "-" + date_array[0]
        #          console.log new_date
        selectValues["account_nbr"] = transaction["Account number"]
        selectValues["value_date"] = new Date new_date
        selectValues["entry_nbr"] = parseInt transaction["Entry Number"]
        t["amount"] = transaction["Amount in the currency of the account"].replace(/\s/g, '')
        #          console.log t["amount"]
        t["description"] = transaction["Description"]
        Meteor.call "createTransaction", t, selectValues, (error, entry_nbr) ->
          if error
            console.log error
          else
            console.log id
  updateTransaction: (id, values, action) ->
    console.log "updating"
    if action == "assignContact"
      values["status"] = "contact"
      Contacts.update values.contact_id, {$inc: {open_transactions: 1}}
    if action == "removeContact"
      values["status"] = "open"
      Contacts.update values.contact_id, {$inc: {open_transactions: -1}}
    Transactions.update id,
      $set: values
    , (e, r) ->
      if Meteor.isClient
        console.log "Client!"
        if e
          Notifications.error e
        else
          Notifications.success 'Transaction updated!'
  removeTransaction: (transaction) ->

    #    if(can.removeTransaction(Meteor.transaction(), transaction)){
    #      console.log("removing transaction" + transaction._id);
    Transactions.remove transaction._id
    return
