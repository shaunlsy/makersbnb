"use strict"

window.addEventListener("load", function() {
  $(document).ready(function() {
    $("#login-btn").click(function() {
      $("#log-in").slideToggle();
    })

    $("#register-btn").click(function() {
      $("#sign-up").slideToggle();
    })

    $("#create-listing").click(function() {
      $('.add-listing').fadeToggle()
    })

    $(".listing-outline").click(function() {
      var id = $(this).attr('id')
      $.get(`listing/${id}`, function(data) {
        var jsonData = JSON.parse(data)
        $(`#extra${id} .extra-title`).text(jsonData.list_name)
        $(`#extra${id} .extra-description`).text(jsonData.short_description)
        $(`#extra${id} .extra-price`).text(jsonData.price_per_night)
        $(`#extra${id} .book-space`).atrr('value', `${jsonData.listing_id}`)
      })
      $(`#extra${id}`).fadeToggle()
    })
  
    $(function() {
        $("#startdatepicker").datepicker();
        $("#enddatepicker").datepicker();
    });

  })
})
