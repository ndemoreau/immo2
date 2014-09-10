Router.map ->
  @route "transactions",
    path: "/transactions"
    waitOn: ->
      [subs.subscribe "allTransactions",
        subs.subscribe "allContacts"]
    onBeforeAction: ->
      Session.set("transactions_filters", ["open","contact"])if Session.get("transactions_filters") == undefined

    data: ->
      transactions: ->
        conditions = {}
        conditions["status"] = {$in: Session.get("transactions_filters")}
        if Session.get("keyword_search") != ""
          expression = new RegExp Session.get("keyword_search"), "i"
          conditions["description"] = expression
        Transactions.find(conditions, {sort: {value_date: -1, entry_nbr: -1}})
      TransactionsCollection: Transactions
  @route "transaction",
    path: "/transactions/:_id"
    template: "transactions"
    waitOn: ->
      [subs.subscribe "allTransactions",
        subs.subscribe "allContacts",
        subs.subscribe "allBuildings"]
    onBeforeAction: ->
      Session.set("transactions_filters", ["open","contact"])if Session.get("transactions_filters") == undefined
      Session.set("contact_id_filter",null)

    data: ->
      transactions: ->
        conditions = {}
        conditions["status"] = {$in: Session.get("transactions_filters")}
        if Session.get("keyword_search") != ""
          expression = new RegExp Session.get("keyword_search"), "i"
          conditions["description"] = expression
        Transactions.find(conditions, {sort: {value_date: -1, entry_nbr: -1}})
      transaction: Transactions.findOne(@params._id)
      building: Buildings.find()


