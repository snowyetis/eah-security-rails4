$(document).on 'turbolinks:load', ->
  $('#fire_door_inspection_button').on 'click', (e) =>
    $('#fire_door_inspection').modal 'show'
  $('#security_button').on 'click', (e) =>
    $('#security_modal').modal 'show'
  $('#locksmith_button').on 'click', (e) =>
    $('#locksmith_modal').modal 'show'
