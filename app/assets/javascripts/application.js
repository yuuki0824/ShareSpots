// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require turbolinks
// マーカークラスターの読み込み
// download here! 
// https://github.com/googlemaps/js-marker-clusterer
//= reqire markerclusterer_compiled 
//= require moment
//= require bootstrap-datetimepicker
//= require underscore
//= require gmaps/google
//= require_tree .



  var data = {'data-date-format': 'YYYY-MM-DD hh:mm:ss' };
  $(function(){
    $('.datepicker').attr(data);
    $('.datepicker').datetimepicker();
  });
