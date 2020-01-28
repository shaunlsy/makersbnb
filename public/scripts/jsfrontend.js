"use strict"
window.addEventListener("load", function() {
    $(document).ready(function() {
        $(".log-in-button").click(function() {
            $("#log-in").slideToggle();
        })

        $(".sign-up-button").click(function() {
            $("#sign-up").slideToggle();
        })

    })
})