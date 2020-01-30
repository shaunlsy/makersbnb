"use strict"

window.addEventListener("load", function() {
  $(document).ready(function() {

    $("#mylistingsbtn").click(function() {
      $("#bookings").css('display', 'none');
      $("#trips").css('display', 'none');
      $("#listings").css('display', 'block');
    })

    $("#mybookingsbtn").click(function() {
      $("#listings").css('display', 'none');
      $("#trips").css('display', 'none');
      $("#bookings").css('display', 'block');
    })

    $("#mytripsbtn").click(function() {
      $("#bookings").css('display', 'none');
      $("#listings").css('display', 'none');
      $("#trips").css('display', 'block');
    })

    $("#accept-booking").click(function() {
      var booking_id = $(this).attr('value')
      $.ajax({url: `booking/${booking_id}`, type: 'PUT', success: function(response) {
        console.log(`clicked ${booking_id}`)
        console.log(response)
      }})
      $(`#${booking_id}`).fadeToggle()
    })

    $("#decline-booking").click(function() {
      var booking_id = $(this).attr('value')
      $.ajax({url: `booking/${booking_id}`, type: 'DELETE', success: function(response) {
        console.log(`clicked ${booking_id}`)
        console.log(response)
      }})
      $(`#${booking_id}`).fadeToggle()
    })

  })
})
