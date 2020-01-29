"use strict"

window.addEventListener("load", function() {
  $(document).ready(function() {
    $(".log-in-button").click(function() {
      $("#log-in").slideToggle();
    })

    $(".sign-up-button").click(function() {
      $("#sign-up").slideToggle();
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

    $("#create-listing").click(function() {
      $('.add-listing').fadeToggle()
    })

    $("#myaccount").click(function() {
      window.location.href = "/myaccount"
    })

  })
})
