Meteor.methods
  createTransaction: (values, upsertValues) ->
    if upsertValues
      console.log "upserting transaction"
      console.log "transaction: #{values}"
      console.log "Values: #{upsertValues["entry_nbr"]}"
      Transactions.upsert upsertValues
      ,
        $set: values
      , (err, nbr) ->
        if err
          console.log err
        else
          console.log "upsert successful #{nbr}"
    else
      Transactions.insert values
      , (err, nbr) ->
        if err
          console.log err
        else
          console.log "insert successful #{nbr}"

  matchTransactions: () ->
    contacts = Contacts.find().fetch()
    console.log "contacts find #{contacts.length}"
    _.map contacts, (contact) ->
      #find on IBAN
      lookKeys = ["iban",["lastname","firstname"],["firstname","lastname"]]
      for i in [0..lookKeys.length - 1] by 1
        if _.isArray lookKeys[i]
          searchKey = ""
          for j in [0..lookKeys[i].length - 1] by 1
            searchKey = searchKey + " " + contact[lookKeys[i][j]]
        else
          searchKey = contact[lookKeys[i]]

        if searchKey
          console.log "searching by #{searchKey}"
          expression = new RegExp searchKey, "i"
          transactions = Transactions.find({status: "open", description: expression}).fetch()
          if transactions.length > 0
            Meteor.call "assignTransactions", transactions, contact
  assignTransactions: (transactions, contact) ->
    _.map transactions, (transaction) ->
      values = {}
      values["contact_id"] = contact._id
      values["status"] = "contact"
      Transactions.update(transaction._id, {$set: values})
      console.log "transaction updated"


