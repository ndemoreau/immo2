# ---------------------------------------------------- +/
#
# ## Invoices ##
#
# All code related to the Invoices collection goes here.
#
# /+ ----------------------------------------------------
@Invoices = new Meteor.Collection("invoices",
  schema:
    invoice_type:
      type: String
      label: "Invoice type"
      allowedValues: ["sales","purchases","credit note sales","credit note purchases"]
      optional: true
      max: 50
    invoice_nbr:
      type: Number
      label: "Invoice nbr"
      autoValue: ->
        last_invoice = Invoices.findOne({}, {sort: {invoice_nbr: -1}} )
        if last_invoice
          number = last_invoice.invoice_nbr + 1
        else
          number = 1
        console.log number
        return number
    building_id:
      type: String
      label: "Building"
      max: 50
      optional: true
    space_id:
      type: String
      label: "Space"
      max: 50
      optional: true

    contact_id:
      type: String
      label: "Contact"
      max: 50
    tenant_id:
      type: String
      label: "Tenant"
      max: 50
      optional: true
    address:
      type: String
      label: "Address"
      max: 50
      optional: true
    address2:
      type: String
      label: "Address 2"
      max: 50
      optional: true
    email:
      type: String
      label: "E-mail"
      regEx: SimpleSchema.RegEx.Email
      optional: false
      max: 50
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
    country:
      type: String
      label: "Country"
      optional: true
      max: 50
    invoice_date:
      type: Date
      label: "invoice date"
      defaultValue: new Date()
      optional: true
    amount:
      type: Number
      decimal: true
      label: "Amount"
      optional: true
    description:
      type: String
      label: "description"
      optional: true
    status:
      type: String
      label: "Status"
      optional: true
    matching_id:
      type: String
      label: "Matching Id"
      optional: true
    creation_date:
      type: Date
      label: "Creation date"
      defaultValue: new Date()
      optional: true

)

# Allow/Deny
Invoices.allow
  insert: (invoiceId, doc) ->
    can.createInvoice invoiceId

  update: (invoiceId, doc, fieldNames, modifier) ->
    can.editInvoice invoiceId, doc

  remove: (userId, doc) ->
    !!userId

Invoices.helpers
  contact: ->
    contact = Contacts.findOne(@contact_id)

  subscription_date: ->
    moment(Date(@creation_date)).format "DD MMMM"
  month: ->
    moment(@invoice_date).format("MMMM")


# Methods
Meteor.methods
  createInvoice: (invoice) ->

    #    if(can.createInvoice(Meteor.invoice()))
    id = Invoices.insert(invoice)
    id

  removeInvoice: (invoice) ->

    #    if(can.removeInvoice(Meteor.invoice(), invoice)){
    #      console.log("removing invoice" + invoice._id);
    Invoices.remove invoice._id
    return


#    }else{
#      throw new Meteor.Error(403, 'You do not have the rights to delete this invoice.')
#    }

  generateRentInvoices: (space)->
    current_date = new Date
    current_moment = moment(current_date).startOf('month')._d
    tenants = Tenants.find(exit_date: {$gte: current_moment})
    console.log "tenants found: #{tenants.length}"
    tenants.forEach (tenant) ->
      inv_values = {}
      upsert_values = {}
      inv_values["invoice_type"] = "sales"
      inv_values["building_id"] = space.building_id
      inv_values["space_id"] = space._id
      inv_values["contact_id"] = tenant.contact_id
      upsert_values["tenant_id"] = tenant._id
      contact = Contacts.findOne(tenant.contact_id)
      inv_values["address"] = contact.address
      inv_values["address2"] = contact.address2
      inv_values["zip"] = contact.zip
      inv_values["city"] = contact.city
      inv_values["country"] = contact.country
      inv_values["email"] = contact.email
      base_amount = tenant.rent + tenant.charges
      if tenant.exit_date > moment(current_date).endOf("month")._d
        inv_values["amount"] = base_amount
      else
        nbr_days = moment(current_date).endOf("month").date()
        exit_day = moment(tenant.exit_date).date()
        inv_values["amount"] = exit_day / nbr_days * base_amount
      inv_values["description"] = "Rent + charges #{moment(current_date).format("MMM")}"
      upsert_values["invoice_date"] = current_moment
      Invoices.upsert upsert_values
      ,
        $set: inv_values
      , (err, nbr) ->
        if err
          console.log err
        else
          console.log "upsert successful #{nbr}"


      console.log "Generate Invoice for tenant #{tenant._id}"

