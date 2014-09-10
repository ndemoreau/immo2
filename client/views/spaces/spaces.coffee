Template.spaces.helpers
  total: -> Spaces.find().count()

Template.buildingSpaces.events
  'click #newSpaceButton': ->
    UI.insert(UI.render(Template.newSpace),document.body)
    $("#newSpace").modal("show")

Template.spaces.events
  'click #newSpaceButton': ->
    $("#newSpace").modal("show")

Template.spacesList.rendered = ->
  console.log this.data

