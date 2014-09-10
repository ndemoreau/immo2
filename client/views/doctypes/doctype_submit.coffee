Template.doctypeForm.events

  'keyup .wysihtml5-editor': ->
    content = $(".wysihtml5-sandbox").contents().find("body").text()
    console.log "content: " + content
    template = _.template content
    $("#preview").html(template({name: "Nico"}))

  'click #deleteDoctypeButton': (e, instance) ->
    e.preventDefault
    if confirm "Are you sure?"
      console.log "instance: #{Router.current().params._id}"
      Doctypes.remove(Router.current().params._id)
      Notifications.success 'Document template deleted'
      Router.go("doctypes")




#  'submit': (event) ->
#    event.preventDefault()
#    form = {}
#    $.each $("#insertDoctypeForm").serializeArray(), () ->
#      console.log "name:" + @name + "value:" + @value
#      form[@name] = @value
#    console.log "Creating... "
#    console.log Doctypes
#    if @doctype
#      Doctypes.update @_id,{$set: form}, (error, affectedDocs) ->
#        if error
#          throw new Meteor.Error(500, error.message)
#        else
#          return "Update Successful"
#    else
#      Doctypes.insert form
#    $("#newSpaceForm").modal("hide")

Template.newSpace.helpers
  building_id: -> Router.current().params._id


Template.doctypeForm.rendered =  ->
  editor_tenant = this.data.tenant
  $('.textarea').wysihtml5
    events:
      load: ->
        $(editor.composer.element).bind "keyup", ->
          content = $(".wysihtml5-sandbox").contents().find("body").html()
          template = _.template content
          $("#preview").html(template(editor_tenant))

  onChange = ->
    console.log "editor changed!"

#  $(editor.composer.element).bind "keyup", -> console.log "up"


Template.doctypeForm.helpers
  template_rendered: ->
    _.templateSettings = {
      interpolate: /\{\{(.+?)\}\}/g
    }
    if this.doctype and this.doctype.content
      template = _.template this.doctype.content
      return new Handlebars.SafeString template(this.tenant)
