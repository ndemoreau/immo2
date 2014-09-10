Router.configure
  layoutTemplate: "basicLayout"
  loadingTemplate: "loading"
  notFoundTemplate: "notFound"
  mainYieldTemplates:
    footer:
      to: "footer"

    header:
      to: "header"

Router.onBeforeAction "loading"
Router.onBeforeAction ->
  $(".notification").remove()
Router.onRun ->
  Session.set("keyword_search","")

Router.onAfterAction ->
  setTimeout( ->
    $(".editable").editable
      placement: "right"
      display: ->
      success: (response, newValue) ->
        newVal = {}
        oldVal = $.trim $(this).data("value")
        name = $(this).data("name")
        newVal[name] = newValue
        eval($(this).data("context")).update $(this).data("pk"), $set: newVal
        , (error) ->
          if error
            Notifications.error error.message
          Meteor.defer -> $(".editable[data-name=" + name + "]").data('editableContainer').formOptions.value = oldVal
    $(".iban").mask "AA00 0000 0000 0000"
#    Session.set("previous_path",Router.current().path)
    if $(".full-height-panel")[0]
      set_full_height()
      $(window).resize ->
        console.log "resizing"
        set_full_height()
  ,0)


@subs = new SubsManager()

@getSubTemplate = (template,route) ->
  if route.ready()
    routeArray = route.path.split("/")
    if routeArray[route.length -1] = route.params._id
      template = "tenants"
    else
      template = routeArray[route.length -1]
    console.log "sub template: #{template}"
    route.render()
    templateName = template
    route.render templateName, to: 'subTemplate'
  else
    route.render 'loading'

