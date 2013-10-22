$('.contact-details-link').click(function(){
    $('.contact-details').slideDown();
    $(this).children("i").remove();
//        $('.contact-details-link').slideUp();
    return false;
});