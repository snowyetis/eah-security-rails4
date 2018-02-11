$(document).on 'ready', ->
  $('.more-product-detail-forms').on 'click', (e) ->
    $(this).on 'ajax:sucess', (event, data, status, xhr) ->
      productId = $(this).data('product_id')
      productDetailId = $(this).data('product_detail_id')
      $('#edit_product_detail_' + productDetailId).html(data)
      $('#product-details-paginator-' + productDetailId).html '<a id=\'more-product-details-detail-forms\' data-pd-id=' + productId + 'data-type=\'html\' data-remote=\'true\' href="/admins/products/' + productId +  '/product_details/'+ productDetailId + '/edit>Next Product Detail Record</a>'
