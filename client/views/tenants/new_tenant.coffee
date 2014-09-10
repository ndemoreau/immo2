Template.newTenant.events
  'change .datepicker': (event) ->
    $(".datepicker").datepicker('hide')
  'change input.duration': (e) ->
    if ($("[name=entry_date]").val() != null and $("[name=contract_duration]").val() > 0)
      entry_date = new Date($("[name=entry_date]").val())
      exit_date = moment($("[name=entry_date]").val()).add('months', $("[name=contract_duration]").val()).subtract('d', 1).format('YYYY-MM-DD')
      $("[name=exit_date]").datepicker 'setDate', exit_date


  'click #cancelNewTenant': ->
    $("#newTenant").addClass("hidden")
    $("#tenantsList").removeClass("hidden")


AutoForm.hooks
  insertTenantForm:
    onError: (operation, error, template)->
      console.log operation, error
Template.newTenant.rendered =  ->
  $(".chosen-select").chosen
    width: "350px"
  $(".chosen-select").on "change", (event, params) ->
    if params.selected == "new_contact"
      $("#newContact").modal("show")
#    else
#      $("[name=contact_id] option[value='#{params.selected}']").attr("selected", "selected")
#  current: this.data.tenants.find({space_id: this.space._id}).sort("entry_date" => -1).limit(1).first()
  if this.data.current_tenant
    start =  moment(this.data.current_tenant.exit_date).add('d', 1).format('YYYY-MM-DD')
#  start = new Date()
  $('input[type=date]').datepicker
    format: "yyyy-mm-dd"
    startDate: start

Template.contactIds.helpers
  count: -> Contacts.find().count()
Template.contactIds.rendered = ->
  console.log this.data
