"use strict"
window.addEventListener("load", function() {
    $(document).ready(function() {
        $(".log-in-button").click(function() {
            $("#log-in").slideDown();
        })

        $(".sign-up-button").click(function() {
            $("#sign-up").slideDown();
        })

    })
})