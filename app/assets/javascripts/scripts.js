$(document).ready(function() {
	
	"use strict";
	
	//Parallax

	//Get Browser prefix
	var prefix = (function () {
		var styles = window.getComputedStyle(document.documentElement, ''),
		pre = (Array.prototype.slice
			.call(styles)
			.join('') 
			.match(/-(moz|webkit|ms)-/) || (styles.OLink === '' && ['', 'o'])
		)[1];
		return {
			css: '-' + pre + '-'
		};
	})();

    $('.main-container section:first-child').addClass('first-child');

    if ($('.parallax-background').length) {
	    $('.parallax-background').each(function () {

	        if ($(this).closest('section').hasClass('first-child') && !$(this).closest('section').hasClass('slider-fullscreen')) {
	            $(this).attr('data-top', prefix.css + 'transform: translate3d(0px,0px, 0px)');
	            $(this).attr('data-top-bottom', prefix.css + 'transform: translate3d(0px,200px, 0px)');

	        } else {

	            $(this).attr('data-bottom-top', prefix.css + 'transform: translate3d(0px,-100px, 0px)');
	            $(this).attr('data-center', prefix.css + 'transform: translate3d(0px,0px, 0px)');
	            $(this).attr('data-top-bottom', prefix.css + 'transform: translate3d(0px,100px, 0px)');

	        }

	    });
	}

	$.stellar({
        horizontalScrolling: false,
        verticalScrolling: true,
        horizontalOffset: 0,
        verticalOffset: 0,
        responsive: true,
        parallaxBackgrounds: true,
        ratio: 0.9
    });

    //Set each full screen element height

    $('.fullscreen-element').each(function(){
		$(this).css('height', $(window).height()-125);
	});

    alignVertical();
   	halfMarginTop();
	
	$(window).resize(function(){
		alignVertical();
		halfMarginTop();
	});

	
	// Append .background-image-holder <img>'s as CSS backgrounds
	
	$('.background-image-holder').each(function(){
		var imgSrc= $(this).children('img').attr('src');
		$(this).css('background', 'url("' + imgSrc + '")');
    	$(this).children('img').hide();
        $(this).css('background-position', '50% 0%');
	});

	
	//Products Grid

	if ($('.products-container').length) {
		$('.products-container').isotope({
		  itemSelector: '.product',
		  layoutMode: 'fitRows'
		});
	}

	
	//Offscreen navigation

	if ($('.side-menu-opener').length) {
		$('.side-menu-opener').sidr({
			side: 'right',
			onOpen: function() {
				//Do something on OPEN
		    },
		    onClose: function() {
		    	//Do something on CLOSE
		    }
		});
	}

	
	//Hero Slider 

	if ($('.hero-slider').length ) {
    	$('.hero-slider').slick({
    		dots: true,
    		fade: true
    	});
    }


	//Team Carousel

	if ($('.team-carousel').length ) {

		$('.team-carousel').slick({
		  	centerMode: !0,
	        dots: !0,
	        arrows: !1,
	        accessibility: !0,
	        infinite: !0,
	        speed: 650,
	        centerPadding: "500px",
	        cssEase: "ease",
	        slidesToShow: 1,
	        draggable: !0,
	        responsive: [{
	            breakpoint: 1600,
	            settings: {
	                centerPadding: "300px"
	            }
	        }, {
	            breakpoint: 1200,
	            settings: {
	                centerPadding: "125px"
	            }
	        }, {
	            breakpoint: 991,
	            settings: {
	                centerPadding: "125px"
	            }
	        }, {
	            breakpoint: 768,
	            settings: {
	                centerPadding: "27px"
	            }
	        }]
		});

		// Show the active item on document ready
		$('.team-carousel .slick-current .member-info').css('opacity', '1');

		// On before slide change
		$('.team-carousel').on('beforeChange', function(event, slick, currentSlide, nextSlide){
			$('.slick-current .member-info').css('opacity', '0');
		});

		// On after slide change
		$('.team-carousel').on('afterChange', function(event, slick, currentSlide){
			$('.slick-current .member-info').css('opacity', '1');
		});
	}


	//Load more button

	if ($('.load-more').length ) {
		$('.load-more').click(function(e) {
			e.preventDefault();
			$(this).find('i').removeClass('fa-ellipsis-h').addClass('fa-circle-o-notch fa-spin fa-fw');
			return false;
		});
	}
 

	// Google maps

	if ($('#map').length) {
		google.maps.event.addDomListener(window, 'load', initialize_map('#map'));
	}


	// Lightbox

    if ($('.secondary-images').length) {
    	$('.secondary-images').magnificPopup({
			delegate: 'a', // child items selector, by clicking on it popup will open
			type: 'image',
			gallery: {
			  enabled: true, // set to true to enable gallery
			
			  preload: [0,2], // read about this option in next Lazy-loading section
			
			  navigateByImgClick: true,
			
			  arrowMarkup: '<button title="%title%" type="button" class="mfp-arrow mfp-arrow-%dir%"></button>', // markup of an arrow button
			
			  tPrev: 'Previous (Left arrow key)', // title for left button
			  tNext: 'Next (Right arrow key)', // title for right button
			  tCounter: '<span class="mfp-counter">%curr% of %total%</span>' // markup of counter
			}
		});
    }

    if ($('a.lightbox').length) {
	    $('a.lightbox').each(function() {
	    	$(this).magnificPopup({
	    		type: 'image'
	    	});
	    });
	}
});


