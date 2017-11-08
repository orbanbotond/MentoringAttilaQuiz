# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', ->
  $("#check_all").change ->
    checkBoxes = document.getElementsByName("categories[]")
    for checkBox in checkBoxes
      checkBox.checked = document.getElementById("check_all").checked
    return false
