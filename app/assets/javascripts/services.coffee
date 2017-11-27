$(window).load ->
  $container = $('.portfolioContainer')
  $body = $('body')
  colW = 375
  columns = null
  $container.isotope
    resizable: true
    masonry: columnWidth: colW
  $(window).smartresize(->
    # check if columns has changed
    currentColumns = Math.floor(($body.width() - 30) / colW)
    if currentColumns != columns
      # set new column count
      columns = currentColumns
      # apply width to container manually, then trigger relayout
      $container.width(columns * colW).isotope 'reLayout'
    return
  ).smartresize()
  # trigger resize to set container width
  $('.portfolioFilter a').click ->
    $('.portfolioFilter .current').removeClass 'current'
    $(this).addClass 'current'
    selector = $(this).attr('data-filter')
    $container.isotope filter: selector
    false
  return