function alignVertical() {

	$('.align-vertical').each(function(){
		var that = $(this);
			height = that.height(),
			parentHeight = that.parent().height(),
			padAmount = (parentHeight / 2) - (height/2);
		if (that.hasClass('hero')) {
			that.css('padding-top', padAmount+20);
		} else {
			that.css('padding-top', padAmount);
		}
	});
	
}

function halfMarginTop() {

	$('.half-margin-top').each(function(){
		var that = $(this);
			height = that.height()/2+40,
		
		that.css('margin-top', -height);
	});
	
}

function initialize_map(id) {

	var latitude = $(id).data('lat'),
		longitude = $(id).data('long');
  	var mapOptions = {
	    zoom: 16,
	    scrollwheel: false,
	    panControl: false,
	    zoomControl: false,
	    scaleControl: false,
	    disableDefaultUI: true,
	    center: new google.maps.LatLng(latitude, longitude)
  	}
  	var map = new google.maps.Map(document.getElementById('map'), mapOptions);
  	map.set('styles', [{"featureType":"water","elementType":"geometry","stylers":[{"color":"#e9e9e9"},{"lightness":17}]},{"featureType":"landscape","elementType":"geometry","stylers":[{"color":"#f5f5f5"},{"lightness":20}]},{"featureType":"road.highway","elementType":"geometry.fill","stylers":[{"color":"#ffffff"},{"lightness":17}]},{"featureType":"road.highway","elementType":"geometry.stroke","stylers":[{"color":"#ffffff"},{"lightness":29},{"weight":0.2}]},{"featureType":"road.arterial","elementType":"geometry","stylers":[{"color":"#ffffff"},{"lightness":18}]},{"featureType":"road.local","elementType":"geometry","stylers":[{"color":"#ffffff"},{"lightness":16}]},{"featureType":"poi","elementType":"geometry","stylers":[{"color":"#f5f5f5"},{"lightness":21}]},{"featureType":"poi.park","elementType":"geometry","stylers":[{"color":"#dedede"},{"lightness":21}]},{"elementType":"labels.text.stroke","stylers":[{"visibility":"on"},{"color":"#ffffff"},{"lightness":16}]},{"elementType":"labels.text.fill","stylers":[{"saturation":36},{"color":"#333333"},{"lightness":40}]},{"elementType":"labels.icon","stylers":[{"visibility":"off"}]},{"featureType":"transit","elementType":"geometry","stylers":[{"color":"#f2f2f2"},{"lightness":19}]},{"featureType":"administrative","elementType":"geometry.fill","stylers":[{"color":"#fefefe"},{"lightness":20}]},{"featureType":"administrative","elementType":"geometry.stroke","stylers":[{"color":"#fefefe"},{"lightness":17},{"weight":1.2}]}]);


  	var image = 'images/marker.png';
  	var myLatLng = new google.maps.LatLng(latitude, longitude);
  	var marker = new google.maps.Marker({
	    position: myLatLng,
	    map: map,
	    icon: image
  	});
}