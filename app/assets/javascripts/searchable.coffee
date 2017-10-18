$(document).on 'turbolinks:load', ->

  $('body').on 'keyup', '.searchable-field', ->
    $.ajax
      type: 'GET'
      url: 'questions'
      data: 'search': $('.searchable-field').val()
      dataType: "script"
  return

