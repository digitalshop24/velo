$ ->
  $(document).on 'change', '#sportgood_sportgoods_category_id', (evt) ->
    $.ajax 'update_categories',
      type: 'GET'
      dataType: 'script'
      data: {
        category_id: $("#sportgood_sportgoods_category_id option:selected").val()
      }
      error: (jqXHR, textStatus, errorThrown) ->
        console.log("AJAX Error: #{textStatus}")
      success: (data, textStatus, jqXHR) ->
        console.log("Dynamic country select OK!")
