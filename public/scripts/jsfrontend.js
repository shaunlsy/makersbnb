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
      var minDate = new Date();
      var array = ['2020-02-01','2020-02-02', '2020-02-03', '2020-02-17', '2020-02-18']
        $("#startdatepicker").datepicker({
          minDate: minDate,
          beforeShowDay: function(date){
            var string = jQuery.datepicker.formatDate('yy-mm-dd', date);
            return [ array.indexOf(string) == -1 ]
          },
          onClose: function(selectedDate) {
            $("#enddatepicker").datepicker("option", "minDate", selectedDate)
          }
        });
        $("#enddatepicker").datepicker({
          minDate: minDate,
          beforeShowDay: function(date){
            var string = jQuery.datepicker.formatDate('yy-mm-dd', date);
            return [ array.indexOf(string) == -1 ]
          },
          onClose: function(selectedDate) {
            $("#startdatepicker").datepicker("option", "minDate", selectedDate)
          }
        });
    });

  })
})
