InvoiceController = RouteController.extend(template: "invoices")
Router.map ->
  @route "invoices",
    path: "/invoices"
    waitOn: ->
      subs.subscribe "allInvoices"
      subs.subscribe "allTenants"
      subs.subscribe "allContacts"

    data: ->
      invoices: Invoices.find()

  @route "invoice",
    path: "/invoices/:_id"
    waitOn: ->
      subs.subscribe "allInvoices"

    data: ->
      invoice: Invoices.findOne(@params._id)
      invoices: Invoices.find()
