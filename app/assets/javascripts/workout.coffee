# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$('.likes i, .dislikes i').on 'click', ->
  $.ajax
    dataType: 'script'
    type: 'POST'
    url: '/workout/rate_workout'
    data:
      id: $('#workout').val()
      type: $(this).data('type')
      user_id: $('#user').val()
    success: (data) ->
      $('.likes i').text JSON.parse(data).likes
      $('.dislikes i').text JSON.parse(data).dislikes
      return
  return