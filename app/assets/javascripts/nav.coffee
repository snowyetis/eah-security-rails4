$(document).ready (e) ->
  $('#primary_nav').scrollToFixed()
  $('.res-nav_click').click ->
    $('.main-nav').slideToggle()
    false
  return
$(window).load ->
  $('.main-nav li a, .servicelink').bind 'click', (event) ->
    $anchor = $(this)
    $('html, body').stop().animate { scrollTop: $($anchor.attr('href')).offset().top - 102 }, 1500, 'easeInOutExpo'

    ###
    if you don't want to use the easing effects:
    $('html, body').stop().animate({
    	scrollTop: $($anchor.attr('href')).offset().top
    }, 1000);
    ###

    if $(window).width() < 768
      $('.main-nav').hide()
    event.preventDefault()
    return
  return
