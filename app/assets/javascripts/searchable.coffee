$(document).on 'turbolinks:load', ->

  $('body').on 'keyup', '.searchable-field', ->
    $.ajax
      type: 'GET'
      url: 'questions'
      data: {
        'search_term': $('.searchable-field').val(), 
        'category': $('.category-selector').val()
      }
      dataType: "script"
  return


$(document).on 'turbolinks:load', ->

  $('body').on 'click', '.category-selector', ->
    $.ajax
      type: 'GET'
      url: 'questions'
      data: {
        'search_term': $('.searchable-field').val(), 
        'category': $('.category-selector').val()
      }
      dataType: "script"
  return

