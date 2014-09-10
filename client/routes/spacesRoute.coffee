SpaceController = RouteController.extend(template: "spaces")
Router.map ->
  @route "spaces",
    path: "/spaces"
    waitOn: ->
      [subs.subscribe("allSpaces"),
       subs.subscribe "allBuildings"]

    data: ->
      spaces: Spaces.find()
      buildings: Buildings.find()

  @route "space",
    path: "/spaces/:_id"
    waitOn: ->
      subs.subscribe "allSpaces"

    data: ->
      space: Spaces.findOne(@params._id)

  @route "buildingSpaces",
    path: "/buildings/:_id/spaces"
    template: "building"
    yieldTemplates: {
      'buildingSpaces': {to: "subTemplate"}
    }
    waitOn: ->
      [subs.subscribe("allSpaces"),
       subs.subscribe "allBuildings"]

    data: ->
      building: Buildings.findOne(@params._id)
      spaces: Spaces.find({building_id: @params._id})
      buildings: Buildings.find()
      building_id: @params._id


  @route "buildingSpaceDashboards",
    path: "/buildings/:_building_id/spaces/:_id/dashboards"
    template: "space"
    yieldTemplates: {
      'spaceTenants': {to: "subTemplate"}
    }
    waitOn: ->
      [subs.subscribe("allSpaces"),
       subs.subscribe "allBuildings",
         subs.subscribe "allTenants"
      ]

    data: ->
      building: Buildings.findOne(@params._building_id)
      space: Spaces.findOne(@params._id)
      tenants: Tenants.find({space_id: @params._id})

  @route "buildingSpaceTransactions",
    path: "/buildings/:_building_id/spaces/:_id/dashboards"
    template: "space"
    yieldTemplates: {
      'spaceTenants': {to: "subTemplate"}
    }
    waitOn: ->
      [subs.subscribe("allSpaces"),
       subs.subscribe "allBuildings",
         subs.subscribe "allTenants"
      ]

    data: ->
      building: Buildings.findOne(@params._building_id)
      space: Spaces.findOne(@params._id)
      tenants: Tenants.find({space_id: @params._id})

  @route "spaceSubmit",
    path: "/submit"
