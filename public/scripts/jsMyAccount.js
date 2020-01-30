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
      $("#trips").css('display', 'none');
      $("#trips").css('display', 'block');
    })

  })
})
