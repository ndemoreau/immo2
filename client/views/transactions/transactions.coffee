Template.transactions.events
  'click #matchingButton': ->
    Meteor.call "matchTransactions"
  'click .filter': (e)->
    current_filter = Session.get("transactions_filters")
    new_filter = $(e.target).attr("data-toggle")
    if $.inArray(new_filter,current_filter) > -1
      current_filter.splice($.inArray(new_filter,current_filter), 1)
    else
      current_filter.push(new_filter)
    Session.set("transactions_filters", current_filter)
Template.transactions.helpers
  total: ->
    @transactions().count()

Template.transactions.rendered = ->



Template.transactionsTable.events
  'click .transaction-line': (e) ->
    console.log $(e.target).closest("tr").attr("data-transaction")
    Router.go "/transactions/#{$(e.target).closest("tr").attr("data-transaction")}"