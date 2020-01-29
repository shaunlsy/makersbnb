"use strict"

window.addEventListener("load", function() {
  $(document).ready(function() {
    $(".log-in-button").click(function() {
      $("#log-in").slideToggle();
    })

    $(".sign-up-button").click(function() {
      $("#sign-up").slideToggle();
    })

    $(".listing").click(function() {
      var id = $(this).attr('id')
      $.get(`listing/${id}`, function(data) {
        $(`#extra${id}`).html(data)
      })
    })

    $("#create-listing").click(function() {
      $.get('create-listing', function(data) {
        $('.add-listing').html(data)
      })
    })

    // $(".extra").click(function() {
    //   var id = $(this).attr('id')
    //   $(`#${id}`).toggle()
    // })

  })
})
