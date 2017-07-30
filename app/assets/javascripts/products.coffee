$(document).on 'ready', ->
  $('#certified_fire_door_inspection').on 'click', (e) =>
    $('#fire_door_inspection').modal 'show'
  $('#cameras_and_security_assessments').on 'click', (e) =>
    $('#security_modal').modal 'show'
  $('#locksmith').on 'click', (e) =>
    $('#locksmith_modal').modal 'show'
