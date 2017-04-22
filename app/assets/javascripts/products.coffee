$(document).on 'ready', ->
  $('#fire_door_inspection').on 'click', (e) =>
    $('#fire_door_inspection').modal 'show'
  $('#security_services').on 'click', (e) =>
    $('#security_modal').modal 'show'
  $('#locksmith').on 'click', (e) =>
    $('#locksmith_modal').modal 'show'
