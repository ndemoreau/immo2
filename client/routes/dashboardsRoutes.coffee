DashboardController = RouteController.extend(template: "dashboards")
Router.map ->
  @route "dashboards",
    path: "/dashboards"
    waitOn: ->
      subs.subscribe "allDashboards"

    data: ->
      dashboards: Dashboards.find()

  @route "dashboard",
    path: "/dashboards/:_id"
    waitOn: ->
      subs.subscribe "allDashboards"

    data: ->
      dashboard: Dashboards.findOne(@params._id)

  @route "buildingDashboards",
    path: "/buildings/:_id/dashboards"
    template: "building"
    yieldTemplates: {
      'buildingDashboards': {to: "subTemplate"}
    }
    waitOn: ->
       subs.subscribe "allBuildings"

    data: ->
      building_id: @params._id
      building: Buildings.findOne(@params._id)
      currentTemplate: "buildingDashboards"

  @route "dashboardSubmit",
    path: "/submit"
