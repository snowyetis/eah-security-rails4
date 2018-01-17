$(document).on 'ready', ->
  $('.btnCreateProduct').on 'click', (e) =>
    $('#create_product_modal').modal 'show'
