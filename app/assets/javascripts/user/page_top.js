jQuery(function() {
  var pagetop = $('#page_top');
  pagetop.click(function () {
    $('body,html').animate({
        scrollTop: 0
    }, 900);
    return false;
  });
});
