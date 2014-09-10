Template.breadcrumb.events
  "keyup #keyword-search": (event, template) ->
    Session.set("keyword_search",$(event.target).val())
  "click #cancel-keyword-search": ->
    $("#keyword-search").val("")
    Session.set("keyword_search","")
Template.breadcrumb.helpers
  keyword_search: -> Session.get "keyword_search"