
$(document).on 'turbolinks:load', ->
  $('input[type="checkbox"]').on 'change', ->
    $('input[type="checkbox"]').not(this).prop 'checked', false
