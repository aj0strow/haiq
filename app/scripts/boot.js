$(function () {
  $('script[type="x-mustache"]').each(function () {
    var $this = $(this);
    JST[ $this.attr('name') ] = Hogan.compile($this.text());
  });

  haiq.menu.attachTo('#menu');
});
