Template.doctypes.helpers
  total: -> Doctypes.find().count()
  compiled_content: ->


Template.doctypes.events
  'click #newDoctypeButton': ->
    $("#newDoctype").modal("show")

Template.doctypesList.rendered = ->
#  content = this.data.content
#  templateName = "template_#{this.data._id}"
#  template = Spacebars.compile content
#  console.log template
#  Template.__define__(templateName, content)
#  rendered = UI.renderWithData(eval("Template.#{templateName}"),{name: "nicolas"})
#  UI.insert(rendered, $("#content_" + this.data._id).get(0))


