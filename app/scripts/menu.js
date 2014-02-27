window.haiq.menu = flight.component(function () {
  this.defaultAttrs({
    haikus: {
      recent: {},
      me: {}
    }
  });

  this.transition = function () {
    return $('#content').children().fadeOut();
  };

  this.recent = function (ev) {
    ev.preventDefault();
    $.when($.getJSON('/haikus'), this.transition()).done(function () {
      console.log(arguments);
    });
  };

  this.me = function (ev) {
    ev.preventDefault();
  };

  this.after('initialize', function () {
    this.on('#recent', 'click', this.recent);
    this.on('#me', 'click', this.me);
  });
});
