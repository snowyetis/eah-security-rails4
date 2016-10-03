$(document).on 'turbolinks:load', ->
  $('#registrations-table').on 'click', 'input[type="checkbox"]', (e) ->
    @id = $(this).val()
    @approved = false
    if $(this).is(':checked')
      @approved = true
    else
      @approved = false
    $.ajax
      type: 'PUT'
      url: '/admins/approve_user'
      data: { id: @id, approved: @approved }
      success: (data) ->
        console.log data
      error: (jqXHR, textStatus, errorThrown) ->
        console.log textStatus
    return
  $(document).on 'click', '#filterTabs', (e) ->
    e.preventDefault
    if $(this).find('.filter-pill').hasClass 'active'
      $(this).find('.filter-pill').removeClass 'active'
      $(this).find('.filter-pill2').addClass 'active'
    else
      $(this).find('.filter-pill').addClass 'active'
      $(this).find('.filter-pill2').removeClass 'active'
  return
