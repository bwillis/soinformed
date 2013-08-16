$(function ($) {


    $("#push-test").on("submit", function(){
        var data = $(this).serializeArray();
        $.each(data, function(){
            if(this.name == "checkin") {
                this.value = this.value.replace(/\r?\n/g, '');
                this.value = this.value.replace(/\s+/g, ' ');
            }
        });
        $.post($(this).attr("action"), data, function() {
            alert("Push test sent successfully!");
        }).fail(function() {
            alert("Failed push test, check the logs for more info!");
        });
        return false;
    });
});
