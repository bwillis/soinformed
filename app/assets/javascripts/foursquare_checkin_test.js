$(function ($) {
    console.log("hi")
    $("#push-test").on("ajax:success", function() {
        alert("Push test sent successfully!");
    }).bind("ajax:error", function() {
        alert("Failed push test, check the logs for more info!");
    });
});
