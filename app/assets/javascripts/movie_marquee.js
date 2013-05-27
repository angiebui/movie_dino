;( function( $, window, undefined ) {

  'use strict';

  // global
  var Modernizr = window.Modernizr;

  var Marquee = function( element ) {
    this.$el = $( element );
    this._init();
  };

  Marquee.prototype = {
    _init : function() {
      // cache some elements and initialize some variables
      this._config();
      // initialize/bind the events
      this._initEvents();
    },
    _config : function() {

      // the list of items
      this.$list = this.$el.children( 'ul' );
      // the items (li elements)
      this.$items = this.$list.children( 'li' );
      // total number of items
      this.itemsCount = this.$items.length;
      // support for CSS Transitions & transforms
      this.support = Modernizr.csstransitions && Modernizr.csstransforms;
      this.support3d = Modernizr.csstransforms3d;
      // transition end event name and transform name
      // transition end event name
      var transEndEventNames = {
          'WebkitTransition' : 'webkitTransitionEnd',
          'MozTransition' : 'transitionend',
          'OTransition' : 'oTransitionEnd',
          'msTransition' : 'MSTransitionEnd',
          'transition' : 'transitionend'
        },
      transformNames = {
        'WebkitTransform' : '-webkit-transform',
        'MozTransform' : '-moz-transform',
        'OTransform' : '-o-transform',
        'msTransform' : '-ms-transform',
        'transform' : 'transform'
      };

      if( this.support ) {
        this.transEndEventName = transEndEventNames[ Modernizr.prefixed( 'transition' ) ] + '.movieMarquee';
        this.transformName = transformNames[ Modernizr.prefixed( 'transform' ) ];
      }
      // current and old item´s index
      this.current = 0;
      this.old = 0;
      // check if the list is currently moving
      this.isAnimating = false;
      // the list (ul) will have a width of 100% x itemsCount
      this.$list.css( 'width', 1030 * this.itemsCount + 'px' );
      // apply the transition
      if( this.support ) {
        this.$list.css( 'transition', this.transformName + ' 500ms ease' );
      }
      // each item will have a width of 100 / itemsCount
      this.$items.css( 'width', '1030px' );
      // add navigation arrows if there is more than 1 item
      if( this.itemsCount > 1 ) {
        // add navigation arrows (the previous arrow is not shown initially):
        this.$navPrev = $( '<span class="marquee-prev"><i class="icon-angle-left"></i></span>' ).hide();
        this.$navNext = $( '<span class="marquee-next"><i class="icon-angle-right"></i></span>' );
        $( '<nav/>' ).append( this.$navPrev, this.$navNext ).appendTo( $('#movie-marquee-wrapper') );
      }

    },
    _initEvents : function() {
      
      if( this.itemsCount > 1 ) {
        this.$navPrev.on( 'click.movieMarquee', $.proxy( this._navigate, this, 'previous' ) );
        this.$navNext.on( 'click.movieMarquee', $.proxy( this._navigate, this, 'next' ) );
      }

    },
    _navigate : function( direction ) {

      // do nothing if the list is currently moving
      if( this.isAnimating ) {
        return false;
      }

      this.isAnimating = true;
      // update old and current values
      this.old = this.current;
      if( direction === 'next' && this.current < this.itemsCount - 1 ) {
        ++this.current;
        this._loadImages(); //comment out when we fix image load
      }
      else if( direction === 'previous' && this.current > 0 ) {
        --this.current;
      }
      // slide
      this._slide();

    },
    _slide : function() {

      // check which navigation arrows should be shown
      this._toggleNavControls();
      // translate value
      var translateVal = -1 * this.current * 100 / this.itemsCount;
      if( this.support ) {
        this.$list.css( 'transform', this.support3d ? 'translate3d(' + translateVal + '%,0,0)' : 'translate(' + translateVal + '%)' );
      }
      else {
        this.$list.css( 'margin-left', -1 * this.current * 100 + '%' ); 
      }
      
      var transitionendfn = $.proxy( function() {
        this.isAnimating = false;
      }, this );

      if( this.support ) {
        this.$list.on( this.transEndEventName, $.proxy( transitionendfn, this ) );
      }
      else {
        transitionendfn.call();
      }

    },
    _loadImages : function() {

      var current = this.current + 1;
      var list = this.$items[current];
      var $posters = $(list).find('div');

      $.each($posters, function() {
        var $label = $(this).find('label');
        console.log($label.css( 'backgroundImage' ));

        if($label.css( 'backgroundImage' ) == 'none') {
          $label.css( 'backgroundImage', 'url(' + $label.data( 'image-url' ) + ')');
        }

      });

    },
    _toggleNavControls : function() {

      // if the current item is the first one in the list, the left arrow is not shown
      // if the current item is the last one in the list, the right arrow is not shown
      switch( this.current ) {
        case 0 : this.$navNext.show(); this.$navPrev.hide(); break;
        case this.itemsCount - 1 : this.$navNext.hide(); this.$navPrev.show(); break;
        default : this.$navNext.show(); this.$navPrev.show(); break;
      }
    },
  };

  $.fn.movieMarquee = function() {
    
    this.each(function() {  
      var instance = $.data( this, 'movieMarquee' );
      if ( instance ) {
        instance._init();
      }
      else {
        instance = $.data( this, 'movieMarquee', new Marquee( this ) );
      }
    });

    // return this;
  };

} )( jQuery, window );