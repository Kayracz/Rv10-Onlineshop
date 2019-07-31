//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require_tree .
//= require toastr

(function() {
  $(function() {
    var toggle;
    return toggle = new Toggle('.toggle');
  });

  this.Toggle = (function() {
    Toggle.prototype.el = null;

    Toggle.prototype.tabs = null;

    Toggle.prototype.panels1 = null;

    function Toggle(toggleClass) {
      this.el = $(toggleClass);
      this.tabs = this.el.find(".tab");
      this.panels1 = this.el.find(".panel1");
      this.bind();
    }

    Toggle.prototype.show = function(index) {
      var activePanel1, activeTab;
      this.tabs.removeClass('active');
      activeTab = this.tabs.get(index);
      $(activeTab).addClass('active');
      this.panels1.hide();
      activePanel1 = this.panels1.get(index);
      return $(activePanel1).show();
    };

    Toggle.prototype.bind = function() {
      var _this = this;
      return this.tabs.unbind('click').bind('click', function(e) {
        return _this.show($(e.currentTarget).index());
      });
    };

    return Toggle;

  })();

}).call(this);
