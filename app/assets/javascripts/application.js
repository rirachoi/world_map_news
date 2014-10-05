// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require_tree .


// nav js
$(function() {
  $('#sdt_menu > li').bind('mouseenter',function(){
    var $elem = $(this);
    $elem.find('img')
       .stop(true)
       .animate({
        'width':'70px',
        'height':'70px',
        'left':'40px'
       },400,'easeOutBack')
       .andSelf()
       .find('.sdt_wrap')
         .stop(true)
       .animate({'top':'100px'},500,'easeOutBack')
       .andSelf()
       .find('.sdt_active')
         .stop(true)
       .animate({'height':'70px'},300,function(){
      var $sub_menu = $elem.find('.sdt_box');
      if($sub_menu.length){
        var left = '170px';
        if($elem.parent().children().length == $elem.index()+1)
          left = '-170px';
        $sub_menu.show().animate({'left':left},200);
      }
    });
  }).bind('mouseleave',function(){
    var $elem = $(this);
    var $sub_menu = $elem.find('.sdt_box');
    if($sub_menu.length)
      $sub_menu.hide().css('left','0px');

    $elem.find('.sdt_active')
       .stop(true)
       .animate({'height':'0px'},300)
       .andSelf().find('img')
       .stop(true)
       .animate({
        'width':'0px',
        'height':'0px',
        'left':'85px'},400)
       .andSelf()
       .find('.sdt_wrap')
       .stop(true)
       .animate({'top':'25px'},500);
  });


  // mobile nav


  $('.icon-menu').click(function() {
    $('.mobile-nav').animate({
      left: "0px"
    }, 200);
  });

  $('.icon-close').click(function() {
    $('.mobile-nav').animate({
      left: "-205px"
    }, 200);
  });

  $('.categories-index #vmap').hide();
  $('.countries-index #vmap').hide();
  $('.login-new #vmap').hide();
  $('#extruderLeft').hide();
  $('#user_category').show();

  $('.pages_index #msg').text('SELECT A COUNTRY ON THE MAP');
  $('.users_mynews #msg').text('SELECT A CATEGORY FOR A COUNTRY');
  $('.pages_about #msg').text('World Map News');
});
