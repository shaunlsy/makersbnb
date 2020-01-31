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
          console.log(test)
        })

        $("#mytripsbtn").click(function() {
            $("#bookings").css('display', 'none');
            $("#listings").css('display', 'none');
            $("#trips").css('display', 'block');
        })

        $("#accept-booking").click(function() {
            var booking_id = $(this).attr('value')
            $.ajax({
                url: `booking/${booking_id}`,
                type: 'PUT',
                success: function(response) {
                    console.log(`clicked ${booking_id}`)
                    console.log(response)
                }
            })
            $(`#${booking_id}`).fadeToggle()
        })

        $("#decline-booking").click(function() {
            var booking_id = $(this).attr('value')
            $.ajax({
                url: `booking/${booking_id}`,
                type: 'DELETE',
                success: function(response) {
                    console.log(`clicked ${booking_id}`)
                    console.log(response)
                }
            })
            $(`#${booking_id}`).fadeToggle()
        })

        $('.send-message').click(function(){
          var user_1 = $(this).attr('data_user_1')
          var user_2 = $(this).attr('data_user_2')
          var booking_id = $(this).attr('data_booking_id')
          var text = $(`#add-message${booking_id}`).val()
          var data = {'user_1': user_1, 'user_2': user_2, 'message': text}
          $.post('/message', JSON.stringify(data))
        })

    $('.messaging-btn').click(function(){
      var user_1 = $(this).attr('data_user_1')
      var user_2 = $(this).attr('data_user_2')
      var booking_id = $(this).attr('data_booking_id')
      console.log(user_1)
      console.log(user_2)
      $(this).hide()
      // $(`#close-messaging${booking_id}`).show()
      $(`#chat${booking_id}`).fadeToggle()
      updateChat(user_1, user_2, booking_id)
    })

    var updateChat = function(user_1, user_2, booking_id) {
      $.get(`message/${user_1}/${user_2}`, function(data) {
        var jsonData = JSON.parse(data)
        jsonData.forEach(function(message){
          var style = function() {
            if (message['sender_id'] == user_1) {
              return 'float:right;background: white;'
              }
            else {
              return 'float:left;background: blue;'
            }
          }
          $(`#chatbox${booking_id}`).append(
              `
              <div class='message' style='${style()}' >
                <div class='message_body'>
                ${message['message']}
                </div>
              </div>
              `
            )
        })
      })

    }

        var updateChat = function(user_1, user_2, booking_id) {

            $.get(`message/${user_1}/${user_2}`, function(data) {
                var jsonData = JSON.parse(data)
                jsonData.forEach(function(message) {
                    var style = function() {
                        if (message['sender_id'] == user_1) {
                            return 'float: right;background: white;'
                        } else {
                            return 'float: left;background: blue;'
                        }
                    }
                    var dateobj = new Date(message['time_inserted']);
                    $(`#chatbox${booking_id}`).append(
                        `
                        <div class='message_time' style=''>
                          ${dateobj.toUTCString()}
                        </div>
                        <div class='message' style='${style()}' >
                          <div class='message_body'>
                          ${message['message']}
                          </div>
                        </div>
                        `
                    )
                })
            })

        }

    })
})
