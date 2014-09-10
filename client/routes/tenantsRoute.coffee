TenantController = RouteController.extend(template: "tenants")

Router.map ->
  @route "tenants",
    path: "/tenants"
    waitOn: ->
      [subs.subscribe("allTenants"),
       subs.subscribe "allBuildings"]

    data: ->
      tenants: Tenants.find()
      buildings: Buildings.find()

  @route "tenant",
    path: "/tenants/:_id"
    waitOn: ->
      subs.subscribe "allTenants"

    data: ->
      tenant: Tenants.findOne(@params._id)

  @route "buildingSpaceTenants",
    path: "/buildings/:_building_id/spaces/:_id/tenants"
    template: "space"
    yieldTemplates: {
      'spaceTenants': {to: "subTemplate"}
    }
    waitOn: ->
      [subs.subscribe("allSpaces"),
       subs.subscribe "allBuildings",
       subs.subscribe "allTenants",
       subs.subscribe "allContacts"
      ]

    data: ->
      building: Buildings.findOne(@params._building_id)
      space: Spaces.findOne(@params._id)
      building_spaces: Spaces.find({building_id: @params._building_id})
      current_tenant: Tenants.findOne({space_id: @params._id}, {sort: {"entry_date": -1}, limit : 1})
      contacts: Contacts.find({},{sort:{"lastname": 1}})
      space_id: @params._id

  @route "buildingSpaceTenant",
    path: "/buildings/:_building_id/spaces/:_space_id/tenants/:_id"
    template: "space"
    action: -> getSubTemplate(Session.get("current_tenant_subtemplate"),this)
    waitOn: ->
      [subs.subscribe("allSpaces"),
       subs.subscribe "allBuildings",
       subs.subscribe "allTenants",
       subs.subscribe "allCommunications"
      ]

    data: ->
      building: Buildings.findOne(@params._building_id)
      space: Spaces.findOne(@params._space_id)
      tenant: Tenants.findOne(@params._id)
      tenants: Tenants.find({space_id: @params._space_id})
      building_spaces: Spaces.find({building_id: @params._building_id})
      current_tenant: Tenants.findOne({space_id: @params._id}, {sort: {"entry_date": -1}, limit : 1})

  @route "buildingSpaceTenantCommunications",
    path: "/buildings/:_building_id/spaces/:_space_id/tenants/:_id/communications"
    template: "tenant"
    yieldTemplates: {
      'tenantCommunications': {to: "subTemplate"}
    }
    waitOn: ->
      [subs.subscribe("allSpaces"),
       subs.subscribe "allBuildings",
         subs.subscribe "allTenants",
           subs.subscribe "allCommunications"
      ]

    data: ->
      building: Buildings.findOne(@params._building_id)
      space: Spaces.findOne(@params._space_id)
      tenant: Tenants.findOne(@params._id)
      tenants: Tenants.find({space_id: @params._id})
      building_spaces: Spaces.find({building_id: @params._building_id})
      current_tenant: Tenants.findOne({space_id: @params._id}, {sort: {"entry_date": -1}, limit : 1})

  @route "xwidgets",
    path: "/xwidgets"
    template:"form"
