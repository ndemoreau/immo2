Handlebars.registerHelper "participantsCounter", ->
    Participants.find().count()

Handlebars.registerHelper "winnersCounter", ->
    Winners.find().count()

Handlebars.registerHelper "isActive", (template) ->
  currentRoute = Router.current().route.name
  if currentRoute and template is currentRoute then "active"
  else ""

Handlebars.registerHelper "fromNow", (date) ->
  moment(date).fromNow()

Handlebars.registerHelper "date", (date) ->
  moment(date).format("DD/MM/YYYY")

Handlebars.registerHelper "twitIcon", (icon, icon_text) ->
  twitIcon icon, icon_text

Handlebars.registerHelper "xtitle", (field) ->
  "Enter the " + Tenants.simpleSchema().label(field)

Handlebars.registerHelper "isActiveTransactionFilter", (filter) ->
  currentRoute = Router.current().route.name
  "badge-success" if $.inArray(filter,Session.get("transactions_filters")) > -1

Handlebars.registerHelper "statusIcon", (status, size) ->
  if status == "open"
    icon = "fa fa-folder-open red"
  else if status == "contact"
    icon = "fa fa-user orange"
  else if status == "to approve"
    icon = "fa fa-bookmark yellow"
  else if status == "closed"
    icon = "fa fa-check green"
  twitIcon icon, "", size

twitIcon = (icon, icon_text, size) ->
  the_html = "<i class='ace-icon " + size + " " + icon + "'></i>"
  if icon_text
    the_html = "<span> #{the_html} #{icon_text}</span>"
  return new Handlebars.SafeString the_html