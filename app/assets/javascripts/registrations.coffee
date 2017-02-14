$(document).on 'click', '#new_registration input[type=\'radio\']', (e) ->
  if $('#payment_method_card:checked').val() == 'card'
    $('fieldset.card_info').show()
  else
    $('fieldset.card_info').hide()
  return
$('form#new_registration').submit ->
  $(this).find('input[type=submit]').attr 'disabled', 'disabled'
  $(this).find('input[type=submit]').val 'Submitting, please wait ...'
  return
