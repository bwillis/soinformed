$(function ($) {
    $('div.btn-group[data-toggle-name]').each(function () {
        var group = $(this);
        var form = group.parents('form').eq(0);
        var name = group.attr('data-toggle-name');
        var hidden = $('input[name=\'' + name + '\']', form);
        $('a', group).each(function () {
            var groupLink = $(this);
            groupLink.on('click', function () {
                hidden.val($(this).attr('data-value'));
                $('a', group).removeClass('active');
                groupLink.addClass('active');
                return false;
            });
            if (groupLink.attr('data-value') == hidden.val()) {
                groupLink.addClass('active');
            }
        });
    });
    
    $('.contact-details-link').click(function(){
        $('.contact-details').slideDown();
        $(this).children("i").remove();
//        $('.contact-details-link').slideUp();
        return false;
    });
});
