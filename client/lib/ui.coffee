@set_full_height = ->
  Session.set("full-height", $(window).height() - $(".full-height-panel").offset().top)
  transactions_height = parseInt(Session.get("full-height")) + "px"
  $(".full-height-panel").css("height", transactions_height)