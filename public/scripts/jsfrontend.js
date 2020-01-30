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

        date_selector(jsonData['date_range'], id)

        $(`#extra${id} .extra-title`).text(jsonData.list_name)
        $(`#extra${id} .extra-description`).text(jsonData.short_description)
        $(`#extra${id} .extra-price`).text(jsonData.price_per_night)
        $(`#extra${id} .book-space`).attr('value', `${jsonData.listing_id}`)
      })
      $(`#extra${id}`).fadeToggle()
    })
  
    var date_selector = function(blocked_dates, listing) {
      var minDate = new Date();

      var array = blocked_dates
      
        $(`#startdatepicker${listing}`).datepicker({
          minDate: minDate,
          beforeShowDay: function(date){
            var string = jQuery.datepicker.formatDate('yy-mm-dd', date);
            return [ array.indexOf(string) == -1 ]
          },
          onClose: function(selectedDate) {
            $(`#enddatepicker${listing}`).datepicker("option", "minDate", selectedDate)
          }
        });
        $(`#enddatepicker${listing}`).datepicker({
          minDate: minDate,
          beforeShowDay: function(date){
            var string = jQuery.datepicker.formatDate('yy-mm-dd', date);
            return [ array.indexOf(string) == -1 ]
          }
        });
    };

  })
})
