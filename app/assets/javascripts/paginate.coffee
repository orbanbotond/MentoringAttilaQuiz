$ ->

  $("body").on "click", ".pagination a", ->
    $.getScript @href
    return false
