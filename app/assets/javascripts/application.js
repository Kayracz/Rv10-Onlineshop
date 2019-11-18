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






// Set the date we're counting down to
var countDownDate = new Date("Nov 30, 2019 15:37:25").getTime();

// Update the count down every 1 second
var x = setInterval(function() {

  // Get today's date and time
  var now = new Date().getTime();

  // Find the distance between now and the count down date
  var distance = countDownDate - now;

  // Time calculations for days, hours, minutes and seconds
  var days = Math.floor(distance / (1000 * 60 * 60 * 24));
  var hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
  var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
  var seconds = Math.floor((distance % (1000 * 60)) / 1000);

	const demo = document.getElementById("demo");
	if (demo) {
		// Display the result in the element with id="demo"
		demo.innerHTML = days + "d " + hours + "h "
			+ minutes + "m " + seconds + "s ";

		// If the count down is finished, write some text
		if (distance < 0) {
			clearInterval(x);
			demo.innerHTML = "EXPIRED";
		}
	}
}, 1000);



$(function () {
  $(document).scroll(function () {
    var $nav = $(".navbar-fixed-top");
    $nav.toggleClass('scrolled', $(this).scrollTop() > $nav.height());
  });
});





