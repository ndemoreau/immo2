Template.buildings.helpers
  total: -> Buildings.find().count()

Template.buildings.events
  'click #newBuildingButton': ->
    $("#newBuilding").modal("show")

