$(document).on 'ready', ->
  tbl_recs = $('#registrations-table')
  $('#btn_approve_users').on 'click', ->
    tbl_recs.find('tr').each (i, row) ->
      if i != 0
        targetrow = $(row).find('td')
        @userid = $(targetrow).eq(0).children().eq(0).attr('id')
        @apprv_cell = $(targetrow).eq(8).children().is(':checked')
        if @apprv_cell != false
          $.ajax
            type: 'PUT',
            dataType: 'JSON',
            url: '/admins/approve_user',
            data: { id: @userid, approved: @apprv_cell },
            success: (data) ->
              console.log data
              $('#notice').html data.email + ' has been approved successfully'
              toggleNavButton()
            error: (jqXHR, textStatus, errorThrown) ->
              $('#error').html 'There was an error approving the user'
              console.log textStatus
  toggleNavButton = () ->
    $.ajax
     datatype: 'json',
     type: 'GET',
     url: '/admins/signed_up?approved=true&id=btnApprove',
    #  data: {approved: true, id: 'btnApprove' },
     success: (data) ->
       console.log data
     error: (jqXHR, textStatus, errorThrown) ->
       console.log textStatus
