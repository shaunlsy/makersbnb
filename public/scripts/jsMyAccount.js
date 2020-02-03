$(document).ready(function() {
  // Display buttons

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

  // Booking managment

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
})

// Chat functionality

// xmlGET
var httpGet = function(theUrl, callback) {
  var xmlHttp = new XMLHttpRequest()
  xmlHttp.onreadystatechange = function() {
    if (xmlHttp.readyState == 4 && xmlHttp.status == 200)
      callback(xmlHttp.responseText)
  }
  xmlHttp.open("GET", theUrl, true)
  xmlHttp.send(null)
}
// ===========


// xmlPOST
var httpPost = function(theUrl, data) {
  var xmlHttp = new XMLHttpRequest()
  xmlHttp.onreadystatechange = function() {
    if (xmlHttp.readyState == 4 && xmlHttp.status == 200)
      console.log(xmlHttp.responseText)
  }
  xmlHttp.open("POST", theUrl, true)
  xmlHttp.send(data)
}
// ===========


// Send message
var sendMessageObjs = document.getElementsByClassName("send-message")

var sendMessage = function(){
  var user_1 = this.getAttribute('data_user_1')
  var user_2 = this.getAttribute('data_user_2')
  var parent = this.parentNode
  var textbox = parent.querySelector('.add-message')
  var text = textbox.value
  textbox.value = ''
  var data = {'user_1': user_1, 'user_2': user_2, 'message': text}
  httpPost('/message', JSON.stringify(data))
}

for (var i = 0; i < sendMessageObjs.length; i++) {
    sendMessageObjs[i].addEventListener('click', sendMessage, false)
}
// ===========


// Messaging button
var messagingBtnObjs = document.getElementsByClassName("messaging-btn")

var startChat = function() {
  var user_1 = this.getAttribute('data_user_1')
  var user_2 = this.getAttribute('data_user_2')
  var listing = this.parentNode.parentNode.parentNode
  var chat = listing.querySelector('.chat')
  var chatbox = listing.querySelector('.chatbox')

  chatbox.innerHTML = "";
  chat.style.display = "block";
  this.style.display = "none";

  var dataLength = { num: 0 }

  var chatPoll = setInterval(function() {
    httpGet(`message/${user_1}/${user_2}`, function(data) {
      var jsonData = JSON.parse(data)
      var newLength = jsonData.length
      var difference = newLength - dataLength.num
      dataLength.num = newLength
      if (difference == 0) { return }
      jsonData = jsonData.slice(-1 * difference)
      jsonData.forEach(function(message) {
        var messageClass = (message['sender_id'] == user_1 ? 'user-1-message' : 'user-2-message')
        var dateStr = (new Date(message['time_inserted'])).toUTCString()
        chatbox.innerHTML += (
          `<div class='${messageClass}'>
            <div class='message-time' style=''>
              ${dateStr}
            </div>
            <div class='message-body'>
            ${message['message']}
            </div>
          </div>`
        )
      })
      chatbox.scrollTop = chatbox.scrollHeight;
    })
  }, 500)

  // Close messaging button
  var closeChatBtn = listing.querySelector('.close-messaging-btn')
  var closeMessaging = function(){
    var messagingBtn = listing.querySelector('.messaging-btn')
    clearInterval(chatPoll)
    chat.style.display = "none"
    messagingBtn.style.display = "block"
  }
  closeChatBtn.addEventListener('click', closeMessaging, false)
  // ===========
}

for (var i = 0; i < messagingBtnObjs.length; i++) {
  messagingBtnObjs[i].addEventListener('click', startChat, false)
}
