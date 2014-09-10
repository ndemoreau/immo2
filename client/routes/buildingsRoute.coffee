BuildingController = RouteController.extend(template: "buildings")
Router.map ->
  @route "buildings",
    path: "/"
    waitOn: ->
      subs.subscribe "allBuildings"

    data: ->
      buildings: Buildings.find()

  @route "building",
    path: "/buildings/:_id"
    waitOn: ->
      subs.subscribe "allBuildings"

    data: ->
      building: Buildings.findOne(@params._id)
      buildings: Buildings.find()
